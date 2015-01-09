#!/bin/bash
function insert(){
	sed -i '/<project name=*/ a xmlns:ekstazi="antlib:org.ekstazi.ant"' build.xml
	sed -i '/<\/project>/i <taskdef uri="antlib:org.ekstazi.ant" resource="org/ekstazi/ant/antlib.xml">\
	<classpath path="org.ekstazi.core-4.5.2.jar"/>\
	<classpath path="org.ekstazi.ant-4.5.2.jar"/>\
	</taskdef>' build.xml
	sed -i '/<junit*/i <ekstazi:select>' build.xml
	sed -i '/<\/junit>/a </ekstazi:select>' build.xml
}
cd ~
rm -rf zookeeper
git clone https://github.com/apache/zookeeper
cd zookeeper
wget http://www.ekstazi.org/release/org.ekstazi.core-4.5.2.jar
wget http://www.ekstazi.org/release/org.ekstazi.ant-4.5.2.jar
rev1=`git log | grep "^commit " | head -n 3 | tail -n 1 | cut -c 8-14`
rev2=`git log | grep "^commit " | head -n 2 | tail -n 1| cut -c 8-14`
git reset --hard "${rev1}"
insert
echo "dependencies.ignored.paths = /Info" >> .ekstazirc
ant test >> output${rev1}.txt
wait
ant test >> output${rev1}again.txt
wait
git reset --hard "${rev2}"
insert
ant test >> output${rev2}.txt
wait
echo "Result for ${rev1}:"
grep -c "\[junit]" output${rev1}.txt
echo "Result for ${rev1} again:"
grep -c "\[junit]" output${rev1}again.txt
echo "Result for ${rev2}:"
grep -c "\[junit]" output${rev2}.txt



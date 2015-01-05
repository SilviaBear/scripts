#!/bin/bash
cd ~
git clone https://github.com/apache/zookeeper
cd zookeeper
wget http://www.ekstazi.org/release/org.ekstazi.core-4.5.2.jar
wget http://www.ekstazi.org/release/org.ekstazi.ant-4.5.2.jar
rev2=`git log | grep "^commit " | head -n 1 | cut -c 8-14`
rev1=`git log | grep "^commit " | head -n 2 | tail -n 1 | cut -c 8-14`
git reset --hard "${rev1}"
sed -i '/<project name=*/ a xmlns:ekstazi="antlib:org.ekstazi.ant"' build.xml
sed -i '/<\/project>/i <taskdef uri="antlib:org.ekstazi.ant" resource="org/ekstazi/ant/antlib.xml">\
<classpath path="org.ekstazi.core-4.5.2.jar"/>\
<classpath path="org.ekstazi.ant-4.5.2.jar"/>\
</taskdef>' build.xml
sed -i '/<junit*/i <ekstazi:select>' build.xml
sed -i '/<\/junit>/a </ekstazi:select>' build.xml
ant -lib org.ekstazi.ant-4.5.2.jar -lib org.ekstazi.core-4.5.2.jar test >> output${rev1}.txt
ant -lib org.ekstazi.ant-4.5.2.jar -lib org.ekstazi.core-4.5.2.jar test >> output${rev1}again.txt
echo "Test run for ${rev1}:"
grep -c "[junit]" output${rev1}.txt
echo "Test run for ${rev1} again:"
grep -c "[junit]" output${rev1}again.txt


#!/bin/bash
cd ~
rm -rf research
wget http://mir.cs.illinois.edu/gyori/sw/ed48904-diaper-junit.zip
unzip ed48904*
cd ~/research
cd *
cd *
./run.sh
cd ~
cd projects
#./research/state-capture/diaper-junit/scripts_bash/diaperize.sh research/state-capture/diaper-junit/scripts_bash/4projects >> badresult.txt
#wait
#cd projects
/home/silvia/research/state-capture/diaper-junit/scripts_bash/diaperize.sh ~/4projects
wait
cd ~
cd projects
for file in `find -name LOG_bbaa`
do
	echo ${file%/*}
	echo -n "true: "
	grep -c "true$" $file
	echo -n "false: "
	grep -c "false$" $file
done


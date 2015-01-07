#!/bin/bash
#cd ~
#wget http://mir.cs.illinois.edu/gyori/sw/ed48904-diaper-junit.zip
#unzip ed48904*
#cd research
#cd *
#cd *
#./run.sh
#cd ~
#./research/state-capture/diaper-junit/scripts_bash/diaperize.sh research/state-capture/diaper-junit/scripts_bash/projectsList
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


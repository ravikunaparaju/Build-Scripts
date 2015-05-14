# This shell script always gets latest code from git and runs calabash ios setup command
# @author Ravi Kunaparaju


#!/bin/sh

cd ~/code/
if [ -d ~/code/app-ios ]
	then 
	echo "directory exists"
		rm -rf app-ios
	echo "app-ios directory is deleted"
fi
git clone 'url to clone your code'
echo "checkout complete"
cd os-maps-ios
pwd
echo "running calabash-ios set up"
echo -ne '\n' | calabash-ios setup



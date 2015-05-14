# This script compiles app with target calabash and copies app file to automation project destination and executes calabash build verification tests

# @Author Ravi Kunaparaju

#! /bin/sh
automation_app_path='code/app-automation/apps/'
path_to_simulator_buildApp='Library/Developer/Xcode/DerivedData/{app}/Build/Products/Debug-iphonesimulator'
automation='code/app-automation'
ios='code/app-ios'

cd ~/$ios
echo "compiling xcode project for 8.2 simulator"
xcodebuild -target app-cal -configuration Debug -sdk iphonesimulator8.2
echo "Deleting existing app-cal.app from apps location ..."
rm -rf ~/$automation_app_path/app-cal.app
echo "Copying new file from DerivedData to apps location ..."
cp -r ~/$path_to_simulator_buildApp/app-cal.app ~/$automation_app_path
echo "Successfully copied :), happy testing"
cd ~/$automation
cucumber -p ios -p orderTests --tags @bvt_ios
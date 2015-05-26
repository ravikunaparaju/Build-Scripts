# This script copes ios app with target calabash and copies app file to automation project destination and executes calabash build verification tests
# I am using a third party ruby script transporter_chief.rb to install application on device
# For more information on transporter_chief.rb, please visit http://gamua.com/blog/2012/03/how-to-deploy-ios-apps-to-the-iphone-via-the-command-line/

# @Author Ravi Kunaparaju

#! /bin/sh

automation_app_path='code/app-automation/apps/'
path_to_device_buildApp='Library/Developer/Xcode/DerivedData/{app}/Build/Products/Debug-iphoneos'
path_to_simulator_buildApp='Library/Developer/Xcode/DerivedData/{app}/Build/Products/Debug-iphonesimulator'
automation='code/app-automation'
ios='code/app-ios'


cd ~/code/
if [ -d ~/$ios]
	then 
	echo "directory exists"
		rm -rf app-ios
	echo "app-ios directory is deleted"
fi
git clone 'url to clone your code'
echo "checkout complete"
cd ~/$ios
pwd
echo "running calabash-ios set up"
echo -ne '\n' | calabash-ios setup

cd ~/$ios
echo "compiling xcode project for device"
xcodebuild -target app-cal -configuration Debug -sdk iphoneos8.3
echo "Deleting existing app-cal.app from apps location ..."
rm -rf ~/$automation_app_path/app-cal.app
echo "Copying new file from DerivedData to apps location ..."
cp -r ~/$path_to_device_buildApp/app-cal.app ~/$automation_app_path
ruby ~/code/apps-automation/buildscripts/transporter_chief.rb ~/$path_to_device_buildApp/app-cal.app
echo "Successfully copied :), happy testing"
cd ~/$automation
echo "Deleting existing failure screenshots"
rm -rf screenshot_*
DEVICE_ENDPOINT=http://192.168.2.3:37265 DEVICE_TARGET='ec9b055ed00a03f1e222a65781d19273f87d352a' APP_BUNDLE_ID=your.app.id cucumber -p ios --tags @bvt_ios
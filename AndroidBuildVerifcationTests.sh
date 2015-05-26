# This script checks out latest code from Android git and compiles code. Copies executable to apps automation folder and resigns apk file.
# 
# @author Ravi Kunaparaju
#!/bin/sh

android='code/apps-android'
automation='code/mobile-automation/'
app='code/mobile-automation/apps/'
compiled_binary_path='code/apps-android/app/build/outputs/apk'
screenshots='code/mobile-automation/screenshots/android'




cd ~/code

androidCode(){
	if [ -d ~/$android ]
		then 
			cd apps-android
			echo "directory exists, getting latest code"
			#rm -rf ~/$android
			git pull
		else 
			echo "directory doesnot exists, checking out latest code"
			git clone http://<your app code url>/apps-android.git	
	fi
}

updateAutomation(){
	if [ ! -d ~/$automation ]
		then 
			echo "automation directory doesn't exist, cloning directory"
			
			git clone http://<your automation code location  url>/apps-automation.git
			
			echo "check out completed"
					
		elif [ -d ~/$automation ]
						
			then
					
				cd ~/$automation
				echo "updating existing code"
				git pull
	fi
}

checkDeviceState(){
deviceState=$(adb shell dumpsys power | grep 'Display Power'| cut -d '=' -f 2 | tr -d '\r')
power="OFF"
echo $deviceState	
echo $power
if [ "$deviceState" == "$power" ]
	then
 		echo "device is sleeping"
 		adb shell input keyevent 26
	else
 		echo "device is awake"	
fi
}


cd ~/$android

androidCode

if bash gradlew clean build
		then
			updateAutomation

			echo "Deleting old apk file from apps directory ...."

			rm -rf ~/$automation/apps/app-release.apk

			echo "Deleting old screenshots from android folder"

			rm -rf ~/$automation/screenshots/android/error_*

			echo "Copying new apk file to apps directory ...."

			cp -r ~/$compiled_binary_path/app-release.apk ~/$app

			cd ~/$automation

			echo "resigning apk file ...."

			calabash-android resign apps/app-release.apk

			echo "checking device state and running build verification tests"
			
			checkDeviceState
			 
			calabash-android run apps/app-release.apk -p android features/login.feature features --tags @bvt_android
		
	else
			
		echo "Build failed, please contact Android dev team ......."
fi


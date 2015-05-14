# This script helps to automate the build process from getting latest code, compiling code
# to generate apk file, resign apk file and run calabash android tests	
# This scripts execute tests only if Android build is successful
# @author Ravi Kunaparaju
#!/bin/sh

android='code/app-android'
automation='code/mobile-automation/'
app='code/mobile-automation/apps/'
compiled_binary_path='{path to compiled binary}/app.apk'
screenshots='code/mobile-automation/'

cd ~/code
if [ -d ~/$android ]
	then 
		cd /$android
		echo "directory exists, getting latest code"
		#rm -rf ~/$android
		git pull
	else 
		echo "directory doesnot exists, checking out latest code"
		git clone 'url to clone your code'	
fi


cd ~/$android
	if bash gradlew clean build
		then
			if [ ! -d ~/$automation ]
				then 
					echo "automation directory doesn't exist, cloning directory"
					git clone 'url to clone your code'
					echo "check out completed"
					elif [ -d ~/$automation ]
						then
						cd ~/$automation
						echo "updating existing code"
						git pull
			fi
			echo "Deleting old apk file from apps directory ...."
			rm -rf ~/$automation/apps/app-release.apk
			echo "Deleting old screenshots from android folder"
			rm -rf ~/$automation/screenshots/android/error_*
			echo "Copying new apk file to apps directory ...."
			cp -r ~/$compiled_binary_path/app-release.apk ~/$app
			cd ~/$automation
			echo "resigning apk file ...."
			calabash-android resign apps/app-release.apk
			echo "running build verification tests"
			calabash-android run apps/app-release.apk -p android features/login.feature features --tags @bvt_android
		else
			echo "Build failed, please contact Android dev team ......."
	fi


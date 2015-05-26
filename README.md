#BUILD SCRIPTS
==============


Introduction: 
------------

Shell scripts to completely automate mobile test process from checking out latest code, executing code to build and modify binaries for running calabash tests for android and ios platforms on Mac or Linux. 


AndroidBuildVerificationTest.sh
-------------------------------

This script performs these following tasks

1. Checks out latest code from git and compiles the code. We are using git and gradle. 
2. Checks if code is built successful and throws error message if failed.
3. If build is successful then resigns the generated apk file
4. Deletes screenshots of failed scenarios from previous builds
5. Checks if android device is in sleep mode, wakes device if in sleep mode
6. Execute P1 tests tagged as @bvt_android and generates areport in reports folder 

IOSBuildVerification_Device.sh
-------------------------------

This script performs these following tasks

1. Checks out latest code from git.
2. Runs calabash ios setup to generate calabash target.
3. Compiles code with calabash target and installs builds on device
4. Deletes screenshots of failed scenarios from previous builds
5. Execute P1 tests tagged as @bvt_android and generates areport in reports folder

IOSBuildVerification_Simulator.sh
---------------------------------

This script performs these following tasks

1. Checks out latest code from git.
2. Runs calabash ios setup to generate calabash target.
3. Compiles code with calabash target and installs builds on device
4. Deletes screenshots of failed scenarios from previous builds
5. Execute P1 tests tagged as @bvt_android and generates areport in reports folder

adbKeepAlive.sh:
----------------

While running android tests on wifi this script checks if adb connection is active or not.

Transporter_chief.rb:
---------------------

transport_chief.rb from Gauma helps install ios app on physical device. I am using this script for installing build on device in IOSBuildVerification_Device.sh

To know more about transport_chief.rb and how it works, read this blog

http://gamua.com/blog/2012/03/how-to-deploy-ios-apps-to-the-iphone-via-the-command-line/

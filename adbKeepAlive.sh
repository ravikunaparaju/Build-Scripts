# This script keeps on the adb connection live with the device. 
# Before executing this script, Please ensure you have already established by connecting device to pc and ran "adb tcpip 5555".

# #############################################################################


# Steps to connect adb with device over wifi


#  1. kill any existing adb instances with following command, ensure mac and device are connected same wifi access point
#     	killall adb
#  2. connect device with usb and run this command
#		adb usb
#  3. run this command to run over tcpip
#		adb tcpip 5555
#  4. connect device 
#		adb connect 192.168.2.2 (your device ip)
#  5. check verify connection by removing usb connection
#		adb devices

# @author Ravi Kunaparaju

#!/bin/sh

while true 
 	do  
 		state=$(adb connect 192.168.2.5 | cut -d ' ' -f 1 | tr -d '\r')
 		echo $state
 		sleep 10 
 		if [ "$state" == "unable" ]
 			then
 				adb shell input keyevent 26
 				adb shell su -c "svc wifi enable"
 			else 
 				echo "adb connection is active"
 		fi 
		
done

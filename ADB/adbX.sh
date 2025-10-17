#!/bin/bash
# This FC's android
# chrome://inspect/#devices
# Get a list of connected ADB device serials
#https://developer.android.com/tools/adb?hl=zh-tw
#https://blog.csdn.net/ezconn/article/details/99885715
#https://community.kodular.io/t/how-to-open-any-setting-on-your-android-device-using-kodular-a-step-by-step-guide/217383
# curl -o- http://solar.decade.tw/adbX.sh | bash

get_index_of_value() {
  local index=-1
  for i in "${!PAD_SERIAL_MAPPINT[@]}"; do
     if [[ "${PAD_SERIAL_MAPPINT[$i]}" = "${1}" ]]; then

        index="$((i))";
        break;
     fi
  done
  echo "$index"
}


getCount(){
  for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
      echo "chrome://inspect/$d"
  done
  adb devices
#  devices=($(adb devices | awk 'NR>1 && $2=="device" {print $1}'))
#  device_count=${#devices[@]}
  adb devices | awk 'NR>1 && $2=="device" {print $1}' > devices.txt
  adb devices | awk 'NR>1 && $2=="unauthorized" {print $1}' > unauth.txt
  wc -l devices.txt
  wc -l unauth.txt
#  echo "Connected devices count: $device_count"
}
#clear

URLX=http://decade.tw
pkg_name=tw.decade.solar2025
onetime=0

while true; do
#  echo
#  echo "DECADE.tw MobileGod 詐騙集團App:"
#  echo "R) Remote Desktop control padx300"
#  echo "w) set all devices WIFI "
#  echo "a|u) install/uninstall APK on all devices x300"
#  echo "d) move to open USB-debug"
#  echo "1) screen-on"
#  echo "0) screen-off"
#  echo "c) open-chrome (http://solar.decade.tw)"
#  echo "k) close all apps and show desktop (home screen)"
#  echo "b) adjust brightness (dark → 90%)"
#  echo "wall) change background color (black/red)"
#  echo "i) set background image from file path"
#  echo "+) increase volume by 10%"
#  echo "-) decrease volume by 10%"
#  echo "t) list all devices temperature"
#  echo "q) quit"
  getCount
  echo "Enter your choice [x]: "

  if [ -n "$1" ]; then
    choice=$1
    onetime=1
  else
    read choice
  fi
  # Get all connected device serials
#  devices=$(adb devices | awk 'NR>1 && $2=="device" {print $1}')

  case $choice in
    rebootx)
        sudo reboot
      ;;
    L)
      while true; do  date; getCount; sleep 1; done
      ;;
    I)
          open -a "Google Chrome" chrome://inspect/#devices
          ;;

    Z)
        sh "$0"
        ;;
    R)
        for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
          adb -s $d  reboot
        done
        ;;
    r)
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        scrcpy -s $d&
      done
      ;;


    w)
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
#        adb shell cmd wifi set-wifi-enabled enabled
        adb shell cmd wifi set-wifi-enabled disabled
        adb -s $d shell "am start -a android.settings.WIFI_SETTINGS"
        sleep 1
#        adb -s $d shell input tap 750 265


#        adb -s $d shell cmd wifi connect-network DECADE_TW wpa2 ssssssss
#        adb -s $d wifi connect-network SolarX open
#        adb -s $d shell am start -n "com.adbwifisettingsmanager/.WifiSettingsManagerActivity" --esn newConnection -e ssid DECADE -e password ssssssss
      done
      ;;
    u)
      echo "Enter package name of app to uninstall:"
      read pkg_name2
      if [[ -z "$pkg_name2" ]]; then
        echo "Package name default. $pkg_name"
      else 
        pkg_name=$pkg_name2
      fi
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        if [ -n "$d" ]; then
          echo "[][][]cUninstalling $pkg_name on device $d..."
          # Use pm uninstall command to uninstall the app
          adb -s $d shell pm uninstall -k $pkg_name
          if [ $? -eq 0 ]; then
            echo "[O][]Uninstalled successfully on $d"
          else
            echo "[X]Failed to uninstall on $d. Check adb output for errors."
          fi
        else
          echo "No devices found or not in 'device' state."
          break
        fi
      done
      ;;
#      read apk_path
# /Users/x/Documents/__DECADE/LL_Hand_Weather/Solar/com.ryosoftware.adbw_3.3.160-160_minAPI19(nodpi)_apkmirror.com.apk

    a)
      echo "Enter path to APK file:"
      apk_path='/Users/x/Documents/__DECADE/LL_Hand_Weather/Solar/com.android.chrome_138.0.7204.157-720415720_minAPI26_maxAPI28(armeabi-v7a)(nodpi)_apkmirror.com.apk'
      if [[ -f "$apk_path" ]]; then
        for d in "${devices[@]}"; do
          echo "[][][]cInstalling $apk_path on device $d..." && \
          adb -s $d install "$apk_path"&
#
#          if [ $? -eq 0 ]; then
#            echo "[O][]Installed successfully on $d"
#          else
#            echo "[X]Failed to install on $d. Check adb output for errors."
#          fi
        done
      else
        echo "Error: File not found at '$apk_path'"
      fi
      ;;
    d)
      echo "move to open USB-debug"
       for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s $d shell am start -a com.android.settings.APPLICATION_DEVELOPMENT_SETTINGS
        sleep 1
        adb -s $d shell input swipe 500 1800 500 500 300
      done
      ;;
    1|on)
      echo "Turning screen ON and swiping up to unlock..."
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s $d shell dumpsys power | grep -E 'Display Power: state=|mScreenOn' | grep -qE 'OFF|false' && \
        adb -s $d shell input keyevent 26 && \
        sleep 1 && \
        adb -s $d shell input swipe 300 1000 300 300 300 && \
        adb -s $d shell input keyevent KEYCODE_HOME &
      done
      ;;
    0|off)
      echo "Turning screen OFF..."
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        state=$(adb -s $d shell dumpsys power | grep -E 'Display Power: state=|mScreenOn' | grep -E 'ON|true')
        if [ -n "$state" ]; then
          adb -s $d shell input keyevent 26&
#          echo "Screen turned off for device $d"
#        else
#          echo "Screen already off for device $d"
        fi
      done
      ;;
    S)
      echo "Opening Solar App"
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s $d shell pm list packages -f
        adb -s $d shell dumpsys activity
        adb -s $d shell am start tw.decade.solar2025/.MainActivity
      done
      ;;
#getprop ro.build.version.release
#dumpsys activity |find "mResumedActivity"
    s|shell)
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        echo "[O]lets shell "$d $2
        adb -s $d shell $2 &
      done
      ;;
    push_serial_wallpaper)
      find -name "H*.jpg*" -exec rm {} \;
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        echo [O]lets screenshot "$d"
        wget http://10.10.10.10:7777/home/SolarWallpapers_serial/"$d".jpg &&
        adb -s "$d" push "$d".jpg /sdcard/Pictures/&
      done
      ;;
    ntp)
      echo "NTP"
      T=$(date +"%Y-%m-%d %H:%M:%S")
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s "$d" shell date "$T"
      done
      ;;

    screenshot)
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        echo [O]lets screenshot "$d"
        if [ ! -d "/home/pi/screenshots" ]; then
          mkdir /home/pi/screenshots
        fi
        adb -s "$d" exec-out "screencap -p" > /home/pi/screenshots/s_"$d".png&
      done
      ;;
    t|tap)

      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        echo "[O]lets tap "$d $2 $3
        adb -s "$d" shell input tap $2 "$3"&
      done
      ;;




    push)
      echo "[push]Enter path to push file:"
      apk_path=$2
      if [ -f "$apk_path" ]; then
        for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
          echo "[][][]pushing $apk_path on device $d..." && \
          adb -s "$d" push "$apk_path" "$3"&
        done
      else
        echo "Error: File not found at '$apk_path'"
      fi
      ;;
    apk)
      echo "[apk]Enter path to APK file:"
      apk_path=$2
      if [ -f "$apk_path" ]; then
        for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
          echo "[][][]cInstalling $apk_path on device $d..." && \
          adb -s "$d" install "$apk_path" &
        done
      else
        echo "Error: File not found at '$apk_path'"
      fi
      ;;
    c|chrome)
      echo "Opening Chrome with http://decade.tw ...or set by input URL"
      if [ "$onetime" -ne 0 ]; then
          input_url=$2
      else
        read input_url
      fi

      if [[ -z "$input_url" ]]; then
        input_url="https://10.10.10.10"
      fi
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s "$d" shell am start -a android.intent.action.VIEW -d $input_url com.android.chrome&
#        sleep 3 && \
#        adb -s $d shell input tap 463 875&
      done
      ;;
    chrome-vid)
#      echo "firefox url= $2, serial= $3"
      adb -s "$3" shell am start -a android.intent.action.VIEW -d "$2" com.android.chrome&
      ;;
    https)
      echo "Opening Chrome with https://"
      if [ "$onetime" -ne 0 ]; then
          input_url=$2
      else
        read input_url
      fi

      if [[ -z "$input_url" ]]; then
        input_url="https://192.168.1.111:7777"
      fi
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s $d shell am start -a android.intent.action.VIEW -d $input_url com.android.chrome && \
        sleep 3 && \
        adb -s $d shell input tap 138 926 && \
        adb -s $d shell input tap 200 1157 && \
        sleep 5 && \
        adb -s $d shell input tap 388 605&
      done
      ;;
    l)
      echo "list all package..."
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s $d shell cmd package list packages
        
      done
      ;;      
    k|kill)
      echo "Closing all background apps and showing desktop (home screen)..."
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s $d shell am force-stop com.android.chrome && \
        adb -s $d shell am kill-all&
#        adb -s $d shell input keyevent 3  && \
#        adb -s $d shell input keyevent KEYCODE_HOME&
      done
      ;;
    b|bri)
      echo "Setting brightness to minimum, then to 90% after 1 second..."
      i=0
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        ((i++))
        echo "Brightness adjusted for device $d in $i sec" && \
        adb -s $d shell settings put system screen_brightness 0 && \
        sleep $i && \
        adb -s $d shell settings put system screen_brightness 230 &

      done
      ;;
    +)
          echo "Setting brightness to minimum, then to 90% after 1 second..."
          i=0
          for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
            ((i++))
            echo "Volumn adjusted for device $d in $i sec" && \

            adb -s $d shell input keyevent 24&
#            adb -s $d shell media volume --show --stream 0 --set 100 && \
#            adb -s $d shell media volume --show --stream 3 --set 100&

          done
          ;;
    wall)
      echo "Choose background color:"
#      echo "1) Black"
#      echo "2) Red"
#      read color_choice
#      case $color_choice in
#        1)
#          color_hex="0xFF000000" # Black
#          ;;
#        2)
#          color_hex="0xFFFF0000" # Red
#          ;;
#        *)
#          echo "Invalid color choice."
#          continue
#          ;;
#      esac
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        adb -s $d shell dumpsys package com.android.chrome | grep uid && \
        adb -s $d shell cmd wallpaper set-color 0xFF000000 && \
        adb -s $d shell am start com.tblenovo.wallpaper/com.android.wallpaperpicker.WallpaperPickerActivity && \
        adb -s $d shell input tap 521 1133 && \
        adb -s $d shell input tap 700 80 && \
        adb -s $d shell input keyevent KEYCODE_HOME && \
        echo "Background color set for device $d"&
      done
      ;;
    temp)
      echo "Listing temperature for all devices..."
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        echo "=== Device: $d ==="
        echo "Battery Temperature:"
        adb -s $d shell dumpsys battery | grep temperature
        echo "CPU Thermal Zones:"
        adb -s $d shell "cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | head -10" | awk '{print "Zone " NR-1 ": " $1/1000 "°C"}'  2>/dev/null || echo "CPU thermal info not available"
        echo "Additional thermal info:"
        adb -s $d shell "ls /sys/class/thermal/thermal_zone*/type 2>/dev/null | head -5 | xargs cat 2>/dev/null" | awk '{print "Sensor: " $1}' 2>/dev/null || echo "Thermal sensor info not available"
        echo "GPU Temperature (if available):"
        adb -s $d shell "cat /sys/class/kgsl/kgsl-3d0/temp 2>/dev/null" | awk '{print "GPU: " $1/1000 "°C"}' 2>/dev/null || echo "GPU temperature not available"
        echo "---"
      done
      ;;
    q)
      echo "Exiting."
      break
      ;;
    push301video)
#      PAD_SERIAL_MAPPINT=("HGT4YJJM" "HGT4ZR8N" "HGT4ZNM7" "HA190J3S" "HGT4ZG44" "HA166F04" "HGT4YJQ1" "HGT5X1EE" "HGT53WXC" "HA167M2N" "HGT54TH4" "HGT4ZN5F" "HA190KF7" "HGT53XFR" "HGT4ZG43" "HGT4ZFVA" "HGT53R5Z" "HGT4ZN4T" "HGT4ZZS5" "HGT4YJGJ" "HGT53SMY" "HA18GWX2" "HGT53R8C" "HGT53WRS" "HGT5X1L0" "HA161CWD" "HGT4YKL9" "HGT53S2X" "HA1H8JLR" "HA190D8H" "HA190FGA" "HGT4ZG62" "HGT54T85" "HGT54TN3" "HGT53WX9" "HGT4ZMSQ" "HA161JTZ" "HGT53RPC" "НА1ВТЕВМ" "HGT4ZFFV" "HGT5X0Y2" "HA1BX107" "HGT4YKQS" "HGT4ZM0J" "HA1644ZK" "HGT4ZRKG" "HA1CKSYF" "HA1H5FCG" "HGT4YJPR" "HA16177L" "HA1H5HET" "HA16131G" "HGT4ZZLB" "HGT4ZZK5" "HA163ATA" "HA1CJW0W" "HGT4ZHVF" "HGT54VZT" "HGT4ZM16" "HGT54VKB" "HA15WNCK" "HGT4ZS3F" "HGT53WPR" "HGT4YK8N" "HGT4ZFGJ" "HA16KQ19" "HGT4ZJT7" "HA161AY2" "HGT5X108" "HGT4ZJ2W" "HA1BWP0M" "HGT4YJKL" "HGT4ZZDQ" "HGT54T4E" "HGT54TD1" "HGT4YJKS" "HGT4YJ99" "HA168EL7" "HGT4ZHZ1" "HGT53TF3" "HGT54V0N" "HGT4ZMP5" "HA1H54M3" "HA163JPE" "HA1BW4KN" "HGT54RX6" "HGT4ZRG3" "HGT4ZZXK" "HGT4ZRSR" "HGT4ZK4S" "HA16193J" "HGT53S4P" "HA1CJGAT" "HGT54W06" "НА190KA7" "HGT54SK5" "HGT54TED" "HA18YEQM" "HGT4ZG9H" "HA190CDN" "HA161K1W" "HGT53XG8" "HGT4ZFDE" "HA163JNS" "HGT4ZQTJ" "HGT53W8D" "HGT53TW8" "HA1H5MSL" "HGT53VDW" "HGT4ZHMT" "HA190XBL" "HGT54V31" "HGT4ZZM3" "HGT5X1DG" "HGT53VJX" "HA18Z6D8" "HGT4ZZPZ" "HGT5X1GD" "HGT4ZG3D" "HA1BX58T" "HGT54SGH" "HA169JPD" "HA190RGY" "HGT4ZGAX" "HA190DH1" "HGT4ZQQ1" "HA1H7PVA" "HGT4YJHF" "HGT5X0N4" "HGT54V4E" "HGT53R6R" "HA1CGEL4" "HA165VWB" "HGT4ZJ8H" "HGT4ZMPA" "HA1H7FBE" "HA1688MW" "HGT5X29V" "HA1BWXTN" "HGT4ZZGD" "HGT54RZD" "HGT53VAQ" "HGT54RTW" "HGT4ZFZG" "HA166LVK" "HGT5X0J9" "HGT53XJW" "HA1CK4X0" "HGT4ZFET" "HGT4ZQRG" "HGT4ZHRJ" "HGT53VSA" "HGT53SB6" "HA168GFC" "HGT4ZFHH" "HGT54RZH" "HGT4YJSP" "HA168H9H" "HGT53WVK" "НА1665X1" "HGT53VHZ" "HGT54T5F" "HGT54SMM" "HGT4ZNF9" "HA168GNZ" "HGT5X13Z" "HA163VE6" "HA16LYFZ" "HGT4ZMZ8" "HGT54TML" "HA16110N" "HA166JJ6" "HGT4ZH50" "HGT54W9V" "XHGT4NB0" "HA1BX9BA" "HA190J2P" "HA1BSTW8" "HGT54T83" "HGT4ZNPL" "HA169QL2" "HGT4ZJ3Q" "HGT54S3K" "HGT4YKTB" "HGT4ZRBY" "HGT4ZQCR" "HGT54T82" "HGT53TS0" "HGT4ZZLJ" "HGT53S00" "HGT53TB1" "HA1688NB" "HGT4YK9W" "HGT4YJZJ" "HA164746" "HGT54T3C" "HGT53VVJ" "HA1H8W82" "HGT4ZNR1" "HA1BWVY2" "HGT4ZQ52" "HGT4ZGRJ" "HA163NSP" "HA190LHR" "HGT54TNA" "HGT4YKHX" "HA1BWLZA" "HA165Z69" "HA1BTEEC" "HA168ALD" "HGT53SMB" "HA1683HX" "HGT5X260" "HGT5X0LV" "HGT4ZJB7" "HGT4YKVG" "HGT4ZG9D" "HGT54TRG" "HA16637G" "HA1G4TDF" "HGT53TB5" "HGT4ZRAW" "HGT4ZG45" "HGT4ZG7J" "HGT54W7F" "HA190FKG" "HA167YYY" "HGT54SH2" "HGT50000" "HGT53V23" "HGT53S7N" "HGT4ZJDZ" "HGT53VXF" "HGT53TT3" "HGT4ZGN3" "HA18ZC4X" "HGT54T45" "HA1CKVCF" "HGT53RWR" "HA1H5PXY" "HGT54VHT" "HA1BVHYM" "HGT4ZQJE" "HGT4ZNDB" "HA1H6833" "HGT4ZGK6" "HGT4ZZK8" "HGT4ZQK6" "HGT54SRE" "HGT53WGS" "HGT4ZQHG" "HGT4ZJY5" "HGT4ZZMV" "HGT54T35" "HGT53W0B" "HGT4ZG3S" "HA166EMC" "НА16KKA2" "HA190XGL" "HGT4YKW9" "HGT4ZS41" "HGT4ZHPG" "HGT4ZRQ7" "HA1638W8" "HA18ZBFA" "HA165QLM" "HA1BVRBH" "HGT4ZK37" "HGT53RZE" "HA190MRX" "HA167S0S" "HA167L4G" "HGT5X13N" "HA1H92TD" "HGT4ZJYD" "HGT53SSQ" "HGT4ZNRJ" "HA16115E" "HGT54RQH" "HA1BWS8V" "HGT4ZG9B" "HA16A7V6" "HGT5X1FY" "HGT4ZZNJ" "HA168FDT" "HA165XW7" "HA164L5S" "HA16471H" "HGT4ZQ25" "HA1BX310" "HA1BX5JQ" "HGT6LV92" "HA18YEL2" "HGT4ZHMJ" "HGT4ZHTJ" "HA160ZJ3" "HGT5X12D" "HGT53RGX" "HA1H5PVP" "HA1HC5X7" "HA161R71")

      filename_head=$3
      filename_end=$4
      echo "[push301]" "$filename_head" "$filename_end"
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        echo "[][][]push301 $apk_path on device $d..." && \
        value_to_find="$d"
        WHICH_VIDEO_INDEX=$(get_index_of_value "$value_to_find")
        echo "$(hostname) $d FOUND $WHICH_VIDEO_INDEX"
        filename=$filename_head$WHICH_VIDEO_INDEX$filename_end
        echo "$(hostname)" adb -s "$d" push "$filename" "$5"
        adb -s "$d" push "$filename" "$4"&
      done

    ;;
    push301txt) # adbX.sh push301txt$0
#      PAD_SERIAL_MAPPINT=("HGT4YJJM" "HGT4ZR8N" "HGT4ZNM7" "HA190J3S" "HGT4ZG44" "HA166F04" "HGT4YJQ1" "HGT5X1EE" "HGT53WXC" "HA167M2N" "HGT54TH4" "HGT4ZN5F" "HA190KF7" "HGT53XFR" "HGT4ZG43" "HGT4ZFVA" "HGT53R5Z" "HGT4ZN4T" "HGT4ZZS5" "HGT4YJGJ" "HGT53SMY" "HA18GWX2" "HGT53R8C" "HGT53WRS" "HGT5X1L0" "HA161CWD" "HGT4YKL9" "HGT53S2X" "HA1H8JLR" "HA190D8H" "HA190FGA" "HGT4ZG62" "HGT54T85" "HGT54TN3" "HGT53WX9" "HGT4ZMSQ" "HA161JTZ" "HGT53RPC" "НА1ВТЕВМ" "HGT4ZFFV" "HGT5X0Y2" "HA1BX107" "HGT4YKQS" "HGT4ZM0J" "HA1644ZK" "HGT4ZRKG" "HA1CKSYF" "HA1H5FCG" "HGT4YJPR" "HA16177L" "HA1H5HET" "HA16131G" "HGT4ZZLB" "HGT4ZZK5" "HA163ATA" "HA1CJW0W" "HGT4ZHVF" "HGT54VZT" "HGT4ZM16" "HGT54VKB" "HA15WNCK" "HGT4ZS3F" "HGT53WPR" "HGT4YK8N" "HGT4ZFGJ" "HA16KQ19" "HGT4ZJT7" "HA161AY2" "HGT5X108" "HGT4ZJ2W" "HA1BWP0M" "HGT4YJKL" "HGT4ZZDQ" "HGT54T4E" "HGT54TD1" "HGT4YJKS" "HGT4YJ99" "HA168EL7" "HGT4ZHZ1" "HGT53TF3" "HGT54V0N" "HGT4ZMP5" "HA1H54M3" "HA163JPE" "HA1BW4KN" "HGT54RX6" "HGT4ZRG3" "HGT4ZZXK" "HGT4ZRSR" "HGT4ZK4S" "HA16193J" "HGT53S4P" "HA1CJGAT" "HGT54W06" "НА190KA7" "HGT54SK5" "HGT54TED" "HA18YEQM" "HGT4ZG9H" "HA190CDN" "HA161K1W" "HGT53XG8" "HGT4ZFDE" "HA163JNS" "HGT4ZQTJ" "HGT53W8D" "HGT53TW8" "HA1H5MSL" "HGT53VDW" "HGT4ZHMT" "HA190XBL" "HGT54V31" "HGT4ZZM3" "HGT5X1DG" "HGT53VJX" "HA18Z6D8" "HGT4ZZPZ" "HGT5X1GD" "HGT4ZG3D" "HA1BX58T" "HGT54SGH" "HA169JPD" "HA190RGY" "HGT4ZGAX" "HA190DH1" "HGT4ZQQ1" "HA1H7PVA" "HGT4YJHF" "HGT5X0N4" "HGT54V4E" "HGT53R6R" "HA1CGEL4" "HA165VWB" "HGT4ZJ8H" "HGT4ZMPA" "HA1H7FBE" "HA1688MW" "HGT5X29V" "HA1BWXTN" "HGT4ZZGD" "HGT54RZD" "HGT53VAQ" "HGT54RTW" "HGT4ZFZG" "HA166LVK" "HGT5X0J9" "HGT53XJW" "HA1CK4X0" "HGT4ZFET" "HGT4ZQRG" "HGT4ZHRJ" "HGT53VSA" "HGT53SB6" "HA168GFC" "HGT4ZFHH" "HGT54RZH" "HGT4YJSP" "HA168H9H" "HGT53WVK" "НА1665X1" "HGT53VHZ" "HGT54T5F" "HGT54SMM" "HGT4ZNF9" "HA168GNZ" "HGT5X13Z" "HA163VE6" "HA16LYFZ" "HGT4ZMZ8" "HGT54TML" "HA16110N" "HA166JJ6" "HGT4ZH50" "HGT54W9V" "XHGT4NB0" "HA1BX9BA" "HA190J2P" "HA1BSTW8" "HGT54T83" "HGT4ZNPL" "HA169QL2" "HGT4ZJ3Q" "HGT54S3K" "HGT4YKTB" "HGT4ZRBY" "HGT4ZQCR" "HGT54T82" "HGT53TS0" "HGT4ZZLJ" "HGT53S00" "HGT53TB1" "HA1688NB" "HGT4YK9W" "HGT4YJZJ" "HA164746" "HGT54T3C" "HGT53VVJ" "HA1H8W82" "HGT4ZNR1" "HA1BWVY2" "HGT4ZQ52" "HGT4ZGRJ" "HA163NSP" "HA190LHR" "HGT54TNA" "HGT4YKHX" "HA1BWLZA" "HA165Z69" "HA1BTEEC" "HA168ALD" "HGT53SMB" "HA1683HX" "HGT5X260" "HGT5X0LV" "HGT4ZJB7" "HGT4YKVG" "HGT4ZG9D" "HGT54TRG" "HA16637G" "HA1G4TDF" "HGT53TB5" "HGT4ZRAW" "HGT4ZG45" "HGT4ZG7J" "HGT54W7F" "HA190FKG" "HA167YYY" "HGT54SH2" "HGT50000" "HGT53V23" "HGT53S7N" "HGT4ZJDZ" "HGT53VXF" "HGT53TT3" "HGT4ZGN3" "HA18ZC4X" "HGT54T45" "HA1CKVCF" "HGT53RWR" "HA1H5PXY" "HGT54VHT" "HA1BVHYM" "HGT4ZQJE" "HGT4ZNDB" "HA1H6833" "HGT4ZGK6" "HGT4ZZK8" "HGT4ZQK6" "HGT54SRE" "HGT53WGS" "HGT4ZQHG" "HGT4ZJY5" "HGT4ZZMV" "HGT54T35" "HGT53W0B" "HGT4ZG3S" "HA166EMC" "НА16KKA2" "HA190XGL" "HGT4YKW9" "HGT4ZS41" "HGT4ZHPG" "HGT4ZRQ7" "HA1638W8" "HA18ZBFA" "HA165QLM" "HA1BVRBH" "HGT4ZK37" "HGT53RZE" "HA190MRX" "HA167S0S" "HA167L4G" "HGT5X13N" "HA1H92TD" "HGT4ZJYD" "HGT53SSQ" "HGT4ZNRJ" "HA16115E" "HGT54RQH" "HA1BWS8V" "HGT4ZG9B" "HA16A7V6" "HGT5X1FY" "HGT4ZZNJ" "HA168FDT" "HA165XW7" "HA164L5S" "HA16471H" "HGT4ZQ25" "HA1BX310" "HA1BX5JQ" "HGT6LV92" "HA18YEL2" "HGT4ZHMJ" "HGT4ZHTJ" "HA160ZJ3" "HGT5X12D" "HGT53RGX" "HA1H5PVP" "HA1HC5X7" "HA161R71")

      echo "[push301txt]" "$filename_head" "$filename_end"
      for d in $(adb devices | awk 'NR>1 && $2=="device" {print $1}'); do
        value_to_find="$d"
        WHICH_VIDEO_INDEX=$(get_index_of_value "$value_to_find")
        echo "{\"vid\":${WHICH_VIDEO_INDEX},\"wss\":\"ws://10.10.10.10/ws\",\"vname\":\"${WHICH_VIDEO_INDEX}_Solar.mp4\"}" > solar.config.json.txt
        echo "$(hostname) $d FOUND $WHICH_VIDEO_INDEX"
        echo "$(hostname)" adb -s "$d" push "$filename" "$5"
        adb -s "$d" push "solar.config.json.txt" "$1"
      done

    ;;
    *)
      echo "Invalid choice."
      ;;
    # push301 Solar_test_ .mp4 /sdcard/

  esac
  if [ "$onetime" -ne 0 ]; then
    break
  fi
done

#adb devices | awk 'NR>1 && $1!="" && $2=="device" {print $1}' | xargs -I {} adb -s {} shell am start -a android.intent.action.VIEW -d $URLX


#adb shell am force-stop com.android.settings
#adb shell am force-stop com.android.chrome
#adb shell am start com.android.chrome
#adb shell am start -a android.intent.action.VIEW -d https://decade.tw


#      android.settings.WIMAX_SETTINGS:

# list of commands were commied from output of this:
# adb shell dumpsys | grep "SETTINGS"
# quick hask that seemed to work, but prob. not correct.

#while read L; do
#  [[ -z "$L" ]] && continue
#  printf "\nTry [%s]\n" "$L"
#  adb shell am start -a ${L:: -1}  # remove trailing colon
#  sleep 5
#  printf "NOTE: Watch screen... Settings may FC and after a few seconds android will reboot\n"
#  adb wait-for-device
#done <<EOF
#      android.settings.DATE_SETTINGS:
#      com.android.settings.APPLICATION_DEVELOPMENT_SETTINGS:
#      android.settings.LOCATION_SOURCE_SETTINGS:
#      android.settings.MEMORY_CARD_SETTINGS:
#      android.settings.LOCALE_SETTINGS:
#      android.search.action.SEARCH_SETTINGS:
#      android.net.vpn.SETTINGS:
#      ACCESSIBILITY_FEEDBACK_SETTINGS:
#      android.settings.ACCOUNT_SYNC_SETTINGS:
#      com.android.settings.DISPLAY_SETTINGS:
#      android.settings.INPUT_METHOD_SETTINGS:
#      android.settings.SOUND_SETTINGS:
#      android.settings.WIFI_SETTINGS:
#      android.settings.APPLICATION_SETTINGS:
#      com.android.settings.SOUND_SETTINGS:
#      android.settings.ACCOUNT_SYNC_SETTINGS_ADD_ACCOUNT:
#      android.settings.MANAGE_APPLICATIONS_SETTINGS:
#      android.settings.SYNC_SETTINGS:
#      android.settings.SETTINGS:
#      com.android.settings.DOCK_SETTINGS:
#      android.settings.ADD_ACCOUNT_SETTINGS:
#      android.settings.SECURITY_SETTINGS:
#      android.settings.DEVICE_INFO_SETTINGS:
#      android.settings.WIRELESS_SETTINGS:
#      android.settings.DISPLAY_SETTINGS:
#      android.settings.SYSTEM_UPDATE_SETTINGS:
#      android.settings.MANAGE_ALL_APPLICATIONS_SETTINGS:
#      android.settings.DATA_ROAMING_SETTINGS:
#      android.settings.APN_SETTINGS:
#      android.settings.USER_DICTIONARY_SETTINGS:
#      com.android.settings.VOICE_INPUT_OUTPUT_SETTINGS:
#      com.android.settings.TTS_SETTINGS:
#      android.settings.WIFI_IP_SETTINGS:
#      android.search.action.WEB_SEARCH_SETTINGS:
#      android.settings.BLUETOOTH_SETTINGS:
#      android.settings.AIRPLANE_MODE_SETTINGS:
#      android.settings.INTERNAL_STORAGE_SETTINGS:
#      android.settings.ACCESSIBILITY_SETTINGS:
#      com.android.settings.QUICK_LAUNCH_SETTINGS:
#      android.settings.PRIVACY_SETTINGS:
#EOF

#dumpsys package com.android.chrome
#
#adb shell am start com.android.chrome/.Activity
#monkey -p com.android.chrome -v 500
#adb shell monkey -p com.android.chrome -c android.intent.category.LAUNCHER 1
#adb shell am kill com.android.chrome
#adb shell pidof com.android.chrome | xargs adb shell kill
#adb shell am start -a com.android.chrome
#
#adb shell am start -a android.settings.SETTINGS
#adb shell am start -a com.android.settings.APPLICATION_DEVELOPMENT_SETTINGS

#monkey -p org.mozilla.tv.firefox -c android.intent.category.LAUNCHER 1
#monkey -p org.chromium.chrome -c android.intent.category.LAUNCHER 1

#2311


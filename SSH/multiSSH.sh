#!/bin/bash

#TAGET_SETVER=xpi4g.dojo-smoot.ts.net
TAGET_SETVER=solar.tail1689de.ts.net
#TAGET_SETVER=10.10.10.10
FOLDER_ADBBOSS='/Users/x/Documents/_LANGUGE/IdeaProjects/Solar2025/adbBoss/'
APK='/Users/x/Documents/_LANGUGE/IdeaProjects/Solar2025/processingApp/SolarTab/android/app/build/intermediates/apk/debug/app-debug.apk'
VVV='/Users/x/Movies/Solar_test_301.mp4'
TXT='/Users/x/Documents/_LANGUGE/IdeaProjects/Solar2025/processingApp/SolarTab/android/app/src/solar.config.json.txt'
clear
#scp -P 22 $APK w500@"$TAGET_SETVER":/home/w500/solar2025/www
for (( i=1; i<=15; i++ )); do
  p=$((i+8000))
  echo "<<<<<<<< $p  port...$p"
#  scp -P "$p" $TXT pi@"$TAGET_SETVER":~/Download/
#  scp -P "$p" $VVV pi@"$TAGET_SETVER":~/Download/
#  scp -P "$p" $APK pi@"$TAGET_SETVER":~/Download/

  rsync -avzh -e "ssh -y -p $p" --progress --delete --filter='- /**/' $FOLDER_ADBBOSS pi@"$TAGET_SETVER":/var/www/node/adbBoss/
  ssh pi@"$TAGET_SETVER" -p $p "sh /var/www/node/adbBoss/initRPI.sh"&

#  rsync -avzh -e "ssh -y -p $p" -avzh --delete $FOLDER_ADBBOSS pi@"$TAGET_SETVER":/var/www/node/adbBoss/
#  ssh pi@"$TAGET_SETVER" -p $p "sudo reboot"
  echo ">>>>>>>>> Connecting to adbboss$p  port...$p"
done
#for (( i=1; i<16; i++ )); do
#  p=$((i+8000))
#  echo "Execute to adbboss$p.xpi4g.decade.tw port...$p"
#  ssh pi@"$TAGET_SETVER" -p $p "sh /home/pi/initRPI.sh"&
#done

#COMMANDS=(
#"curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash"
#"nvm install 20"
#"npm install pm2 -g"
#)

#for s in "${SERVERS[@]}"; do
#  echo "Connecting to $s..."
#  scp ./initRPI.sh pi@"$s":~/
#done

#for s in "${SERVERS[@]}"; do
#  echo "Execute to $s..."
#  ssh pi@"$s" "adb devices"
  #  ssh pi@"$s" "sh /home/pi/initRPI.sh"
#  ssh pi@"$s" "rsync -avzh -e 'ssh -p 22' --progress --delete ./ pi@"$s":/var/www/node/adbBoss/"
#  ssh pi@"$s" 'sudo mkdir -p /var/www/node/adbBoss'&
#done

#  joined_string=""
#  for element in "${COMMANDS[@]}"; do
#      if [[ -n "$joined_string" ]]; then
#          joined_string+=" && "
#      fi
#      joined_string+="$element"
#  done
#  echo "$joined_string"
#  echo ssh pi@"$s" \"$joined_string\"
#
#sudo socat TCP-LISTEN:8080,fork TCP:10.10.10.1:80 | \
#socat TCP-LISTEN:8001,fork TCP:adbboss1.local:22 | \
#socat TCP-LISTEN:8002,fork TCP:adbboss2.local:22 | \
#socat TCP-LISTEN:8003,fork TCP:adbboss3.local:22 | \
#socat TCP-LISTEN:8004,fork TCP:adbboss4.local:22 | \
#socat TCP-LISTEN:8005,fork TCP:adbboss5.local:22 | \
#socat TCP-LISTEN:8006,fork TCP:adbboss6.local:22 | \
#socat TCP-LISTEN:8007,fork TCP:adbboss7.local:22 | \
#socat TCP-LISTEN:8008,fork TCP:adbboss8.local:22 | \
#socat TCP-LISTEN:8009,fork TCP:adbboss9.local:22 | \
#socat TCP-LISTEN:8010,fork TCP:adbboss10.local:22 | \
#socat TCP-LISTEN:8011,fork TCP:adbboss11.local:22 | \
#socat TCP-LISTEN:8012,fork TCP:adbboss12.local:22 | \
#socat TCP-LISTEN:8013,fork TCP:adbboss13.local:22 | \
#socat TCP-LISTEN:8014,fork TCP:adbboss14.local:22 | \
#socat TCP-LISTEN:8015,fork TCP:adbboss15.local:22

#sudo socat TCP-LISTEN:80,fork TCP:192.168.50.1:80 | \
#socat TCP-LISTEN:8001,fork TCP:adbboss1.local:22 | \
#socat TCP-LISTEN:8002,fork TCP:adbboss2.local:22 | \
#socat TCP-LISTEN:8003,fork TCP:adbboss3.local:22 | \
#socat TCP-LISTEN:8004,fork TCP:adbboss4.local:22 | \
#socat TCP-LISTEN:8005,fork TCP:adbboss5.local:22 | \
#socat TCP-LISTEN:8006,fork TCP:adbboss6.local:22 | \
#socat TCP-LISTEN:8007,fork TCP:adbboss7.local:22 | \
#socat TCP-LISTEN:8008,fork TCP:adbboss8.local:22 | \
#socat TCP-LISTEN:8009,fork TCP:adbboss9.local:22 | \
#socat TCP-LISTEN:8010,fork TCP:adbboss10.local:22 | \
#socat TCP-LISTEN:8011,fork TCP:adbboss11.local:22 | \
#socat TCP-LISTEN:8012,fork TCP:adbboss12.local:22 | \
#socat TCP-LISTEN:8013,fork TCP:adbboss13.local:22 | \
#socat TCP-LISTEN:8014,fork TCP:adbboss14.local:22 | \
#socat TCP-LISTEN:8015,fork TCP:adbboss15.local:22


#SERVERS=(
#"adbboss1.local" "adbboss2.local" "adbboss3.local" "adbboss4.local" "adbboss5.local"
#"adbboss6.local" "adbboss7.local" "adbboss8.local" "adbboss9.local" "adbboss10.local"
#"adbboss11.local" "adbboss12.local" "adbboss13.local" "adbboss14.local" "adbboss15.local" )

#SERVERS=(
#"adbboss1.local" "adbboss2.local" "adbboss3.local" "adbboss4.local" "adbboss5.local"
#"adbboss6.local" "adbboss7.local" "adbboss8.local" "adbboss9.local" "adbboss10.local"
#"adbboss11.local" "adbboss12.local" "adbboss13.local" "adbboss14.local" "adbboss15.local" )

#SERVERS=(
#"adbboss1.local" "adbboss2.local" "adbboss3.local" "adbboss4.local" "adbboss5.local"
#"adbboss6.local" "adbboss7.local"
#"adbboss11.local" "adbboss12.local" "adbboss13.local" "adbboss14.local" "adbboss15.local" )
#SERVERS=("adbboss8.local" "adbboss9.local" "adbboss10.local" )


#sudo socat TCP-LISTEN:80,fork TCP:192.168.50.1:80 | socat TCP-LISTEN:8001,fork TCP:adbboss1.local:22 | socat TCP-LISTEN:8002,fork TCP:adbboss2.local:22 | socat TCP-LISTEN:8003,fork TCP:adbboss3.local:22 | socat TCP-LISTEN:8004,fork TCP:adbboss4.local:22 | socat TCP-LISTEN:8005,fork TCP:adbboss5.local:22 | socat TCP-LISTEN:8006,fork TCP:adbboss6.local:22 | socat TCP-LISTEN:8007,fork TCP:adbboss7.local:22 | socat TCP-LISTEN:8008,fork TCP:adbboss8.local:22 | socat TCP-LISTEN:8009,fork TCP:adbboss9.local:22 | socat TCP-LISTEN:8010,fork TCP:adbboss10.local:22 | socat TCP-LISTEN:8011,fork TCP:adbboss11.local:22 | socat TCP-LISTEN:8012,fork TCP:adbboss12.local:22 | socat TCP-LISTEN:8013,fork TCP:adbboss13.local:22 | socat TCP-LISTEN:8014,fork TCP:adbboss14.local:22 | socat TCP-LISTEN:8015,fork TCP:adbboss15.local:22

#sudo socat TCP-LISTEN:8080,fork TCP:192.168.50.1:80 | socat TCP-LISTEN:8001,fork TCP:adbboss1.local:22 | socat TCP-LISTEN:8002,fork TCP:adbboss2.local:22 | socat TCP-LISTEN:8003,fork TCP:adbboss3.local:22 | socat TCP-LISTEN:8004,fork TCP:adbboss4.local:22 | socat TCP-LISTEN:8005,fork TCP:adbboss5.local:22 | socat TCP-LISTEN:8006,fork TCP:adbboss6.local:22 | socat TCP-LISTEN:8007,fork TCP:adbboss7.local:22 | socat TCP-LISTEN:8008,fork TCP:adbboss8.local:22 | socat TCP-LISTEN:8009,fork TCP:adbboss9.local:22 | socat TCP-LISTEN:8010,fork TCP:adbboss10.local:22 | socat TCP-LISTEN:8011,fork TCP:adbboss11.local:22 | socat TCP-LISTEN:8012,fork TCP:adbboss12.local:22 | socat TCP-LISTEN:8013,fork TCP:adbboss13.local:22 | socat TCP-LISTEN:8014,fork TCP:adbboss14.local:22 | socat TCP-LISTEN:8015,fork TCP:adbboss15.local:22

#$ services=("${(@f)$(networksetup -listallnetworkservices | grep MT65xx | sed s/\*//)}")
#for service in $services[@]; do networksetup -removenetworkservice $service; done
#for service in $services[@]; do networksetup -deletepppoeservice $service; done

# networksetup -listallnetworkservices | grep MT65xx | while read -r service; do networksetup -setnetworkserviceenabled $service off; done
#networksetup -listallnetworkservices | grep MT65xx | while read -r service; do networksetup -removenetworkservice $service off; done
# for service in $services[@]; do networksetup -removenetworkservice $service; done
#networksetup -listallnetworkservices | grep MT65xx | sed s/\*// | while read -r service; do networksetup -deletepppoeservice $service; done
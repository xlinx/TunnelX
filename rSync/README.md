"scp_o4": "rsync -avzh -e 'ssh -p 22' --progress --delete --exclude 'node_modules' dist/* ubuntu@cc4.decade.tw:/var/www/node/solar/",
"scp_o4_adb": "rsync -avzh -e 'ssh -p 22' --progress --delete --exclude 'node_modules' ../adbGod/adbX.sh ubuntu@cc4.decade.tw:/var/www/node/solar/",
"scp_o4_proxy": "rsync -avzh -e 'ssh -p 22' --progress --delete --exclude 'dist' --exclude 'node_modules' ../proxyServer/* ubuntu@cc4.decade.tw:/var/www/node/solarProxy/",
"scp_itri-art": "rsync -avzh -e 'ssh -p 22' --progress --delete --exclude 'node_modules' dist/* w500@solar.tail1689de.ts.net:/var/www/node/solar/",
"scp_itri-art_proxy": "rsync -avzh -e 'ssh -p 22' --progress --delete --exclude 'dist' --exclude 'node_modules' ../proxyServer/* w500@solar.tail1689de.ts.net:/var/www/node/solarProxy/",
"scp_itri-art_ADBboss": "rsync -avzh -e 'ssh -p 22' --progress --delete --exclude 'dist' --exclude 'node_modules' ../adbGod/* w500@solar.tail1689de.ts.net:/var/www/node/adbGod/",
"scp_xpi4g": "rsync -avzh -e 'ssh -p 22' --progress --delete --exclude 'node_modules' dist/* pi@100.105.55.16:/var/www/node/solar/",
"scp_xpi4g_proxy": "rsync -avzh -e 'ssh -p 22' --progress --delete --exclude 'dist' --exclude 'node_modules' ../proxyServer/* pi@100.105.55.16:/var/www/node/solarProxy/"

#!/bin/bash
wget https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz
mkdir -p /usr/local/lib/nodejs
tar -xJvf node-v20.11.0-linux-x64.tar.xz -C /usr/local/lib/nodejs
apt-get update && apt-get -y install nginx net-tools git
export PATH=/usr/local/lib/nodejs/node-v20.11.0-linux-x64/bin:$PATH
git clone https://github.com/makeevevgeny/deus-240126-2048-game.git /tmp/2048-game
npm install --prefix /tmp/2048-game/ --include=dev
npm run build --prefix /tmp/2048-game/
npm start --prefix /tmp/2048-game/

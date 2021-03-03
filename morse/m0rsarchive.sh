#!/bin/bash

echo "M0rsarchive HTB Solution Script"
echo "Usage: ./m0rsarchive.sh M0rsarchive.zip morsedecode.py"
echo "[!] Starting in 10 seconds..."
sleep 10

#make a new, clean working directory
mkdir ./flagzips

#move to working dir
cd flagzips

#unzip M0rsarchive.zip
unzip -j -o -P hackthebox ../$1 1> /dev/null

#rename original pwd image
mv pwd.png orig_pwd.png

#backup original pwd image
cp orig_pwd.png pwd_999.png

#unzip -j flattens one dir when extracting
#unzip -o overwrites; useful for testing

for ((i=999;i>=0;i--)); do
	unzip -j -o -P $(python3 ../$2 pwd_$i.png) flag_$i.zip 1> /dev/null;
	mv pwd.png pwd_$(( $i-1 )).png
	clear; echo $((1000 - $i))/1000
done

echo "M0rsarchive HTB Solution Script"

#show flag
cat flag

#clean up
cd ..
rm -r ./flagzips

#one-liner: mv pwd.png pwd_999.png; for i in {999..0}; do unzip -j -P $(python3 morsedecode.py pwd_$i.png) flag_$i.zip; mv pwd.png pwd_$(($i - 1)).png ;done ; cat flag


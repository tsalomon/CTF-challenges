:: Windows port forward for ELK stack on Docker
:: Tim Salomonsson

@echo off

Rem elasticsearch(9200)
Rem logstash(5000)
Rem kibana(5601)

set dockerip=172.29.112.1
set localip=192.168.1.163

set eport=9200
set lport=5000
set kport=5601

:: Portforward IPV4 using netsh
:: test command: netsh interface portproxy add v4tov4 listenaddress=192.168.1.163 listenport=5601 connectaddress=172.29.112.1 connectport="5601"

echo "Portforwarding [E]lasticsearch: http://%localip%:%eport% --> %dockerip%:%eport%"

netsh interface portproxy add v4tov4 listenaddress=%localip% listenport=%eport% connectaddress=%dockerip% connectport=%eport%

echo "Portforwarding [L]ogstash     : http://%localip%:%lport% --> %dockerip%:%lport%"

netsh interface portproxy add v4tov4 listenaddress=%localip% listenport=%lport% connectaddress=%dockerip% connectport=%lport%

echo "Portforwarding [K]ibana       : http://%localip%:%kport% --> %dockerip%:%kport%"

netsh interface portproxy add v4tov4 listenaddress=%localip% listenport=%kport% connectaddress=%dockerip% connectport=%kport%

echo Done. Exiting.
exit /B 0
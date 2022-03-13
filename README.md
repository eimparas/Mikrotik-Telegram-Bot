## Telegram bot for Mikrotik devices 

> untested code , i dont use Mikrotik , this is Code and guidence that my friend Kioan ,a Mikrotik guru, gave me. 

* Step one : You create a telegram bot using the tool `@botfather` 
				using telegram you talk to bot father : `/newbot` ,following the instructions there 
				to get the tokens needed . For the sake of this tutorial we name them `HTTPTOKEN`
* Step Two : Open a Chat with the new bot while you look at the website https://api.telegram.org/botHTTPTOKEN/getUpdates
There you will get the message you sent and a number with a `-` in thebeginning . eg: `-123456789`

* Step three : At Mikrotik's web interface go to `system > scripts` , Create a new one , name it what ever
you like it . then input the following: 
```
:global TelegramMessage

:local TelegramBotToken "HTTPTOKEN"
:local TelegramChatID "-123456789"

#:local TelegramURL "https://api.telegram.org/bot$TelegramBotToken/sendMessage\?chat_id=$TelegramChatID&parse_mode=Markdown&text="
:local TelegramURL "https://api.telegram.org/bot$TelegramBotToken/sendMessage\?chat_id=$TelegramChatID&parse_mode=html&text="

## check if variables are defined and send the message
:if (($TelegramBotToken = nil || $TelegramChatID = nil || $TelegramMessage = nil)) do={
  /log error "Telegram Notification: Global variables required: \$TelegramBotToken, \$TelegramChatID, \$TelegramMessage"
} else {
  /tool fetch keep-result=no url=($TelegramURL . $TelegramMessage)
}

## unset TelegramMessage variable
:set TelegramMessage
```
to have it send messagess ,  set your message text to the var `TelegramMessage`  , then run `/system script run telegram` 

For example : 
for the Open VPN , at the `on up` action ,  i have this scrip: 
```
:local srcip
:local dstip
:local remoteaddr
:local localaddr
:local iface

:set srcip $"caller-id"
:set dstip $"called-id"
:set remoteaddr $"remote-address"
:set localaddr $"local-address"
:set iface [/interface get $interface name]

:global TelegramMessage "%F0%9F%94%90 OVPN user <b>$user</b> connected %0A<pre>Src IP: $srcip %0ADst IP: $dstip %0AVPN IP: $remoteaddr</pre>";
 /system script run telegram

#:log info "$user (srcIp=$srcip, dstIp=$dstip) connected: was given $remoteaddr  IP (GW $localaddr ) and assigned to $iface interface"
```



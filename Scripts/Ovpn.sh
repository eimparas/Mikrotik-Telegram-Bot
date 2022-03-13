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

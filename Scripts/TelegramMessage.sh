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
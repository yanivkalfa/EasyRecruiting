EasyRecruiting.Utils.Message = {};

function EasyRecruiting.Utils.Message.officerToUserThroughProxy(msg, to)
  local jsonMessage, message;
  jsonMessage = Json.stringify({ msg = msg, to = to });
  message =  EasyRecruiting.Constants.MSG_PREFIX..jsonMessage;
  SendChatMessage(message, "WHISPER", "Common", ERSettings.proxy);
end

function EasyRecruiting.Utils.Message.officerFromUserThroughProxy(message, sender)
  local parts, parsedMessage, newMessage;
  parts = EasyRecruiting.Utils.General.explode(EasyRecruiting.Constants.MSG_PREFIX, message);
  if( parts[2] ) then
    parsedMessage = Json.parse(parts[2]);
    if(type(parsedMessage) == "table") then
      newMessage = EasyRecruiting.Utils.Message.createMessage(parsedMessage.msg, parsedMessage.sender);
      if ( ERSettings.selectedThread == parsedMessage.sender ) then
        newMessage.isRead = true
      end
      EasyRecruiting:addMessage(newMessage, parsedMessage.sender);
    else
      EasyRecruiting.Utils.General.log('Could not parse the incoming message');
      return false;
    end
  end
end

function EasyRecruiting.Utils.Message.createMessage(msg, sender, isRead)
  isRead = isRead or false;
  return { msg = msg, sender = sender, isRead = isRead };
end

function EasyRecruiting.Utils.Message.proxyToUserFromOfficer(message)
  DEFAULT_CHAT_FRAME:AddMessage(message);
  local parts = EasyRecruiting.Utils.General.explode(EasyRecruiting.Constants.MSG_PREFIX, message);
  local parsedMessage = {};
  DEFAULT_CHAT_FRAME:AddMessage("type(parts)"..type(parts));
  if( parts[2] ) then
    parsedMessage = Json.parse(parts[2]);
    if(type(parsedMessage) == "table") then
      SendChatMessage(parsedMessage.msg, "WHISPER", "Common", parsedMessage.to);
    else
      EasyRecruiting.Utils.General.log('Could not parse the incoming message');
      return false;
    end
  end
end

function EasyRecruiting.Utils.Message.proxyToOfficerFromUser(message, sender)
  local jsonMessage, firstMessagePart, nextMessagePart, encodedMessage;
  firstMessagePart = string.sub(message, 1, 50);
  nextMessagePart = string.sub(message, 51);
  jsonMessage = Json.stringify(EasyRecruiting.Utils.Message.createMessage(firstMessagePart, sender));
  encodedMessage = EasyRecruiting.Constants.MSG_PREFIX..jsonMessage;

  for index, value in pairs(ERSettings.officers) do
    SendChatMessage(encodedMessage, "WHISPER", "Common", value);
  end;

  if (string.len(nextMessagePart) > 0 ) then
    EasyRecruiting.Utils.Message.proxyToOfficerFromUser(nextMessagePart, sender);
  end
end

function EasyRecruiting.Utils.Message.routeWshipers(self, message, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  local playerName, realm = EasyRecruiting.Utils.General.getFullPlayerName(), newMessage;
  if( playerName == ERSettings.proxy ) then
    if( EasyRecruiting.Utils.Table.indexOf(ERSettings.officers, sender) >= 1) then
      EasyRecruiting.Utils.Message.proxyToUserFromOfficer(message);
      DEFAULT_CHAT_FRAME:AddMessage("I am proxy message from officers - proxy to user");
    else
      EasyRecruiting.Utils.Message.proxyToOfficerFromUser(message, sender);
      DEFAULT_CHAT_FRAME:AddMessage("I am proxy message from user - proxy to officers");
    end
  elseif( EasyRecruiting.Utils.Table.indexOf(ERSettings.officers, playerName) >= 1 ) then
    if( sender == ERSettings.proxy ) then
      DEFAULT_CHAT_FRAME:AddMessage("I am officer message from proxy - display message");
      EasyRecruiting.Utils.Message.officerFromUserThroughProxy(message, sender);
    end
  end
end

--__ER__{"msg": "aaaaaaaaaaaaa", "to": "Zeemonk-Silvermoon"}
--__ER__{"msg": "aaaaaaaaaaaaa", "sender": "nefeli-Silvermoon"}
--12345678910111213141516171819202122232425262728293031323334353637383934041424344454647484950515253545556575859606162636465666768697071727374757677787980818283848586878889909192939495969798991001011021031041051061071081091101111121131141151161171181191201211221231241251261271281913013113213313413513613713819140141142143144145146147148149150






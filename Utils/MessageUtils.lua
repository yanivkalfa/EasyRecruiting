EasyRecruiting.Utils.Message = {};

function EasyRecruiting.Utils.Message.parseMessage(message)
  local parts = EasyRecruiting.Utils.General.explode(EasyRecruiting.Constants.MSG_PREFIX, message);
  local parsedMessage = {};
  if (parts[2]) then
    parsedMessage = Json.parse(parts[2]);
    if (type(parsedMessage) == "table") then
      return parsedMessage;
    else
      EasyRecruiting.Utils.General.log('Could not parse the incoming message');
      return false;
    end
  end
end

function EasyRecruiting.Utils.Message.createChatMessage(msg, sender, isRead)
  isRead = isRead or false;
  return { msg = msg, sender = sender, isRead = isRead };
end

function EasyRecruiting.Utils.Message.createNotifyMessage(event)
  return { type = "notify", event = event };
end

function EasyRecruiting.Utils.Message.createSpamMessage(msg, num)
  return { type = "spam", msg = msg, num = num };
end

function EasyRecruiting.Utils.Message.createUserMessage(msg, to)
  return { msg = msg, to = to };
end

function EasyRecruiting.Utils.Message.stringifyMessage(msg)
  return EasyRecruiting.Constants.MSG_PREFIX .. Json.stringify(msg);
end

function EasyRecruiting.Utils.Message.sendToProxy(encodedMessage)
  SendChatMessage(encodedMessage, "WHISPER", "Common", ERSettings.proxy);
end

function EasyRecruiting.Utils.Message.prepareAndSendNotifyToProxy(event)
  local message = EasyRecruiting.Utils.Message.createNotifyMessage(event);
  local stringifiedMessage = EasyRecruiting.Utils.Message.stringifyMessage(message);
  EasyRecruiting.Utils.Message.sendToProxy(stringifiedMessage);
end

function EasyRecruiting.Utils.Message.prepareAndsendToUserThroughProxy(msg, to)
  local message = EasyRecruiting.Utils.Message.createUserMessage(msg, to);
  local stringifiedMessage = EasyRecruiting.Utils.Message.stringifyMessage(message);
  EasyRecruiting.Utils.Message.sendToProxy(stringifiedMessage);
end

function EasyRecruiting.Utils.Message.prepareAndSendSpamToProxy(msg, num)
  local message = EasyRecruiting.Utils.Message.createSpamMessage(msg, num);
  local stringifiedMessage = EasyRecruiting.Utils.Message.stringifyMessage(message);
  EasyRecruiting.Utils.Message.sendToProxy(stringifiedMessage);
end

function EasyRecruiting.Utils.Message.fromUserThroughProxy(parsedMessage)
  local newMessage = EasyRecruiting.Utils.Message.createChatMessage(parsedMessage.msg, parsedMessage.sender);
  if (ERSettings.selectedThread == parsedMessage.sender) then
    newMessage.isRead = true
  end
  EasyRecruiting:addMessage(newMessage, parsedMessage.sender, parsedMessage.cId);
end

function EasyRecruiting.Utils.Message.routeWshipers(self, message, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if (sender == ERSettings.proxy) then
    local parsedMessage = EasyRecruiting.Utils.Message.parseMessage(message);

    if (parsedMessage) then
      if (parsedMessage.type == "notify") then
        EasyRecruiting:setIsAfk(parsedMessage.args);
        return true;
      end

      if (parsedMessage.type == "action") then
        -- do action

        return true;
      end

      if ( parsedMessage.type == "ack" ) then
        EasyRecruiting:spamSent(parsedMessage.num);
        return true;
      end

      EasyRecruiting.Utils.Message.fromUserThroughProxy(parsedMessage);
    end
  end
end
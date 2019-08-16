EasyRecruiting.UserChatFrame = {};

function EasyRecruiting.UserChatFrame.onLoad(self)
  self.ScrollBar = Scroller;
  self:SetFontObject(GameFontNormal);
  self:EnableMouse(true);
  self:EnableMouseWheel(true);
  self:SetTextColor(1, 1, 1, 1);
  self:SetJustifyH("LEFT");
  self:SetHyperlinksEnabled(true);
  self:SetFading(false);
  self:SetMaxLines(300);

  self:SetScript("OnMouseWheel", function(self, delta)
    local cur_val = self.ScrollBar:GetValue()
    local min_val, max_val = Scroller:GetMinMaxValues();

    if delta < 0 and cur_val < max_val then
      cur_val = math.min(max_val, cur_val + 1)
      self.ScrollBar:SetValue(cur_val)
    elseif delta > 0 and cur_val > min_val then
      cur_val = math.max(min_val, cur_val - 1)
      self.ScrollBar:SetValue(cur_val)
    end
  end)
end

function EasyRecruiting.UserChatFrame.updateScroll()
  local numMessages = UserMessages:GetNumMessages();
  local isShown = numMessages > 1;
  UserMessages.ScrollBar:SetShown(isShown);
  if isShown then
    UserMessages.ScrollBar:SetMinMaxValues(1, numMessages);
    UserMessages.ScrollBar:SetValue(numMessages);
  end
end

function EasyRecruiting.UserChatFrame.onHyperlinkShow(self, link, text, button)
  SetItemRef(link, text, button, self);
end

function EasyRecruiting.UserChatFrame.prepareMessage(message, thread)
  local playerName, prefix, color, justName, playerLink;
  playerName = EasyRecruiting.Utils.General.getFullPlayerName();
  color = EasyRecruiting.Constants.CLASS_COLORS[thread.cId];
  justName = unpack(EasyRecruiting.Utils.General.explode("-", thread.name));
  playerLink = "|c" .. color.colorStr .. GetPlayerLink(thread.name, justName) .. "|r";
  prefix = "[" .. playerLink .. "] whispers: ";

  if (playerName == message.sender) then
    prefix = "To [" .. playerLink .. "]: ";
  end

  return prefix .. ": " .. message.msg;
end

function EasyRecruiting.UserChatFrame.addNewMessage(message, thread)
  local color = EasyRecruiting.Constants.WHISPER_COLOR;
  local preparedMessage = EasyRecruiting.UserChatFrame.prepareMessage(message, thread);
  UserMessages:AddMessage(preparedMessage, color.r, color.g, color.b);
  EasyRecruiting.UserChatFrame.updateScroll();
end

function EasyRecruiting.UserChatFrame.clearMessages()
  UserMessages:Clear();
  EasyRecruiting.UserChatFrame.updateScroll();
end

function EasyRecruiting.UserChatFrame.render()
  local thread, messages;
  messages = {}
  EasyRecruiting.UserChatFrame.clearMessages();
  if (ERSettings.selectedThread) then
    thread = EasyRecruiting.threads.getThread(ERSettings.selectedThread);
    if( thread ) then
      messages = thread.messages;
    end
  end

  if (messages) then
    for index, message in pairs(messages) do
      message.isRead = true;
      EasyRecruiting.UserChatFrame.addNewMessage(message, thread);
    end;
  end
end


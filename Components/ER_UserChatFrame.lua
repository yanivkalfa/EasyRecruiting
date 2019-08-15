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

function EasyRecruiting.UserChatFrame.prepareMessage(message)
  local playerName, realm = EasyRecruiting.Utils.General.getFullPlayerName();
  local prefix = "Received: ";
  
  if ( playerName == message.sender ) then
    prefix = "Sent:";
  end
  
  return prefix..": "..message.msg;
end

function EasyRecruiting.UserChatFrame.addNewMessage(message, ...)
  local preparedMessage = EasyRecruiting.UserChatFrame.prepareMessage(message);
  UserMessages:AddMessage(preparedMessage, ...);
  EasyRecruiting.UserChatFrame.updateScroll();
end

function EasyRecruiting.UserChatFrame.clearMessages()
  UserMessages:Clear();
  EasyRecruiting.UserChatFrame.updateScroll();
end

function EasyRecruiting.UserChatFrame.render()
  local messages = {};
  EasyRecruiting.UserChatFrame.clearMessages();
  if ( ERSettings.selectedThread ) then 
    messages = EasyRecruiting.threads.getThreadMessages(ERSettings.selectedThread);
  end
  
  if ( messages ) then 
    for index, message in pairs(messages) do
      message.isRead = true;
      EasyRecruiting.UserChatFrame.addNewMessage(message);
    end;
  end
end


EasyRecruiting.UserScrollFrames = {}

function EasyRecruiting.UserScrollFrames.resetSelected()
  for line = 1, EasyRecruiting.Constants.MAX_PAGE_SIZE do
    _G["UserSlot" .. line]:SetButtonState("NORMAL");
  end
end

function EasyRecruiting.UserScrollFrames.onUserClick(self)
  EasyRecruiting.UserScrollFrames.resetSelected();
  ERSettings.selectedThread = self.thread.name;
  EasyRecruiting:renderChat();
end

function EasyRecruiting.UserScrollFrames.updateListButton(itemName, thread, itemButton, unreadCount)
  local itemText, parts, name, realm, itemUnreadCount;

  itemText = _G[itemName .. "Name"];
  itemUnreadCount = _G[itemName .. "UnreadCount"];
  name, realm = unpack(EasyRecruiting.Utils.General.explode("-", thread.name));
  itemText:SetText(name);

  if (unreadCount > 0) then
    itemUnreadCount:SetText(unreadCount);
    itemUnreadCount:Show();
  else
    itemUnreadCount:Hide();
  end


  if (ERSettings.selectedThread == thread.name) then
    itemButton:SetButtonState("PUSHED", true);
  else
    itemButton:SetButtonState("NORMAL");
  end
end

function EasyRecruiting.UserScrollFrames.updateList()
  local thread, line, index, itemButton, itemName, totalResults, unreadCount, threadWithUnreadCount;
  threadWithUnreadCount = 0;
  totalResults = table.getn(ERSettings.threads);

  FauxScrollFrame_Update(UserSelectTabScrollFrame, totalResults, EasyRecruiting.Constants.MAX_PAGE_SIZE, EasyRecruiting.Constants.USER_ITEM_HEIGHT);
  for line = 1, EasyRecruiting.Constants.MAX_PAGE_SIZE do
    index = line + FauxScrollFrame_GetOffset(UserSelectTabScrollFrame);
    itemName = "UserSlot" .. line;
    itemButton = _G[itemName];

    if (totalResults > EasyRecruiting.Constants.MAX_PAGE_SIZE) then
      itemButton:SetWidth(110);
    else
      itemButton:SetWidth(130);
    end

    if (index <= totalResults) then
      thread = ERSettings.threads[index];
      itemButton:Show();
      itemButton.thread = thread;
      unreadCount = EasyRecruiting.threads.getUnreadCount(thread);
      if ( unreadCount > 0) then
        threadWithUnreadCount = threadWithUnreadCount + 1;
      end
      EasyRecruiting.UserScrollFrames.updateListButton(itemName, thread, itemButton, unreadCount);
    else
      itemButton.thread = {};
      itemButton:Hide();
    end
  end

  if ( threadWithUnreadCount > 0 ) then
    EasyRecruiting.minimapButton:SetButtonState("PUSHED", true);
    EasyRecruiting.minimapButton.FontString:SetText(threadWithUnreadCount);
  else
    EasyRecruiting.minimapButton:SetButtonState("NORMAL");
    EasyRecruiting.minimapButton.FontString:SetText("");
  end
end

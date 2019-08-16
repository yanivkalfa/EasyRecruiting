EasyRecruiting = CreateFrame("Frame", "ERMainContainerFrame", UIParent);
EasyRecruiting.addonName = "EasyRecruiting";
EasyRecruiting.Constants = {};
EasyRecruiting.UserChatFrame = {};
EasyRecruiting.UserScrollFrames = {};
EasyRecruiting.threads = {};
EasyRecruiting.initiated = nil;
EasyRecruiting.Utils = {};
EasyRecruiting.spamTimeout = nil;

ERSettings = ERSettings or {
  minimap = {
    hide = false,
  },
  proxy = "",
  spamTimeout = 30,
  spamMsg1 = "",
  spamMsg2 = "",
  spamMsg3 = "",
  selectedThread = "",
  threads = {}
};

function EasyRecruiting:renderChat()
  EasyRecruiting.UserChatFrame.render();
  EasyRecruiting.UserScrollFrames.updateList();
end

function EasyRecruiting:addMessage(message, threadName, cId)
  EasyRecruiting.threads.addMessageToThread(threadName, message, cId);
  if (ERSettings.selectedThread == threadName) then
    local thread = EasyRecruiting.threads.getThread(threadName);
    EasyRecruiting.UserChatFrame.addNewMessage(message, thread);
  end
  EasyRecruiting.UserScrollFrames.updateList();
end

function EasyRecruiting:sendNewMessage()
  local threadName, message, playerName, text;
  text = UserMessageEditBox:GetText();
  if (string.len(text) > 0) then
    playerName = EasyRecruiting.Utils.General.getFullPlayerName();
    threadName = ERSettings.selectedThread;
    message = EasyRecruiting.Utils.Message.createChatMessage(text, playerName, true);
    EasyRecruiting:addMessage(message, threadName);
    UserMessageEditBox:SetText("");
    EasyRecruiting.Utils.Message.prepareAndsendToUserThroughProxy(message.msg, threadName)
  end
end

function EasyRecruiting:deleteThread(threadName)
  EasyRecruiting.threads.removeThread(threadName);
  if (ERSettings.selectedThread == threadName) then
    local threadCount = table.getn(ERSettings.threads);
    if (threadCount > 0) then
      ERSettings.selectedThread = ERSettings.threads[1].name;
    end
    EasyRecruiting:renderChat();
  else
    EasyRecruiting.UserScrollFrames.updateList();
  end
end

function EasyRecruiting:setSpamBottonsState(state)
  easyRecruitingSpam1:SetButtonState(state);
  easyRecruitingSpam2:SetButtonState(state);
  easyRecruitingSpam3:SetButtonState(state);
end

function EasyRecruiting:sendSpam(settingName, num)
  EasyRecruiting:setSpamBottonsState("DISABLED");
  EasyRecruiting.Utils.Message.prepareAndSendSpamToProxy(ERSettings[settingName], num);
  EasyRecruiting.spamTimeout = Timer.setTimeout(
    ERSettings.spamTimeout,
    function() EasyRecruiting:setSpamBottonsState("NORMAL"); end
  );
end

function EasyRecruiting:spamSent()
  if ( EasyRecruiting.spamTimeout ) then
    Timer.clearTimer(EasyRecruiting.spamTimeout);
  end
  EasyRecruiting:setSpamBottonsState("DISABLED");
  EasyRecruiting.spamTimeout = Timer.setTimeout(
    ERSettings.spamTimeout,
    function() EasyRecruiting:setSpamBottonsState("NORMAL"); end
  );
end

function EasyRecruiting:updateVisability(settingName, ref)
  if (string.len(ERSettings[settingName]) > 0) then
    ref:Show();
  else
    ref:Hide();
  end
end

function EasyRecruiting:toggleOptions()
  if (EasyRecruitingOptions:IsShown()) then
    EasyRecruitingOptions:Hide();
  else
    EasyRecruitingOptions:Show();
  end
end

function EasyRecruiting:toggleChat()
  if (ERMainFrame:IsShown()) then
    ERMainFrame:Hide();
  else
    ERMainFrame:Show();
  end
end

function EasyRecruiting:OnEvent(event, ...)
  local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 = ...;

  if (event == "PLAYER_ENTERING_WORLD") then
    EasyRecruiting:init();
  end

  if (event == "CHAT_MSG_WHISPER") then
    EasyRecruiting.Utils.Message.routeWshipers(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
  end
end

function EasyRecruiting:init()
  if (not self.initiated) then
    local easyRecruitingLDB, icon;
    self.Utils.General.hidePrefixedMessages();
    --if LibStub("LibDataBroker-1.1", true) then
      easyRecruitingLDB = LibStub("LibDataBroker-1.1"):NewDataObject(EasyRecruiting.addonName, {
        type = "data source",
        icon = "Interface\\AddOns\\EasyRecruiting\\Icons\\BattlenetWorking0",
        OnClick = EasyRecruiting.toggleChat,
      });
    --end

    --if LibStub("LibDBIcon-1.0", true) then
      icon = LibStub("LibDBIcon-1.0");
      icon:Register(EasyRecruiting.addonName, easyRecruitingLDB, ERSettings.minimap);
    --end
    EasyRecruiting:renderChat();
    EasyRecruiting.initiated = true;
  end
end

function EasyRecruiting:bindEvents()
  self:RegisterEvent("CHAT_MSG_WHISPER");
  self:RegisterEvent("PLAYER_ENTERING_WORLD");
  self:SetScript("OnEvent", self.OnEvent);
end

function EasyRecruiting:RegisterSlashCommands()
  -- Register our slash command
  SLASH_ER1 = "/ER";
  SLASH_ER2 = "/EasyRecruiting";
  SlashCmdList["ER"] = function(msg)
    EasyRecruiting.toggleChat();
  end
end

EasyRecruiting:RegisterSlashCommands();
EasyRecruiting:bindEvents();

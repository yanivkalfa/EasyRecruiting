EasyRecruiting = CreateFrame("Frame", "ERMainContainerFrame", UIParent);
EasyRecruiting.isOfficer = false;
EasyRecruiting.addonName = "EasyRecruiting";
EasyRecruiting.isOpened = false;
EasyRecruiting.Constants = {};
EasyRecruiting.UserChatFrame = {};
EasyRecruiting.threads = {};
EasyRecruiting.initiated = nil;
EasyRecruiting.Utils = {};
EasyRecruiting.MinimapIcon = {};


ERSettings = ERSettings or {
  proxy = "Huntarion-Silvermoon",
  officers = {
    "Zeemonk-Silvermoon", 
    "nefeli-Silvermoon"
  },
  minimap = {
    hide = false,
  },
  selectedThread = "nefeli-Silvermoon",
  threads = {
    { 
      name = "nefeli-Silvermoon",
      messages = {
        { msg = "hey whats up", sender = "Zeemonk-Silvermoon", isRead = false },
        { msg = "waaaattt", sender = "nefeli-Silvermoon" },
        { msg = "ha789dshasdasd asd", sender = "nefeli-Silvermoon", isRead = false  },
        { msg = "d a7sdg9867g32", sender = "nefeli-Silvermoon", isRead = false  },
        { msg = "lady Gaggaaaaaa", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "NO WAY!!!", sender = "nefeli-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelia-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "d4d4", sender = "Lilior-Silvermoon" },
        { msg = "ha789d44shasdasd asd", sender = "Lilior-Silvermoon", isRead = false  },
        { msg = "d d44", sender = "Lilior-Silvermoon", isRead = false  },
        { msg = "lady asdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelib-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "d4d4", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "ha78Liliora9d44shasdasd asd", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "d d44", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "lady Lilioraasdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelic-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "ha789d44shasdasd asd", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "d  Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "lady asdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelid-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "d4d4", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "ha78Liliora9d44shasdasd asd", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "d d44", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "lady Lilioraasdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelie-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "ha789d44shasdasd asd", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "d  Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "lady asdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelif-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "d4d4", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "ha78Liliora9d44shasdasd asd", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "d d44", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "lady Lilioraasdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelig-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "ha789d44shasdasd asd", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "d  Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "lady asdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelih-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "d4d4", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "ha78Liliora9d44shasdasd asd", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "d d44", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "lady Lilioraasdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelii-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "ha789d44shasdasd asd", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "d  Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "lady asdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelij-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "d4d4", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "ha78Liliora9d44shasdasd asd", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "d d44", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "lady Lilioraasdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelik-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "ha789d44shasdasd asd", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "d  Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "lady asdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelil-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "d4d4", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "ha78Liliora9d44shasdasd asd", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "d d44", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "lady Lilioraasdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelim-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "ha789d44shasdasd asd", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "d  Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "lady asdasd", sender = "Zeemonk-Silvermoon", isRead = false },
      }
    },
    { 
      name = "nefelin-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "d4d4", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "ha78Liliora9d44shasdasd asd", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "d d44", sender = "Liliora-Silvermoon", isRead = false  },
        { msg = "lady Lilioraasdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    },
    { 
      name = "nefelip-Silvermoon",
      messages = {
        { msg = "hey asdasd up", sender = "Zeemonk-Silvermoon", isRead = false  },
        { msg = "Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "ha789d44shasdasd asd", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "d  Liliorb", sender = "Liliorb-Silvermoon", isRead = false  },
        { msg = "lady asdasd", sender = "Zeemonk-Silvermoon", isRead = false  },
      }
    }
  }
};

function EasyRecruiting:renderChat()
  EasyRecruiting.UserChatFrame.render();
  EasyRecruiting.UserScrollFrames.updateList();
end

function EasyRecruiting:addMessage(message, threadName)
  local msg, isNew = EasyRecruiting.threads.addMessageToThread(threadName, message);
  if ( isNew ) then 
    DEFAULT_CHAT_FRAME:AddMessage("isNew");
    ERSettings.selectedThread = threadName;
    EasyRecruiting:renderChat();
  else
    if ( ERSettings.selectedThread == threadName ) then
      EasyRecruiting.UserChatFrame.addNewMessage(message);
    end
    EasyRecruiting.UserScrollFrames.updateList();
  end
end

function EasyRecruiting:sendNewMessage()
  local threadName, message, playerName, text;
  text = UserMessageEditBox:GetText();
  if ( string.len(text) > 0 ) then 
    playerName = EasyRecruiting.Utils.General.getFullPlayerName();
    threadName = ERSettings.selectedThread;
    message = EasyRecruiting.Utils.Message.createMessage(text, playerName, true);
    EasyRecruiting:addMessage(message, threadName);
    UserMessageEditBox:SetText("");
    EasyRecruiting.Utils.Message.officerToUserThroughProxy(message.msg, threadName)
  end
end

function EasyRecruiting:deleteThread(threadName)
  EasyRecruiting.threads.removeThread(threadName);
  if ( ERSettings.selectedThread == threadName ) then 
    local threadCount = table.getn(ERSettings.threads);
    if ( threadCount > 0 ) then 
      ERSettings.selectedThread = ERSettings.threads[1].name;
    end
    EasyRecruiting:renderChat();
  else
    EasyRecruiting.UserScrollFrames.updateList();
  end
end

function EasyRecruiting:toggleChat()
  if( not EasyRecruiting.isOfficer ) then 
    return false;
  end
  
  if ( EasyRecruiting.isOpened ) then
    EasyRecruiting.isOpened = false;
    ERMainFrame:Hide();
  else
    EasyRecruiting.isOpened = true;
    ERMainFrame:Show();
  end
end

function EasyRecruiting:OnEvent(event, ...)
  local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 = ...;

  if ( event == "PLAYER_ENTERING_WORLD") then
    local playerName = EasyRecruiting.Utils.General.getFullPlayerName();
    EasyRecruiting.isOfficer = EasyRecruiting.Utils.Table.indexOf(ERSettings.officers, playerName) >= 1;
    EasyRecruiting:init();
  end

  if ( event == "CHAT_MSG_WHISPER") then
    EasyRecruiting.Utils.Message.routeWshipers(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
  end
end

function EasyRecruiting:init()
  if ( not self.initiated ) then
    --self.Utils.General.hidePrefixedmsgs();
    if( EasyRecruiting.isOfficer ) then 
      local easyRecruitingLDB = LibStub("LibDataBroker-1.1"):NewDataObject(EasyRecruiting.addonName, {
        type = "data source",
        --  type = "button",
        icon = "Interface\\AddOns\\EasyRecruiting\\Icons\\frames\\BattlenetWorking0",
        OnClick = EasyRecruiting.toggleChat,
      });
      local icon = LibStub("LibDBIcon-1.0");
      icon:Register(EasyRecruiting.addonName, easyRecruitingLDB, ERSettings.minimap);
      EasyRecruiting:renderChat();
    end
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

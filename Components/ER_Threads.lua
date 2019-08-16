EasyRecruiting.threads = {};

function EasyRecruiting.threads.createNewThread(name, cId)
  return {
    name = name,
    cId = cId,
    messages = {}
  };
end

function EasyRecruiting.threads.getThread(name)
  local thread = EasyRecruiting.Utils.Table.find(ERSettings.threads, function(index, value) return value.name == name end);
  if (thread) then
    return thread;
  end

  return false;
end

function EasyRecruiting.threads.addThread(name, cId)
  local thread = EasyRecruiting.threads.getThread(name);
  if (thread) then
    return thread, false;
  end

  local newThread = EasyRecruiting.threads.createNewThread(name, cId);
  table.insert(ERSettings.threads, 1, newThread);
  return newThread, true;
end

function EasyRecruiting.threads.removeThread(name)
  local threadIndex = EasyRecruiting.Utils.Table.findIndex(ERSettings.threads, function(index, value) return value.name == name end);
  if (threadIndex == 0) then
    return false;
  end

  table.remove(ERSettings.threads, threadIndex);
  return true;
end


function EasyRecruiting.threads.getThreadMessages(name)
  local thread = EasyRecruiting.threads.getThread(name);
  if (thread) then
    return thread.messages;
  end

  return false;
end

function EasyRecruiting.threads.addMessageToThread(name, message, cId)
  local thread, isNew = EasyRecruiting.threads.addThread(name, cId);
  table.insert(thread.messages, message);
  return message, isNew;
end

function EasyRecruiting.threads.getUnreadCount(thread)
  local unreadCount = 0;
  if (thread.messages) then
    for index, message in pairs(thread.messages) do
      if (message.isRead == false) then
        unreadCount = unreadCount + 1;
      end
    end;
  end

  return unreadCount;
end


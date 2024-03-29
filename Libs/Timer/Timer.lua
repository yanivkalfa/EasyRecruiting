local f = CreateFrame("Frame", "TimerFrame", UIParent);
Timer = {};
Timer.timers = {};
Timer.onUpdateInterval = 0.1;
Timer.timeSinceLastUpdate = 0;
Timer.loopStarted = false;

local function calcExpireAt(interval)
  return time() + interval;
end

local function isItTime(expireAt)
  return time() >= expireAt;
end

local function checkAllTimers()
  for index, timer in pairs(Timer.timers) do
    if (isItTime(timer.expireAt)) then
      if (timer.isInterval) then
        timer.expireAt = calcExpireAt(timer.interval);
        if (timer.argTable) then
          timer.callback(unpack(timer.argTable));
        else
          timer.callback();
        end
      else
        if (timer.argTable) then
          timer.callback(unpack(timer.argTable));
        else
          timer.callback();
        end
        Timer.clearTimer(timer.id);
      end
    end
  end;
end

local function onUpdate(self, elapsed)
  Timer.timeSinceLastUpdate = Timer.timeSinceLastUpdate + elapsed;
  if Timer.timeSinceLastUpdate >= Timer.onUpdateInterval then
    Timer.timeSinceLastUpdate = 0;
    checkAllTimers();
  end
end


local function startLoop()
  if (Timer.loopStarted) then
    return false;
  end
  f:SetScript("OnUpdate", onUpdate);
  Timer.loopStarted = true;
  Timer.onUpdateInterval = 0.1;
  Timer.timeSinceLastUpdate = 0;
end

local function endLoop()
  if (Timer.loopStarted ~= true) then
    return false;
  end
  f:SetScript("OnUpdate", nil);
  Timer.loopStarted = false;
end

local function haveTimers()
  return table.getn(Timer.timers) > 0;
end

local function checkForTimers()
  if (haveTimers()) then
    startLoop();
  else
    endLoop();
  end
end

local function createTableTimer(expireAt, interval, isInterval, callback, argTable)
  return { id = EasyRecruiting.Utils.General.randomString(), expireAt = expireAt; interval = interval; isInterval = isInterval; callback = callback; argTable = argTable };
end

-- public functions
function Timer.setInterval(interval, callback, argTable)
  if (type(interval) ~= "number" or type(callback) ~= "function") then
    return false;
  end
  local expireAt = calcExpireAt(interval);
  local timer = createTableTimer(expireAt, interval, true, callback, argTable);
  table.insert(Timer.timers, timer);
  checkForTimers();
  return timer.id;
end

function Timer.setTimeout(interval, callback, argTable)
  if (type(interval) ~= "number" or type(callback) ~= "function") then
    return false;
  end
  local expireAt = calcExpireAt(interval);
  local timer = createTableTimer(expireAt, interval, false, callback, argTable);
  table.insert(Timer.timers, timer);
  checkForTimers();
  return timer.id;
end

function Timer.clearTimer(timerId)
  local index = EasyRecruiting.Utils.Table.findIndex(Timer.timers, function(index, timer) return timer.id == timerId; end);
  if ( index > 0 ) then
    table.remove(Timer.timers, index);
  end
  checkForTimers();
end

TpsControls = {
  stepSize = 1,
  baseTps = 20,
  fastTps = 300,

  step = function()
    exec("tick step " .. tostring(TpsControls.stepSize))
  end,

  toggleThroughTps = function()
    local currentTps = server.tps.limit()

    if currentTps ~= TpsControls.baseTps then
      exec("tpslimit " .. TpsControls.baseTps)
    else
      exec("tpslimit " .. TpsControls.fastTps)
    end
  end
}

local function tickStep_hotkey(pressed)
  if pressed then
    TpsControls.step()
  end
end

local function toggleThroughTps_hotkey(pressed)
  if pressed then
    TpsControls.unfreeze()
  end
end


hotkey("x", tickStep_hotkey)
hotkey("ctrl+x", toggleThroughTps_hotkey)

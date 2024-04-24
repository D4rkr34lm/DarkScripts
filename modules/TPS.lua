TPS = {}

TPS.stepSize = 1

function TPS.handleStepSizeCommand(params)
  if params[1] == nil then
    Core.send("StepSize is " .. Core.highlight(tostring(TPS.stepSize)))
  else
    Core.send("Set StepSize to " .. Core.highlight(params[1]))
    TPS.stepSize = tonumber(params[1])
  end
end

function TPS.handleTickStep(pressed)
  if pressed then
    exec("tick step " .. tostring(TPS.stepSize))
  end
end

function TPS.handleTickUnfreeze(pressed)
  if pressed then
    exec("tpslimit 20")
  end
end

hotkey("x", TPS.handleTickStep)
hotkey("ctrl+x", TPS.handleTickUnfreeze)
command("stepsize", TPS.handleStepSizeCommand)

TpsControls = {}

TpsControls.stepSize = 1;

function TpsControls.step()
  exec("tick step " .. tostring(TpsControls.stepSize))
end

function TpsControls.unfreeze()
  exec("tpslimit 20")
end

hotkey("x", HandlerFunction(TpsControls.step))
hotkey("ctrl+x", HandlerFunction(TpsControls.unfreeze))

TpsControls = {}

TpsControls.stepSize = 1;

function TpsControls.step()
  exec("tick step " .. tostring(TpsControls.stepSize))
end

function TpsControls.unfreeze()
  exec("tpslimit 20")
end

hotkey("x",
  function(pressed)
    if pressed then
      TpsControls.step()
    end
  end)
hotkey("ctrl+x",
  function(pressed)
    if pressed then
      TpsControls.unfreeze()
    end
  end)

StopLagControls = {
  toggleFreeze = function()
    exec("sl")
  end
}

function stopLag_hotkey(pressed)
  if pressed then
    StopLagControls.toggleFreeze()
  end
end

hotkey("h", stopLag_hotkey)

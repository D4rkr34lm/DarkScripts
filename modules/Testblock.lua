TB = {}

-- paste testblock
function TB.onTb(pressed)
  if pressed then
    if region.type() == 'wg' then
      exec("tb Testbloecke/tb -e")
    elseif region.type() == 'mwg' then
      exec("tb Testbloecke/tbm -e")
    end
  end
end

function TB.onTbShield(pressed)
  if pressed then
    if region.type() == 'wg' then
      exec("tb Testbloecke/tbs")
    elseif region.type() == "mwg" then
      exec("tb Testbloecke/tbms")
    elseif region.type() == "ws" then
      exec("tb Testbloecke/wstb")
    end
  end
end

hotkey("v", TB.onTb)
hotkey("ctrl", TB.onTbShield)

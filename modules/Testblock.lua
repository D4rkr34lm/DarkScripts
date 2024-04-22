TB = {}
SelectedTb = nil

function TB.handleSetTb(args)
  SelectedTb = args[1]
  if args[1] == nil then
    Core.send("Now using default tb")
  else
    Core.send("Now using " .. Core.highlight(args[1]) .. " as tb")
  end
end

function TB.handleTbPaste(pressed)
  if pressed then
    if SelectedTb ~= nil then
      exec("tb Testbloecke/" .. SelectedTb)
    elseif region.type() == 'wg' then
      exec("tb Testbloecke/tb -e")
    elseif region.type() == 'mwg' then
      exec("tb Testbloecke/tbm -e")
    end
  end
end

function TB.handleTbShieldPaste(pressed)
  if pressed then
    if SelectedTb ~= nil then
      exec("tb Testbloecke/" .. SelectedTb .. "s")
    elseif region.type() == 'wg' then
      exec("tb Testbloecke/tbs")
    elseif region.type() == "mwg" then
      exec("tb Testbloecke/tbms")
    end
  end
end

hotkey("v", TB.handleTbPaste)
hotkey("ctrl+v", TB.handleTbShieldPaste)
command("setTb", TB.handleSetTb)

AutoLoader = {}

---@type "empty" | "recording" | "setup"
AutoLoader.state = "empty"

---@type {[number]: Position}
AutoLoader.tntPositions = {}

function AutoLoader.startRecording()
  if AutoLoader.state == "empty" then
    AutoLoader.state = "recording"
    Core.msg("Started " .. Core.highlight("AutoLoader", Colors.aqua) .. " recording")
  else
    Core.msg("There is already a " ..
      Core.highlight("AutoLoader", Colors.aqua) " setup. Clear it to start a new recording")
  end
end

function AutoLoader.stopRecording()
  if AutoLoader.state == "recording" then
    AutoLoader.state = "setup"
    Core.msg("Finished " .. Core.highlight("AutoLoader", Colors.aqua) .. " recording")
  else
    Core.msg("There is no active " ..
      Core.highlight("AutoLoader", Colors.aqua) .. " recording")
  end
end

function AutoLoader.performLoadSequence()
  if AutoLoader.state == "setup" then
    Core.msg("Finished " .. Core.highlight("AutoLoader", Colors.aqua) .. " recording")

    for position in AutoLoader.tntPositions do
      server.setBlockAt(position, "TNT")
    end
  else
    Core.msg("There is no setup " ..
      Core.highlight("AutoLoader", Colors.aqua))
  end
end

function AutoLoader.clear()
  AutoLoader.tntPositions = {}
end

event(events.PlaceBlock, function(event)
  if AutoLoader.state == "recording" & event.type == "TNT" then
    table.insert(AutoLoader.tntPositions, { x = event.x, y = event.y, z = event.z })
  end
end)

event(events.BreakBlock, function(event)
  if AutoLoader.state == "recording" & event.type == "TNT" then
    local removeIndex = -1;
    for index, position in AutoLoader.tntPositions do
      if position.x == event.x & position.y == event.y & position.z == event.z then
        removeIndex = index
      end
    end

    if removeIndex ~= -1 then
      table.remove(AutoLoader.tntPositions, removeIndex)
    end
  end
end)

hotkey("f", HandlerFunction(function()
  if AutoLoader.state == "empty" then
    AutoLoader.startRecording()
  elseif AutoLoader.state == "recording" then
    AutoLoader.stopRecording()
  else
    AutoLoader.performLoadSequence()
  end
end))

hotkey("ctrl+f", HandlerFunction(AutoLoader.clear))

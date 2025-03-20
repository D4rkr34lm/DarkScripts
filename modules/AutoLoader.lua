AutoLoader = {}

---@type "empty" | "recording" | "setup"
AutoLoader.state = "empty"

---@type {[number]: Position}
AutoLoader.tntPositions = {}

function AutoLoader.startRecording()
  AutoLoader.state = "recording"
  Core.msg("Started " .. Core.highlight("aqua", "AutoLoader") .. " recording")
end

function AutoLoader.stopRecording()
  AutoLoader.state = "setup"
  Core.msg("Finished " .. Core.highlight("aqua", "AutoLoader") .. " recording")
end

function AutoLoader.performLoadSequence()
  Core.msg("Executing " .. Core.highlight("aqua", "AutoLoader") .. " sequence")
  for _, position in ipairs(AutoLoader.tntPositions) do
    server.setBlockAt(position, "TNT")
  end
end

function AutoLoader.clear()
  AutoLoader.tntPositions = {}
  AutoLoader.state = "empty"
  Core.msg("Cleared " .. Core.highlight("aqua", "AutoLoader"))
end

event(events.PlaceBlock, function(event)
  if AutoLoader.state == "recording" and event.type == "TNT" then
    table.insert(AutoLoader.tntPositions, pos(event.x, event.y, event.z))
  end
end)

hotkey("f", function(pressed)
  if pressed then
    if AutoLoader.state == "empty" then
      AutoLoader.startRecording()
    elseif AutoLoader.state == "recording" then
      AutoLoader.stopRecording()
    else
      AutoLoader.performLoadSequence()
    end
  end
end)

hotkey("ctrl+f", function(pressed)
  if pressed then
    AutoLoader.clear()
  end
end)

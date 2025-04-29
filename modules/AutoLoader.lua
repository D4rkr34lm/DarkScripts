AutoLoader = {}

---@type "empty" | "recording" | "setup"
AutoLoader.state = "empty"

---@type Position
AutoLoader.triggerPosition = nil

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

  if not (AutoLoader.triggerPosition == nil) then
    server.interactAt(AutoLoader.triggerPosition)
  end
end

function AutoLoader.clear()
  if AutoLoader.state == "empty" then
    Core.msg(Core.highlight("aqua", "AutoLoader") .. " is empty")
  else
    AutoLoader.tntPositions = {}
    AutoLoader.triggerPosition = nil
    AutoLoader.state = "empty"
    Core.msg("Cleared " .. Core.highlight("aqua", "AutoLoader"))
  end
end

event(events.PlaceBlock, function(event)
  if AutoLoader.state == "recording" and event.type == "TNT" then
    table.insert(AutoLoader.tntPositions, pos(event.x, event.y, event.z))
    Core.msg(Core.highlight("aqua", "AutoLoader") ..
      " recorded TNT placed at " ..
      "{" ..
      Core.highlight("aqua", tostring(event.x)) ..
      "," .. Core.highlight("aqua", tostring(event.y)) .. "," .. Core.highlight("aqua", tostring(event.z)) .. "}")
  end
end)

event(events.RightClick, function(event)
  if event.hasBlock and AutoLoader.state == "recording" and not (event.blockType == "AIR") then
    local position = Pos.new(event.blockX, event.blockY, event.blockZ)

    Core.msg(Core.highlight("aqua", "AutoLoader") ..
      " recorded trigger (" .. event.blockType .. ") used at " .. Pos.toString(position))

    AutoLoader.triggerPosition = position
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

---@alias PrinterBlockType "spawner" | "consumer"

---@class PrinterBlock
---@field position Position
---@field type PrinterBlockType
---@field rate number

PrinterUtils = {
  spawnerBlockMaterial = "YELLOW_SHULKER_BOX",
  consumerBlockMaterial = "BLACK_SHULKER_BOX",

  ---@type {[number]: PrinterBlock}
  spawnerBlocks = {},
  ---@type {[number]: PrinterBlock}
  consumerBlocks = {},

  isRunning = false,

  blockPlaceHandler = function(event)
    if event.type == PrinterUtils.spawnerBlockMaterial then
      table.insert(PrinterUtils.spawnerBlocks, {
        position = pos(event.x, event.y, event.z),
        type = "spawner",
        rate = 8,
      })

      Core.msg(Core.highlight("aqua", "PrinterUtils") ..
        " placed " .. Core.highlight("yellow", "spawner") .. " at " .. "{" ..
        Core.highlight("aqua", tostring(event.x)) ..
        "," .. Core.highlight("aqua", tostring(event.y)) .. "," .. Core.highlight("aqua", tostring(event.z)) .. "}")
    elseif event.type == PrinterUtils.consumerBlockMaterial then
      table.insert(PrinterUtils.consumerBlocks, {
        position = pos(event.x, event.y, event.z),
        type = "consumer",
        rate = 2,
      })

      Core.msg(Core.highlight("aqua", "PrinterUtils") ..
        " placed " .. Core.highlight("black", "consumer") .. " at " .. "{" ..
        Core.highlight("aqua", tostring(event.x)) ..
        "," .. Core.highlight("aqua", tostring(event.y)) .. "," .. Core.highlight("aqua", tostring(event.z)) .. "}")
    end
  end,

  blockBreakHandler = function(event)
    local position = Pos.new(event.x, event.y, event.z)
    if event.type == PrinterUtils.spawnerBlockMaterial then
      for index, value in pairs(PrinterUtils.spawnerBlocks) do
        if Pos.equals(value.position, position) then
          table.remove(PrinterUtils.spawnerBlocks, index)

          Core.msg(Core.highlight("aqua", "PrinterUtils") ..
            " removed " .. Core.highlight("yellow", "spawner") .. " at " .. "{" ..
            Core.highlight("aqua", tostring(event.x)) ..
            "," .. Core.highlight("aqua", tostring(event.y)) .. "," .. Core.highlight("aqua", tostring(event.z)) .. "}")
          break
        end
      end
    elseif event.type == PrinterUtils.consumerBlockMaterial then
      for index, value in pairs(PrinterUtils.spawnerBlocks) do
        if Pos.equals(value.position, position) then
          table.remove(PrinterUtils.consumerBlocks, index)

          Core.msg(Core.highlight("aqua", "PrinterUtils") ..
            " removed " .. Core.highlight("darkGrey", "consumer") .. " at " .. "{" ..
            Core.highlight("aqua", tostring(event.x)) ..
            "," .. Core.highlight("aqua", tostring(event.y)) .. "," .. Core.highlight("aqua", tostring(event.z)) .. "}")
          break
        end
      end
    end
  end,

  start = function()
    if PrinterUtils.isRunning then
      Core.msg(Core.highlight("aqua", "PrinterUtils") .. "already running")
      return
    else
      Core.msg(Core.highlight("aqua", "PrinterUtils") .. " started")
      PrinterUtils.isRunning = true
      PrinterUtils.execute()
    end
  end,

  stop = function()
    Core.msg(Core.highlight("aqua", "PrinterUtils") .. " stopped")

    for _, value in pairs(PrinterUtils.consumerBlocks) do
      PrinterUtils.resetBlock(value)
    end

    for _, value in pairs(PrinterUtils.spawnerBlocks) do
      PrinterUtils.resetBlock(value)
    end

    PrinterUtils.isRunning = false
  end,

  ---@param block PrinterBlock
  executeBlock = function(block)
    if block.type == "spawner" then
      server.setBlockAt(block.position, "END_STONE")
    elseif block.type == "consumer" then
      server.setBlockAt(block.position, "AIR")
    end
  end,

  execute = function()
    if PrinterUtils.isRunning then
      delayed(1, PrinterUtils.execute)
      for _, value in pairs(PrinterUtils.consumerBlocks) do
        if server.ticks() % value.rate == 0 then
          PrinterUtils.executeBlock(value)
        end
      end

      for _, value in pairs(PrinterUtils.spawnerBlocks) do
        if server.ticks() % value.rate == 0 then
          PrinterUtils.executeBlock(value)
        end
      end
    end
  end,

  ---@param block PrinterBlock
  resetBlock = function(block)
    if block.type == "spawner" then
      server.setBlockAt(block.position, PrinterUtils.spawnerBlockMaterial)
    elseif block.type == "consumer" then
      server.setBlockAt(block.position, PrinterUtils.consumerBlockMaterial)
    end
  end
}

event(events.PlaceBlock, PrinterUtils.blockPlaceHandler)
event(events.BreakBlock, PrinterUtils.blockBreakHandler)

command("pu", function(args)
  local arg = args[1]

  if arg == "start" then
    PrinterUtils.start()
  elseif arg == "stop" then
    PrinterUtils.stop()
  end
end)

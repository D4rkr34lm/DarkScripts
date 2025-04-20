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

  blockPlaceHandler = function(event)
    if event.type == PrinterUtils.spawnerBlockMaterial then
      table.insert(PrinterUtils.spawnerBlocks, {
        position = pos(event.x, event.y, event.z),
        type = "spawner",
        rate = 4,
      })

      Core.msg(Core.highlight("aqua", "PrinterUtils") ..
        " placed " .. Core.highlight("yellow", "spawner") .. " at " .. "{" ..
        Core.highlight("aqua", tostring(event.x)) ..
        "," .. Core.highlight("aqua", tostring(event.y)) .. "," .. Core.highlight("aqua", tostring(event.z)) .. "}")
    elseif event.type == PrinterUtils.consumerBlockMaterial then
      table.insert(PrinterUtils.spawnerBlocks, {
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
          table.remove(PrinterUtils.spawnerBlocks, index)

          Core.msg(Core.highlight("aqua", "PrinterUtils") ..
            " removed " .. Core.highlight("darkGrey", "consumer") .. " at " .. "{" ..
            Core.highlight("aqua", tostring(event.x)) ..
            "," .. Core.highlight("aqua", tostring(event.y)) .. "," .. Core.highlight("aqua", tostring(event.z)) .. "}")
          break
        end
      end
    end
  end
}

event(events.PlaceBlock, PrinterUtils.blockPlaceHandler)
event(events.BreakBlock, PrinterUtils.blockBreakHandler)

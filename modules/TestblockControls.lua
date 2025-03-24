TestblockControls = {
  ---@type {[RegionType]: {[number]: {[number]: string}}}
  regionBlockConfigs = {
    wg = {
      {
        "Testbloecke/Wg",
        "Testbloecke/Wg_mit_Schild"
      },
      {
        "Testbloecke/Wg",
        "Testbloecke/Wg_mit_12er_Schild"
      }
    },
    mwg = {
      {
        "Testbloecke/Mwg",
        "Testbloecke/Mwg_mit_Schild"
      },
      {
        "Testbloecke/Mwg_mit_DragonEggs",
        "Testbloecke/Mwg_mit_DragonEggs_und_Schild"
      }
    },
    ws = {
      {
        "Testbloecke/Ws",
        "Testbloecke/Ws_mit_Schild"
      }
    }
  },

  ---@type {[RegionType]: number}
  selectedBlockConfig = {
    wg = 1,
    mwg = 1,
    ws = 1,
  },

  ---@param regionType RegionType
  pasteTestblock = function(regionType)
    local selectedTestblockIndex = TestblockControls.selectedBlockConfig[regionType]
    local regionTestblockConf = TestblockControls.regionBlockConfigs[regionType][selectedTestblockIndex]
    local testblockToPaste = regionTestblockConf[1];

    exec("tb " .. testblockToPaste .. " -e")
  end,

  ---@param regionType RegionType
  pasteExtensionTestblock = function(regionType)
    local selectedTestblockIndex = TestblockControls.selectedBlockConfig[regionType]
    local regionTestblockConf = TestblockControls.regionBlockConfigs[regionType][selectedTestblockIndex]
    local testblockToPaste = regionTestblockConf[2];

    exec("tb " .. testblockToPaste .. " -e")
  end,

  ---@param regionType RegionType
  swapTestblock = function(regionType)
    local blockConfigCount = length(TestblockControls.regionBlockConfigs[regionType])
    local selectedTestblockIndex = TestblockControls.selectedBlockConfig[regionType]

    local newTestblockConfigIndex = (selectedTestblockIndex + 1) % blockConfigCount
    local newTestblockConfig = TestblockControls.regionBlockConfigs[regionType][newTestblockConfigIndex]

    TestblockControls.selectedBlockConfig[regionType] = newTestblockConfigIndex


    Core.msg("Swapping testblock for " ..
      Core.highlight("aqua", regionType) .. " to " .. Core.highlight("aqua", table.concat(newTestblockConfig, " | ")))
  end
}

local function pasteTestblock_hotkey(pressed)
  if pressed then
    local currentRegionType = region.type()
    TestblockControls.pasteTestblock(currentRegionType)
  end
end

local function pasteExtensionTestblock()
  local currentRegionType = region.type()
  TestblockControls.pasteExtensionTestblock(currentRegionType)
end

hotkey("v", pasteTestblock_hotkey)
hotkey("ctrl+v", pasteExtensionTestblock)

command("swapTb", function()
  local currentRegionType = region.type()
  TestblockControls.swapTestblock(currentRegionType)
end)

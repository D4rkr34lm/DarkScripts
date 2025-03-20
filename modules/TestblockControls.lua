TestblockControls = {}

---@type {[RegionType]: {[number]: {[number]: string}}}
TestblockControls.blockConfigs = {
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
    }
  },
  ws = {
    {
      "Testbloecke/Ws",
      "Testbloecke/Ws_mit_Schild"
    }
  }
}

---@type {[RegionType]: number}
TestblockControls.selectedBlockConfig = {
  wg = 1,
  mwg = 1,
  ws = 1,
}

---@param regionType RegionType
function TestblockControls.pasteTestblock(regionType)
  local selectedTestblockIndex = TestblockControls.selectedBlockConfig[regionType]
  local regionTestblockConf = TestblockControls.blockConfigs[regionType][selectedTestblockIndex]
  local testblockToPaste = regionTestblockConf[1];

  exec("tb " .. testblockToPaste .. " -e")
end

---@param regionType RegionType
function TestblockControls.pasteShieldTestblock(regionType)
  local selectedTestblockIndex = TestblockControls.selectedBlockConfig[regionType]
  local regionTestblockConf = TestblockControls.blockConfigs[regionType][selectedTestblockIndex]
  local testblockToPaste = regionTestblockConf[2];

  exec("tb " .. testblockToPaste .. " -e")
end

---@param regionType RegionType
function TestblockControls.swapTestblock(regionType)
  local blockConfigCount = length(TestblockControls.blockConfigs(regionType))
  local selectedTestblockIndex = TestblockControls.selectedBlockConfig[regionType]
  if blockConfigCount == selectedTestblockIndex then
    TestblockControls.selectedBlockConfig[regionType] = 1
  else
    TestblockControls.selectedBlockConfig[regionType] = TestblockControls.selectedBlockConfig[regionType] + 1
  end
end

hotkey("v", HandlerFunction(function()
  local currentRegionType = region.type()
  TestblockControls.pasteTestblock(currentRegionType)
end))

hotkey("ctrl+v", HandlerFunction(function()
  local currentRegionType = region.type()
  TestblockControls.pasteShieldTestblock(currentRegionType)
end))

command("swapTb", function()
  local currentRegionType = region.type()
  TestblockControls.swapTestblock(currentRegionType)
end)

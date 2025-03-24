TraceControls = {
  ---@type {[number]: string}
  traceShowConfigs = {
    "trace show",
    "trace show -explosion -count",
    "trace hide"
  },



  ---@type number
  currentTraceShowState = 1,

  toggleTroughTraceShow = function()
    local currentTraceShowCommand = TraceControls.traceShowConfigs[TraceControls.currentTraceShowState]
    exec(currentTraceShowCommand)

    local traceShowConfigsCount = length(TraceControls.traceShowConfigs)
    TraceControls.currentTraceShowState = (TraceControls.currentTraceShowState + 1) % traceShowConfigsCount
  end,

  clearTraces = function()
    exec("trace clear")
  end
}



local function toggleTroughTraceShow_hotkey(pressed)
  if pressed then
    TraceControls.toggleTroughTraceShow()
  end
end

local function clearTraces_hotkey(pressed)
  if pressed then
    TraceControls.clearTraces()
  end
end

hotkey("c", toggleTroughTraceShow_hotkey)
hotkey("ctrl+c", clearTraces_hotkey)

TraceControls = {}

TraceControls.traceShowConfigs = {
  "trace show",
  "trace show -explosion -count",
  "trace hide"
}

TraceControls.currentSelectedTraceShowState = 1;

function TraceControls.toggleTroughTraceShow()
  local currentTraceShowCommand = TraceControls.traceShowConfigs[TraceControls.currentSelectedTraceShowState]
  exec(currentTraceShowCommand)

  local traceShowConfigsCount = length(TraceControls.traceShowConfigs)
  if TraceControls.currentSelectedTraceShowState == traceShowConfigsCount then
    TraceControls.currentSelectedTraceShowState = 1
  else
    TraceControls.currentSelectedTraceShowState = TraceControls.currentSelectedTraceShowState + 1
  end
end

function TraceControls.clearTraces()
  exec("trace clear")
end

hotkey("c",
  function(pressed)
    if pressed then
      TraceControls.toggleTroughTraceShow()
    end
  end
)
hotkey("ctrl+c",
  function(pressed)
    if pressed then
      TraceControls.clearTraces()
    end
  end
)

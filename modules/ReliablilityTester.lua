ReliabilityTester = {}

ReliabilityTester.isRunning = false

ReliabilityTester.shotLength = 160
ReliabilityTester.shotsRequiredForTest = 100

ReliabilityTester.currentShotIndex = 0
ReliabilityTester.failures = {}

function ReliabilityTester.run()
  if ReliabilityTester.isRunning then
    Core.msg(Core.highlight("aqua", "ReliabilityTester") .. " is already running")
  elseif AutoLoader.state ~= "setup" then
    Core.msg(Core.highlight("aqua", "ReliabilityTester") ..
      " requires " .. Core.highlight("aqua", "AutoLoader") .. " to be setup")
  else
    ReliabilityTester.currentShotIndex = 0
    ReliabilityTester.failures = {}
    ReliabilityTester.isRunning = true

    for shotIndex = 0, ReliabilityTester.shotsRequiredForTest do
      delayed(ReliabilityTester.shotLength * shotIndex, function()
        ReliabilityTester.currentShotIndex = shotIndex
        Core.msg(Core.highlight("aqua", "ReliabilityTester") ..
          " preforming shot " ..
          tostring(shotIndex) ..
          Core.highlight("aqua", "/") .. Core.highlight("white", tostring(ReliabilityTester.shotsRequiredForTest)))
        AutoLoader.performLoadSequence()
      end)
    end

    delayed(ReliabilityTester.shotLength * (ReliabilityTester.shotsRequiredForTest + 1), function()
      ReliabilityTester.isRunning = false
      ReliabilityTester.printResult()
    end)
  end
end

function ReliabilityTester.printResult()
  local failureCount = 0
  for _, _ in pairs(ReliabilityTester.failures) do
    failureCount = failureCount + 1
  end
  local failureRate = failureCount / ReliabilityTester.shotsRequiredForTest

  local failuresColor = "green"

  if failureRate > 0.04 then
    failuresColor = "red"
  elseif failureRate > 0 then
    failuresColor = "yellow"
  end

  Core.msg(Core.highlight("aqua", "ReliabilityTester") ..
    " recorded a failure rate of " .. Core.highlight(failuresColor, tostring(failureRate * 100)) .. "%")
end

event(events.TNTExplodeInBuild, function()
  if ReliabilityTester.isRunning then
    local index = "#" .. tostring(ReliabilityTester.currentShotIndex)
    ReliabilityTester.failures[index] = true
  end
end)

command("cqa", function(args)
  local arg = args[1]

  if arg == "start" then
    ReliabilityTester.run()
  elseif arg == "result" then
    ReliabilityTester.printResult()
  end
end)

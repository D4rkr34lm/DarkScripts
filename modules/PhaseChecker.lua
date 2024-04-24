PhaseChecker = {}

PhaseChecker.phases = {}
PhaseChecker.startTime = -1
PhaseChecker.running = false

function PhaseChecker.startCheck()
  PhaseChecker.startTime = server.ticks()
  PhaseChecker.running = true
end

function PhaseChecker.registerTNT()
  if PhaseChecker.running then
    local time = server.ticks() - PhaseChecker.startTime
    if PhaseChecker.phases[time] == nil then
      PhaseChecker.phases[time] = 1
    else
      PhaseChecker.phases[time] = PhaseChecker.phases[time] + 1
    end
  end
end

function PhaseChecker.stopCheck()
  PhaseChecker.running = false
  PhaseChecker.startTime = 0

  local result = "Phases "

  for phase, count in pairs(PhaseChecker.phases) do
    result = result .. Core.highlight(tostring(phase)) .. "|" .. tostring(count) .. ", "
  end

  PhaseChecker.phases = {}
  Core.send(result)
end

command("phc", PhaseChecker.startCheck)
event(events.TNTSpawn, PhaseChecker.registerTNT)
event(events.TNTExplode, PhaseChecker.stopCheck)

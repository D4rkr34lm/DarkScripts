PhaseChecker = {}

PhaseChecker.phases = {}
PhaseChecker.startTime = -1
PhaseChecker.running = false

function PhaseChecker.startCheck()
  Core.send("Started PhaseChecker")
  PhaseChecker.running = true
end

function PhaseChecker.registerTNT()
  if PhaseChecker.startTime == -1 then
    PhaseChecker.startTime = server.ticks()
  end
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
  if PhaseChecker.running then
    PhaseChecker.running = false
    PhaseChecker.startTime = -1

    local result = "Phases "

    for phase, count in pairs(PhaseChecker.phases) do
      result = result .. Core.highlight(tostring(phase)) .. "|" .. tostring(count) .. "  "
    end

    PhaseChecker.phases = {}
    Core.send(result)
  end
end

command("phc", PhaseChecker.startCheck)
event(events.TNTSpawn, PhaseChecker.registerTNT)
event(events.TNTExplode, PhaseChecker.stopCheck)

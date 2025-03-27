TLS = {
  ---@type "idle" | "running"
  state = "idle",
  recording = nil,

  startRecording = function()
    TLS.state = "running"
    TLS.recording = {
      baselineTick = server.ticks(),
      spawnsCounters = {}
    }
  end,

  stopRecording = function()
    TLS.state = "idle"
  end,

  recordTntSpawn = function()
    local currentTick = tostring(server.ticks() - TLS.recording.baselineTick)

    if TLS.recording.spawnsCounters[currentTick] == nil then
      TLS.recording.spawnsCounters[currentTick] = 1
    else
      TLS.recording.spawnsCounters[currentTick] = TLS.recording.spawnsCounters[currentTick] + 1
    end
  end,

  printResult = function()
    local headers = { "Tick", "TNTs" }
    local rows = {}

    for key, value in pairs(TLS.recording.spawnsCounters) do
      table.insert(rows, { key, tostring(value) })
    end

    Core.printTable(headers, rows)
  end
}

event(events.TNTSpawn, function()
  if TLS.state == "idle" then
    TLS.startRecording()
  end

  TLS.recordTntSpawn()
end)

event(events.TNTExplode, function()
  if TLS.state == "running" then
    TLS.stopRecording()
  end

  TLS.printResult()
end)

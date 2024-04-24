Trail = {}

Trail.state = 0

function Trail.handleTrailCycle(pressed)
  if pressed then
    if Trail.state == 0 then
      Trail.state = 1
      exec("trail show")
    elseif Trail.state == 1 then
      Trail.state = 2
      exec("trail show --explode --count")
    elseif Trail.state == 2 then
      Trail.state = 0
      exec("trail hide")
    end
  end
end

function Trail.handleTrailDelete(pressed)
  if pressed then
    exec("trail delete")
  end
end

hotkey("c", Trail.handleTrailCycle)
hotkey("ctrl+c", Trail.handleTrailDelete)

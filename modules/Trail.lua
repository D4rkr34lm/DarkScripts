Trail = {}

TrailState = 0

function Trail.handleTrailCycle(pressed)
  if pressed then
    if TrailState == 0 then
      TrailState = 1
      exec("trail show")
    elseif TrailState == 1 then
      TrailState = 2
      exec("trail show --explode --count")
    elseif TrailState == 2 then
      TrailState = 0
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

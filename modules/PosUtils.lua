Pos = {
  ---@param a Position
  ---@param b Position
  equals = function(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
  end,

  ---comment
  ---@param x number
  ---@param y number
  ---@param z number
  ---@return Position
  new = function(x, y, z)
    return { x = x, y = y, z = z }
  end
}

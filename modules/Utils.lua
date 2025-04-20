Utils = {
  table_equals = function(a, b)
    for key, value in pairs(a) do
      if type(value) == "table" then
        if not Utils.table_equals(a, b[key]) then
          return false
        end
      else
        if value == b[key] then
          return false
        end
      end
    end
    return true
  end
}

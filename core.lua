Core = {}

function HandlerFunction(func)
  return function(pressed)
    if pressed then
      func()
    end
  end
end

Colors = {
  black = "&0",
  darkBlue = "&1",
  darkGreen = "&2",
  darkAqua = "&3",
  darkRed = "&4",
  darkPurple = "&5",
  gold = "&6",
  gray = "&7",
  darkGrey = "&8",
  blue = "&9",
  green = "&a",
  aqua = "&b",
  red = "&c",
  lightPurple = "&d",
  yellow = "&e",
  white = "&f"
}

---@param text string
function Core.msg(text)
  print("&7[&8" .. "Dark" .. "&bScripts&7] &f" .. text)
end

---@param color string
---@param text string
---@return string
function Core.highlight(color, text)
  return color .. text .. Colors.white
end

Core = {}

Core.colors = {
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
  print("&f[&8Dark&3Scripts&f]&7", text)
end

---@param color "black" | "darkBlue" | "darkGreen" | "darkAqua" | "darkRed" | "darkPurple" | "gold" | "gray" | "darkGrey" | "blue" | "green" | "aqua" | "red" | "lightPurple" | "yellow" | "white"
---@param text string
---@return string
function Core.highlight(color, text)
  return Core.colors[color] .. text .. Core.colors.gray
end

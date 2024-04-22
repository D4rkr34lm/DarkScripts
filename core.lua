Core = {}

---Sends a prefixed message
---@param message string
function Core.send(message)
  print("&f[&8Dark&3Scripts&f]&7 ", message)
end

---Highlights the given message
---@param text string
---@return string
function Core.highlight(text)
  return "&9" .. text .. "&7"
end

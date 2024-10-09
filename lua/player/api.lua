local M = {}

--- Get artist metadata
---@param player string|nil
---@return string
function M.get_artist(player)
   local command = { "playerctl", "metadata", "--format", "{{ artist }}" }
   if player then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ artist }}" }
   end
   local artist = string.gsub(vim.fn.system(command), "\n", "")
   return artist
end

--- Get title metadata
---@param player string|nil
---@return string
function M.get_title(player)
   local command = { "playerctl", "metadata", "--format", "{{ title }}" }
   if player then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ title }}" }
   end
   local title = string.gsub(vim.fn.system(command), "\n", "")
   return title
end

--- Get player status
---@param player string|nil
---@return string
function M.get_status(player)
   local command = { "playerctl", "status" }
   if player then
      command = { "playerctl", "-p", player, "status" }
   end
   local status = string.gsub(vim.fn.system(command), "\n", "")
   return status
end

--- Get player name
---@param player string|nil
---@return string
function M.get_player_name(player)
   local command = { "playerctl", "metadata", "--format", "{{ playerName }}" }
   if player then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ playerName }}" }
   end
   local player_name = string.gsub(vim.fn.system(command), "\n", "")
   return player_name
end

--- Get media file url
---@param player string|nil
---@return string
function M.get_file_url(player)
   local command = { "playerctl", "metadata", "--format", "{{ xesam:url }}" }
   if player then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ xesam:url }}" }
   end
   local url = string.gsub(vim.fn.system(command), "\n", "")
   return url
end

return M

-- Most of these function are just wrappers for playerctl
-- - AL

local M = {}

--- Get artist metadata
---@param player string|nil
---@return string
function M.get_artist(player)
   local command = { "playerctl", "metadata", "--format", "{{ artist }}" }
   if player and player ~= "" then
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
   if player and player ~= "" then
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
   if player and player ~= "" then
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
   if player and player ~= "" then
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
   if player and player ~= "" then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ xesam:url }}" }
   end
   local url = string.gsub(vim.fn.system(command), "\n", "")
   return url
end

--- Get current track position in milliseconds
---@param player string|nil
---@return number
function M.get_curr_track_pos(player)
   local command = { "playerctl", "metadata", "--format", "{{ position }}" }
   if player and player ~= "" then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ position }}" }
   end
   local position_str = string.gsub(vim.fn.system(command), "\n", "")
   return tonumber(position_str) or 0
end

--- Get current track length in milliseconds
---@param player string|nil
---@return number
function M.get_curr_track_len(player)
   local command = { "playerctl", "metadata", "--format", "{{ mpris:length }}" }
   if player and player ~= "" then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ mpris:length }}" }
   end
   local length_str = string.gsub(vim.fn.system(command), "\n", "")
   return tonumber(length_str) or 0
end

--- Get current track position in timestamp format
---@param player string|nil
---@return string
function M.get_curr_track_pos_time(player)
   local command = { "playerctl", "metadata", "--format", "{{ duration(position) }}" }
   if player and player ~= "" then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ duration(position) }}" }
   end
   local position_timestamp = string.gsub(vim.fn.system(command), "\n", "")
   return position_timestamp
end

--- Get current track length in timestamp format
---@param player string|nil
---@return string
function M.get_curr_track_len_time(player)
   local command = { "playerctl", "metadata", "--format", "{{ duration(mpris:length) }}" }
   if player and player ~= "" then
      command = { "playerctl", "-p", player, "metadata", "--format", "{{ duration(mpris:length) }}" }
   end
   local length_timestamp = string.gsub(vim.fn.system(command), "\n", "")
   return length_timestamp
end

return M

local system = vim.fn.system
local api = require("player.api")
local player_args = {}
local playback_commands = {
   "next",
   "previous",
   "pause",
   "play",
   "play-pause",
}
local default_config = {
   supported_players = {
      "cmus",
      "spotify",
      "firefox",
      "mpv"
   }
}
local config = default_config
local M = {}

--- nvim-notify support
---@param message string notify message
---@param log_level string|nil vim.log.levels
---@return function vim.notify
local function notify(message, log_level)
   return vim.notify(message, log_level, { title = "player.nvim" })
end

--- If an argument is a supported player
---@param arg string
---@return boolean
local function is_supported_player(arg)
   for _, player in ipairs(config.supported_players) do
      if arg == player then return true end
   end
   return false
end

--- If an argument is a playback command
---@param arg string
---@return boolean
local function is_playback_command(arg)
   for _, command in ipairs(playback_commands) do
      if arg == command then return true end
   end
   return false
end

--- Notify player status
---@param supported_player string|nil
---@return function - player status notificiation
local function notify_player(supported_player)
   local status = api.get_status(supported_player)
   if status == "No players found" or status == "Stopped" then
      return notify(status, "WARN");
   end

   local player_name = api.get_player_name(supported_player)
   local artist = api.get_artist(supported_player)
   local title = api.get_title(supported_player)
   local song = artist .. " - " .. title

   if artist == "" and title == "" then
      song = api.get_file_url(supported_player)
   elseif artist == "" then
      -- prevents displaying " - title" if no artist (minor stuff)
      song = title
   end

   local status_icons = {
      Playing = "󰐊 ",
      Paused = "󰏤 ",
   }

   status = api.get_status(supported_player)
   local notify_table_data = {
      status, " (", player_name, ")\n",
      status_icons[status], song
   }

   return notify(table.concat(notify_table_data))
end

M.setup = function(opts)
   -- merge plaback commands to player_args
   for _, command in ipairs(playback_commands) do
      table.insert(player_args, command)
   end

   if opts and next(opts) then
      config = opts
   end

   -- merge supported players to player_args, it is to make sure included players via user
   -- config will appear in cmdline completion
   for _, player in ipairs(config.supported_players) do
      table.insert(player_args, player)
   end

   vim.api.nvim_create_user_command("Player", function(args)
      local arg1 = args.fargs[1] or ""
      local arg2 = args.fargs[2] or ""

      if is_supported_player(arg1) then
         if arg2 == "" then
            return notify_player(arg1)
         end

         if not is_playback_command(arg2) then
            return notify("Invalid player argument " .. arg2, "WARN")
         end

         system("playerctl -p " .. arg1 .. " " .. arg2)
         vim.wait(500)
         return notify_player(arg1)
      end

      if arg1 ~= "" and not is_supported_player(arg1) and not is_playback_command(arg1) then
         return notify("Invalid argument " .. arg1, "WARN")
      end

      system("playerctl " .. arg1)
      vim.wait(500)
      notify_player()
   end, {
      nargs = "*",
      complete = function()
         return player_args
      end
   })
end

return M

local system = vim.fn.system
local notify = vim.notify
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

local function is_supported_player(arg)
   for _, player in ipairs(config.supported_players) do
      if arg == player then return true end
   end
   return false
end

local function is_playback_command(arg)
   for _, command in ipairs(playback_commands) do
      if arg == command then return true end
   end
   return false
end

local function notify_player(supported_player)
   local status_command = "playerctl status"
   local player_name_command = "playerctl metadata --format '{{ playerName }}'"
   local song_command = "playerctl metadata --format '{{ artist }} - {{ title }}'"

   if supported_player then
      status_command = "playerctl -p " .. supported_player .. " status"
      player_name_command = "playerctl -p " .. supported_player .. " metadata --format '{{ playerName }}'"
      song_command = "playerctl -p " .. supported_player .. " metadata --format '{{ artist }} - {{ title }}'"
   end

   local status = string.gsub(system(status_command), "\n", "")
   if status == "No players found" or status == "Stopped" then
      return notify(status, "WARN");
   end

   local player_name = string.gsub(system(player_name_command), "\n", "")
   local song = string.gsub(system(song_command), "\n", "")
   local status_icons = {
      Playing = "󰐊 ",
      Paused = "󰏤 ",
   }

   status = string.gsub(system(status_command), "\n", "")
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
      print(arg1, arg2)

      if is_supported_player(arg1) then
         return notify_player(arg1)
      end

      if arg1 ~= "" and not is_supported_player(arg1) and not is_playback_command(arg1) then
         return notify("Invalid argument " .. arg1, "WARN")
      end

      notify_player()
   end, {
      nargs = "*",
      complete = function()
         return player_args
      end
   })
end

return M

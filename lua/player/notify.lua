function notify_player(supported_player)
   local system = vim.fn.system
   local notify = vim.notify
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

return notify_player

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
local M = {}

M.setup = function(opts)
   -- merge plaback commands to player_args
   for _, command in ipairs(playback_commands) do
      table.insert(player_args, command)
   end

   local config = default_config
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
   end, {
      nargs = "*",
      complete = function()
         return player_args
      end
   })
end

return M

local M = {}

M.default_opts = {
   supported_players = {
      "cmus",
      "spotify",
      "firefox",
      "mpv"
   },
   notify_now_playing = false,
   notifier = 0
}

function M.handle_user_opts(opts)
   local final_opts = {}

   -- if opts is empty, then use default_opts
   if not opts or not next(opts) then
      return M.default_opts
   end

   final_opts = vim.tbl_extend("force", M.default_opts, opts)

   return final_opts
end

return M

local M = {}

---Checkhealth
function M.check()
   vim.health.start("Check requirements")
   if vim.fn.executable('playerctl') == 0 then
      vim.health.warn("playerctl is not installed or can not be found in PATH",
         "Please install playerctl and make sure the command `playerctl` is executable to use this plugin")
   else
      vim.health.ok("playerctl is installed")
   end
end

return M

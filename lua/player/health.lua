local M = {}

---Checkhealth
function M.check()
	vim.health.start("Check requirements")
	if not vim.fn.executable('playerctl') then
		vim.health.warn("playerctl is not installed or can not be found in PATH",
			"Please install playerctl and make sure the command `playerctl` is executable to use this plugin")
	else
		vim.health.ok("playerctl is installed")
	end
end

return M

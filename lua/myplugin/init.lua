local M = {}
function M.hello_world()
	print("Hello, world!")
end

vim.api.nvim_command("command! HelloWorld lua require('myplugin').hello_world()")

return M

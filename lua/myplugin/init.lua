local M = {}

vim.api.nvim_create_user_command("SayHi", 'echo "Hello World!"', {})

return M

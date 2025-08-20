local popup = require("plenary.popup")

local M = {}

local internal_path_to_known_essays = ""
local known_essay_dict

function M.setup(path_to_known_essays)
	-- read the known essays
	if type(path_to_known_essays) ~= "string" then
		error("put a string as the path to known essays")
	end

	internal_path_to_known_essays = path_to_known_essays

	io.input(internal_path_to_known_essays)

	known_essay_dict = {}
	for line in io.lines() do
		table.insert(known_essay_dict, line)
	end
end


function M.openessaydir(path_to_dir)
	vim.cmd("tabnew")
	vim.api.nvim_set_current_dir(tostring(path_to_dir))
	-- vim.cmd("cd " .. path_to_dir)
	vim.cmd("e essay.txt")
	vim.cmd("wincmd v")
	vim.cmd("wincmd v")
	vim.cmd("10 wincmd <")
	vim.cmd("e lhsb.txt")
	vim.cmd("wincmd l")
	vim.cmd("10 wincmd >")
	vim.cmd("wincmd l")
	vim.cmd("e rhsb.txt")
	vim.cmd("wincmd h")

	vim.opt.fillchars = { eob = " " } -- not sure why this is necessary

	local already_have_this_essay = false
	for _, essaypath in ipairs(known_essay_dict) do
		if essaypath == path_to_dir then
			already_have_this_essay = true
			break
		end
	end

	if not already_have_this_essay then
		local file,err = io.open(internal_path_to_known_essays, 'a')
		if file then
			table.insert(known_essay_dict, path_to_dir)
			file:write(tostring(path_to_dir .. "\n"))
			file:close()
		end
	end

end

vim.api.nvim_create_user_command("OpenEssayDir", function(opts)
		local target_directory = opts.args
		M.openessaydir(target_directory)
	end, {
		nargs = 1,
		complete = "dir"
	}
)

function M.essaymenu()

	local Win_id

	function CloseMenu()
	  vim.api.nvim_win_close(Win_id, true)
	end

	function ShowMenu(opts, cb)
	  local height = 20
	  local width = 30
	  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

	  Win_id = popup.create(opts, {
		title = "Essay Menu",
		-- line = math.floor(((vim.o.lines - height) / 2) - 1),
		-- col = math.floor((vim.o.columns - width) / 2),
		minwidth = width,
		minheight = height,
		borderchars = borderchars,
		callback = cb,
	  })
	  local bufnr = vim.api.nvim_win_get_buf(Win_id)
	  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent=false })
	  end

	ShowMenu(known_essay_dict, function(_, sel)
			M.openessaydir(sel)
		end
	)
end

vim.api.nvim_create_user_command("EssayMenu", function(opts)
		M.essaymenu()
	end,
	{
		nargs = 0,
	}
)

vim.keymap.set("n", "<leader>mk", M.essaymenu, {desc = "Make an essay menu"})

return M

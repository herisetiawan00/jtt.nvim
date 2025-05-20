local M = {}

local Language = require("jtt.languages.base")
local language_defaults = require("jtt.config.language_defaults")

M.languages = {}

function M.setup(user_config)
	user_config = user_config or {}

	for lang, defaults in pairs(language_defaults) do
		local handler = Language:new(defaults)

		local overrides = user_config.languages and user_config.languages[lang]
		if overrides then
			handler:setup(overrides)
		end

		M.languages[lang] = handler
	end
end

local function trim(s)
	return s:gsub("^%s+", ""):gsub("%s+$", "")
end

function M.jump_to_test()
	local filetype = vim.bo.filetype
	local handler = M.languages[filetype]

	if not handler then
		print("Unsupported filetype: " .. filetype)
		return
	end

	local target_file = handler:get_target()

	if not target_file then
		print("Unable to determine target file")
		return
	end

	local result = vim.fn.system("fd --full-path " .. target_file)
	local path = trim(result:match("([^\n]*)"))

	if path ~= "" then
		vim.cmd("edit " .. path)
	else
		print("Test/source file not found: " .. target_file)
	end
end

vim.api.nvim_create_user_command("JumpTest", function()
	M.jump_to_test()
end, {})

vim.keymap.set("n", "<C-T>", M.jump_to_test, { desc = "Jump to test/source file" })

return M

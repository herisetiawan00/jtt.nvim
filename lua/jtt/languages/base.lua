local Language = {}
Language.__index = Language

function Language:new(defaults)
	local instance = setmetatable({}, self)
	instance._defaults = defaults or {}
	instance._overrides = {}
	return instance
end

function Language:setup(user_opts)
	self._overrides = user_opts or {}
end

function Language:get_opt(name)
	if self._overrides[name] ~= nil then
		return self._overrides[name]
	else
		return self._defaults[name]
	end
end

function Language:get_target()
	local basename = vim.fn.expand("%:t:r")
	local path_head = vim.fn.expand("%:h")

	local source_path_prefix = self:get_opt("source_path_prefix")
	local test_path_prefix = self:get_opt("test_path_prefix")

	local source_path_head = ""
	local test_path_head = ""
	if source_path_prefix and test_path_prefix then
		source_path_head = string.gsub(path_head, test_path_prefix, source_path_prefix, 1)
		test_path_head = string.gsub(path_head, source_path_prefix, test_path_prefix, 1)
	end

	local ext = self:get_opt("ext")
	if ext == nil then
		ext = "." .. vim.fn.expand("%:e")
	end

	local source_ext = self:get_opt("source_ext") or ext

	local mode = self:get_opt("mode")
	local test = self:get_opt("test") or ""

	if mode == "prefix" then
		if basename:sub(1, #test) == test then
			return source_path_head .. "/" .. basename:sub(#test + 1) .. source_ext
		else
			return test_path_head .. "/" .. test .. basename .. ext
		end
	elseif mode == "suffix" then
		if basename:sub(-#test) == test then
			return source_path_head .. "/" .. basename:sub(1, #basename - #test) .. source_ext
		else
			return test_path_head .. "/" .. basename .. test .. ext
		end
	else
		error("Unknown mode: " .. tostring(mode))
	end
end

return Language

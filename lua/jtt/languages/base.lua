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

	local ext = self:get_opt("ext")
	if ext == nil then
		ext = "." .. vim.fn.expand("%:e")
	end

	local source_ext = self:get_opt("source_ext") or ext

	local mode = self:get_opt("mode")
	local test = self:get_opt("test") or ""

	if mode == "prefix" then
		if basename:sub(1, #test) == test then
			return basename:sub(#test + 1) .. source_ext
		else
			return test .. basename .. ext
		end
	elseif mode == "suffix" then
		if basename:sub(-#test) == test then
			return basename:sub(1, #basename - #test) .. source_ext
		else
			return basename .. test .. ext
		end
	else
		error("Unknown mode: " .. tostring(mode))
	end
end

function Language:get_path()
	local basename = vim.fn.expand("%:t:r")
	local path_head = vim.fn.expand("%:h")

	local source_path_prefix = self:get_opt("source_path_prefix")
	local test_path_prefix = self:get_opt("test_path_prefix")

	if not source_path_prefix or not test_path_prefix then
		return "."
	end

	local test = self:get_opt("test") or ""

	if basename:sub(1, #test) == test or basename:sub(-#test) == test then
		return string.gsub(path_head, test_path_prefix, source_path_prefix, 1)
	else
		return string.gsub(path_head, source_path_prefix, test_path_prefix, 1)
	end
end

return Language

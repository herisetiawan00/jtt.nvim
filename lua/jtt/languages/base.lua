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

	local mode = self:get_opt("mode")
	local test_prefix = self:get_opt("test_prefix") or ""
	local test_suffix = self:get_opt("test_suffix") or ""

	if mode == "prefix" then
		if basename:sub(1, #test_prefix) == test_prefix then
			return basename:sub(#test_prefix + 1) .. ext
		else
			return test_prefix .. basename .. ext
		end
	elseif mode == "suffix" then
		if basename:sub(- #test_suffix) == test_suffix then
			return basename:sub(1, #basename - #test_suffix) .. ext
		else
			return basename .. test_suffix .. ext
		end
	elseif mode == "dot_suffix" then
		if basename:sub(- #test_suffix) == test_suffix then
			return basename:sub(1, #basename - #test_suffix) .. ext
		else
			return basename .. test_suffix .. ext
		end
	else
		error("Unknown mode: " .. tostring(mode))
	end
end

return Language

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
	local test = self:get_opt("test") or ""

	if mode == "prefix" then
		if basename:sub(1, #test) == test then
			return basename:sub(#test + 1) .. ext
		else
			return test .. basename .. ext
		end
	elseif mode == "suffix" then
		if basename:sub(- #test) == test then
			return basename:sub(1, #basename - #test) .. ext
		else
			return basename .. test .. ext
		end
	else
		error("Unknown mode: " .. tostring(mode))
	end
end

return Language

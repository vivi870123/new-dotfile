local tables = mines.util.tables.str_to_clean_tbl

local M = {}

function M.regex(str, regex)
	return vim.api.nvim_eval(string.format([[ '%s'  =~# '%s' ]], str, regex)) == 1
end

function M.iregex(str, regex)
	return vim.api.nvim_eval(string.format([[ '%s'  =~? '%s' ]], str, regex)) == 1
end

function M.split_components(str, pattern)
	local t = {}
	for v in string.gmatch(str, pattern) do
		t[#t + 1] = v
	end
	return t
end

function M.str_to_clean_tbl(cmd_string)	
	return tables.str_to_clean_tbl(cmd_string)
end

function M.empty(str)
	return str == ''
end

return M

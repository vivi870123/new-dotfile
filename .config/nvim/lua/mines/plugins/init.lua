local nvim = mines.nvim
local echoerr = mines.util.messages.echoerr

if nvim.has('nvim-0.5') then
    local plugins = {
        -- iron       = { ok = false, status  = false},
        lsp_config = { ok = false, status  = false},
        telescope  = { ok = false, status  = false},
        -- neorocks   = { ok = false, status  = false},
        treesitter = { ok = false, status  = false},
        -- snippets   = { ok = false, status  = false},
        -- colors     = { ok = false, status  = false},
        -- statusline = { ok = false, status  = false},
        completion = { ok = false, status  = false},
    }

    for plugin, _ in pairs(plugins) do
        local ok, status = pcall(require, 'mines/plugins/'..plugin)
        plugins[plugin].ok = ok
        plugins[plugin].status = status
        if not ok then
            echoerr(string.format('Failed to load %s, Error: %s', plugin, status))
            plugins[plugin].status = false
        end
    end

    require "mines.grep"
end

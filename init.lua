--testtesttest Module for managing pop up windows in NeoVim

local M = {}


M.open_popup = function(opts)
    local default_opts = {
        width = 50,
        height = 10,
        title = "Popup",
        content = "Hello, this is pop up!"
    }

    -- Merge opts
    opts = vim.tbl_deep_extend("force", default_opts, opts or {})

    -- Create new buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Paint content into window
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, opts.content)

    -- Define the floating window contents
    local win_opts = {
        relative = "editor",
        width = opts.width,
        height = opts.height,
        col = math.floor((vim.o.columns - opts.width) / 2),
        row = math.floor((vim.o.lines - opts.height) / 2),
        style = "minimal",
        border = "rounded",
    }

    -- Open the floating window
    local win = vim.api.nvim_open_win(buf, true, win_opts)

    if opts.title then
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        vim.api.nvim_buf_set_option(buf, "readonly", true)
    end

    return win, buf
end


return M

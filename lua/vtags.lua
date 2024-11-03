-- Overriding Keybinds
local vlog_group = vim.api.nvim_create_augroup("verilog_key_bindings", {})

function vlog_bind(cmd, augroup)
    vim.api.nvim_create_autocmd("Filetype", {
        pattern = "*verilog_systemverilog*",
        command = cmd,
        group = augroup,
    })
end

vlog_bind('map <leader>a <Plug>VerilogEmacsAutoAdd :redraw! <CR>', vlog_group)
vlog_bind('map <leader><leader>a <Plug>VerilogEmacsAutoAdd', vlog_group)
vlog_bind('map <leader>d <Plug>VerilogEmacsAutoDelete :redraw! <CR>', vlog_group)
vlog_bind('map <leader><leader>d <Plug>VerilogEmacsAutoDelete', vlog_group)
vim.cmd [[source $HOME/dotfiles/verilog_emacsauto.vim]]
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.sv", "*.v" },
    callback = function()
        local handle = io.popen("python3 --version")

        if handle == nil then
            -- Send a notification if the command fails to execute
            vim.notify("Failed to check Python 3 installation. Unable to execute the command.", vim.log.levels.ERROR)
            return
        end

        local result = handle:read("*a")
        handle:close()

        if result == "" then
            -- Send the error message to nvim-notify
            vim.notify("Python 3 is not installed for vtags! Please install Python 3 to continue.", vim.log.levels.ERROR)
            return
        end
        vim.cmd [[source $HOME/.local/share/nvim/lazy/vtags/lua/vtags-3.11/vtags_vim_api.vim]]
    end,
})

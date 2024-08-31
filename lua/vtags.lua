-- Create vtags keybinds. This is pretty clanky compared to other plugins

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
vlog_bind(
    'nnoremap <buffer> <leader>v : py3 try_show_frame() <CR> <C-w>h <CR> : set filetype=verilog_systemverilog <CR>',
    vlog_group)
vlog_bind(
    'nnoremap <buffer> <leader>i : py3 try_go_into_submodule() <CR> : py try_show_frame() <CR> : py try_print_module_trace() <CR>',
    vlog_group)
vlog_bind(
    'nnoremap <buffer> <leader>u : py3 try_go_upper_module() <CR> : py try_show_frame() <CR> : py try_print_module_trace() <CR>',
    vlog_group)
vlog_bind('nnoremap <buffer> <leader>mt      : py3 try_print_module_trace()        <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <leader>ct      : py3 clear_trace()                   <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <leader><Left>  : py3 try_trace_signal_sources()      <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <leader><Right> : py3 try_trace_signal_destinations() <CR>', vlog_group)
vlog_bind('nnoremap <buffer> gi              : py3 try_go_into_submodule()           <CR>', vlog_group)
vlog_bind('nnoremap <buffer> gu              : py3 try_go_upper_module()             <CR>', vlog_group)
vlog_bind('nnoremap <buffer> mt              : py3 try_print_module_trace()          <CR>', vlog_group)
vlog_bind('nnoremap <buffer> ct              : py3 clear_trace()                     <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <Space><Down>   : py3 try_roll_back()                   <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <Space><Up>     : py3 try_go_forward()                  <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <Space>c        : py3 try_add_check_point()             <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <Space>b        : py3 try_add_base_module()             <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <Space>         : py3 try_space_operation()             <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <Space>s        : py3 try_save_env_snapshort()          <CR>', vlog_group)
vlog_bind('nnoremap <buffer> <Space>r        : py3 try_reload_env_snapshort()        <CR>', vlog_group)

vim.cmd [[source $HOME/dotfiles/verilog_emacsauto.vim]]
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.sv", "*.v" },
    callback = function()
        local handle = io.popen("python --version")

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
        vim.cmd [[source $HOME/.vtags-3.01/vtags_vim_api.vim]]
    end,
})

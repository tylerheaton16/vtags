"""
" http://www.vim.org/scripts/script.php?script_id=5494
"""
"===============================================================================
" BSD 2-Clause License
"
" Copyright (c) 2016, CaoJun
" All rights reserved.
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are met:
"
" * Redistributions of source code must retain the above copyright notice, this
"   list of conditions and the following disclaimer.
"
" * Redistributions in binary form must reproduce the above copyright notice,
"   this list of conditions and the following disclaimer in the documentation
"   and/or other materials provided with the distribution.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
" IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
" DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
" FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
" DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
" SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
" CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
" OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
" OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"===============================================================================

let s:path = expand('<sfile>:p:h')

function! VimPythonExtend()
if has('python')
python << EOF
import sys
import os
import vim
vtags_install_path = vim.eval('s:path')
assert(os.path.isdir(vtags_install_path))
sys.path.insert(0,vtags_install_path)
from Lib.ExceptionLib import *

vim.command("let s:vtags_active = 0")
try:
    from InlineLib.InlineAPI import *
    vim.command("let s:vtags_active = 1")
except VtagsDBNotFoundExcept:
    pass
except VtagsUnsupportFileExcept:
    pass

EOF
elseif has('python3')
python3 << EOF
import sys
import os
import vim
vtags_install_path = vim.eval('s:path')
assert(os.path.isdir(vtags_install_path))
sys.path.insert(0,vtags_install_path)
from Lib.ExceptionLib import *

vim.command("let s:vtags_active = 0")
try:
    from InlineLib.InlineAPI import *
    vim.command("let s:vtags_active = 1")
except VtagsDBNotFoundExcept:
    pass
except VtagsUnsupportFileExcept:
    pass

EOF
endif
endfunction

"vi_HDLTags_begin-----------------------------------
call VimPythonExtend()
""if s:vtags_active == 1
""    if has('python')
""        map gi                   :py  try_go_into_submodule()           <CR>
""        map gu                   :py  try_go_upper_module()             <CR>
""        map mt                   :py  try_print_module_trace()          <CR>
""        map ct                   :py  clear_trace()                     <CR>
""        map <Space><Left>        :py  try_trace_signal_sources()        <CR>
""        map <Space><Right>       :py  try_trace_signal_destinations()   <CR>
""        map <Space><Down>        :py  try_roll_back()                   <CR>
""        map <Space><Up>          :py  try_go_forward()                  <CR>
""        map <Space>v             :py  try_show_frame()                  <CR>
""        map <Space>c             :py  try_add_check_point()             <CR>
""        map <Space>b             :py  try_add_base_module()             <CR>
""        map <Space>              :py  try_space_operation()             <CR>
""        "map <Space>h             :py  try_hold_current_win()            <CR>
""        "map <Space>d             :py  try_del_operation()               <CR>
""        map <Space>s             :py  try_save_env_snapshort()          <CR>
""        map <Space>r             :py  try_reload_env_snapshort()        <CR>
""        "map <Space>q             :py  try_close_all_windows()           <CR>
""    elseif has('python3')
""        map gi                   :py3 try_go_into_submodule()           <CR>
""        map gu                   :py3 try_go_upper_module()             <CR>
""        map mt                   :py3 try_print_module_trace()          <CR>
""        map ct                   :py3 clear_trace()                     <CR>
""        map <Space><Left>        :py3 try_trace_signal_sources()        <CR>
""        map <Space><Right>       :py3 try_trace_signal_destinations()   <CR>
""        map <Space><Down>        :py3 try_roll_back()                   <CR>
""        map <Space><Up>          :py3 try_go_forward()                  <CR>
""        map <Space>v             :py3 try_show_frame()                  <CR>
""        map <Space>c             :py3 try_add_check_point()             <CR>
""        map <Space>b             :py3 try_add_base_module()             <CR>
""        map <Space>              :py3 try_space_operation()             <CR>
""        "map <Space>h             :py3 try_hold_current_win()            <CR>
""        "map <Space>d             :py3 try_del_operation()               <CR>
""        map <Space>s             :py3 try_save_env_snapshort()          <CR>
""        map <Space>r             :py3 try_reload_env_snapshort()        <CR>
""        "map <Space>q             :py3 try_close_all_windows()           <CR>
""    endif
""endif
"vi_HDLTags_end-------------------------------------

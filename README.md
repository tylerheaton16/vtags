# vtags
Synopsys Verdi like Verilog/SystemVerilog navigation

Thank you Jun Cao for this great plugin!
Plugin location - https://www.vim.org/scripts/script.php?script_id=5494

Just using this with my own modifications (i.e. to work with python3 etc)

### 1. **Make sure to add an alias in your .bashrc to run `vtags`**

```sh
alias vtags='usr/bin/python3 $HOME/.local/share/nvim/lazy/vtags/lua/vtags-3.11/vtags.py
```

### 2. **Add vtags to *.lua file**

```lua
{
    "tylerheaton16/vtags",
     config = function()
        require("vtags")
     end,
},
```



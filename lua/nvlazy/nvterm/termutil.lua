local util = require("nvterm.termutil")
local a = vim.api
local float_types = { "float", "lazygit" }

util.execute_type_cmd = function(type, terminals, override)
  local opts = terminals.type_opts[type]
  local dims = not vim.tbl_contains(float_types, type) and util.get_split_dims(type, opts.split_ratio) or util.calc_float_opts(opts)
  dims = override and "" or dims
  local type_cmds = {
    horizontal = function()
      vim.cmd(opts.location .. dims .. " split")
    end,
    vertical = function()
      vim.cmd(opts.location .. dims .. " vsplit")
    end,
    float = function()
      a.nvim_open_win(0, true, dims)
    end,
  }

  type_cmds[type]()
end

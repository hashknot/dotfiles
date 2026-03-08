local fzf = require('fzf-lua')

local function get_root()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 and git_root and git_root ~= '' then
    return git_root
  end
  return vim.fn.getcwd()
end

fzf.setup({})

return {
  files = function() fzf.files({ cwd = get_root() }) end,
}

local fzf = require('fzf-lua')

local function get_root()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 and git_root and git_root ~= '' then
    return git_root
  end
  return vim.fn.getcwd()
end

fzf.setup({
  keymap = {
    fzf = {
      ['alt-j'] = 'down',
      ['alt-k'] = 'up',
    },
  },
})

local function files(opts)
  opts = vim.tbl_extend('force', { cwd = get_root() }, opts or {})
  fzf.files(opts)
end

return {
  files = function()
    files({
      actions = {
        ['ctrl-g'] = function(_, o)
          files({
            fd_opts = table.concat({
              '--no-ignore',
              '--exclude node_modules',
              '--exclude __pycache__',
              '--exclude .git',
              '--exclude .venv',
              '--exclude venv',
              '--exclude dist',
              '--exclude build',
              '--exclude .next',
              '--exclude .nuxt',
              '--exclude .cache',
              '--exclude .tox',
              '--exclude .mypy_cache',
              '--exclude .pytest_cache',
              '--exclude .ruff_cache',
              '--exclude *.pyc',
              '--exclude Pods',
              '--exclude .expo',
              '--exclude .pnpm-store',
            }, ' '),
            query = o.last_query,
          })
        end,
      },
    })
  end,
}

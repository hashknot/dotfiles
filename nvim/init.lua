require('options')
require('plugins')
require('keymaps')
require('autocmds')
require('custom.directory-watcher').setup({
  path = vim.fn.getcwd(),
  debounce = 100,
})

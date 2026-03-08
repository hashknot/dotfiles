local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        'tummetott/unimpaired.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
      'ibhagwan/fzf-lua',
      config = function()
        require('plugins.fzf')
      end,
      keys = {
        { '<C-p>', '<cmd>FzfLua files<cr>', desc = 'Find files' },
        { '<D-p>', '<cmd>FzfLua files<cr>', desc = 'Find files' },
      },
    },
    {
      'sindrets/diffview.nvim',
      version = '*',
      config = function()
        require('plugins.diffview')
      end,
    },
    require('plugins.render-markdown'),
    require('plugins.yazi'),
})

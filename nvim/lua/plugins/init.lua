local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
            highlight_overrides = {
                mocha = function(colors)
                    local blend = function(fg, bg, alpha)
                        local f = type(fg) == "string" and tonumber(fg:sub(2), 16) or fg
                        local b = type(bg) == "string" and tonumber(bg:sub(2), 16) or bg
                        local r = math.floor(bit.band(bit.rshift(f, 16), 0xFF) * alpha + bit.band(bit.rshift(b, 16), 0xFF) * (1 - alpha))
                        local g = math.floor(bit.band(bit.rshift(f, 8), 0xFF) * alpha + bit.band(bit.rshift(b, 8), 0xFF) * (1 - alpha))
                        local bl = math.floor(bit.band(f, 0xFF) * alpha + bit.band(b, 0xFF) * (1 - alpha))
                        return string.format("#%02x%02x%02x", r, g, bl)
                    end
                    return {
                        DiffAdd = { bg = blend(colors.green, colors.base, 0.25) },
                        DiffDelete = { bg = blend(colors.red, colors.base, 0.25) },
                        DiffChange = { bg = blend(colors.yellow, colors.base, 0.15) },
                        DiffText = { bg = blend(colors.blue, colors.base, 0.35) },
                    }
                end,
                latte = function(colors)
                    local blend = function(fg, bg, alpha)
                        local f = type(fg) == "string" and tonumber(fg:sub(2), 16) or fg
                        local b = type(bg) == "string" and tonumber(bg:sub(2), 16) or bg
                        local r = math.floor(bit.band(bit.rshift(f, 16), 0xFF) * alpha + bit.band(bit.rshift(b, 16), 0xFF) * (1 - alpha))
                        local g = math.floor(bit.band(bit.rshift(f, 8), 0xFF) * alpha + bit.band(bit.rshift(b, 8), 0xFF) * (1 - alpha))
                        local bl = math.floor(bit.band(f, 0xFF) * alpha + bit.band(b, 0xFF) * (1 - alpha))
                        return string.format("#%02x%02x%02x", r, g, bl)
                    end
                    return {
                        DiffAdd = { bg = blend(colors.green, colors.base, 0.15) },
                        DiffDelete = { bg = blend(colors.red, colors.base, 0.15) },
                        DiffChange = { bg = blend(colors.yellow, colors.base, 0.10) },
                        DiffText = { bg = blend(colors.blue, colors.base, 0.25) },
                    }
                end,
            },
        },
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
        { '<C-p>', function() require('plugins.fzf').files() end, desc = 'Find files' },
        { '<D-p>', function() require('plugins.fzf').files() end, desc = 'Find files' },
      },
    },
    {
      'sindrets/diffview.nvim',
      version = '*',
      config = function()
        require('plugins.diffview')
      end,
    },
    {
      'NMAC427/guess-indent.nvim',
      event = 'BufReadPre',
      opts = {},
    },
    {
      'kevinhwang91/nvim-ufo',
      dependencies = { 'kevinhwang91/promise-async' },
      event = 'BufReadPost',
      keys = {
        { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
        { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
      },
      opts = {
        provider_selector = function()
          return { 'indent' }
        end,
      },
    },
    {
      'gbprod/substitute.nvim',
      event = 'VeryLazy',
      opts = {},
      keys = {
        { 'cp', function() require('substitute').operator() end, desc = 'Substitute' },
        { 'cpp', function() require('substitute').line() end, desc = 'Substitute line' },
        { 'cp', function() require('substitute').visual() end, mode = 'x', desc = 'Substitute visual' },
        { 'cx', function() require('substitute.exchange').operator() end, desc = 'Exchange' },
        { 'cxx', function() require('substitute.exchange').line() end, desc = 'Exchange line' },
        { 'X', function() require('substitute.exchange').visual() end, mode = 'x', desc = 'Exchange visual' },
        { 'cxc', function() require('substitute.exchange').cancel() end, desc = 'Exchange cancel' },
      },
    },
    {
      'folke/flash.nvim',
      event = 'VeryLazy',
      opts = {},
      keys = {
        { 'gs', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' },
        { 'S', function() require('flash').treesitter() end, mode = { 'n', 'x', 'o' }, desc = 'Flash Treesitter' },
      },
    },
    {
      'echasnovski/mini.align',
      event = 'VeryLazy',
      opts = {},
    },
    {
      'neovim/nvim-lspconfig',
      ft = 'proto',
      config = function()
        vim.lsp.config('buf_ls', {
          cmd = { 'buf', 'beta', 'lsp' },
          filetypes = { 'proto' },
          root_markers = { 'buf.yaml', 'buf.work.yaml', '.git' },
        })
        vim.lsp.enable('buf_ls')
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      event = 'BufReadPost',
      opts = {
        ensure_installed = { 'proto' },
        highlight = { enable = true },
      },
    },
    require('plugins.render-markdown'),
    require('plugins.yazi'),
})

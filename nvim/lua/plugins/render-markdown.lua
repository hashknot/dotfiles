return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
  config = function()
    require('render-markdown').setup {
      enabled = false,
      file_types = { 'markdown' },
      code = {
        inline = false, -- Disable inline code rendering to remove background styling
      },
    }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.keymap.set('n', '<leader>pm', function()
          require('render-markdown').toggle()
        end, { desc = '[P]review [M]arkdown', buffer = true })
      end,
    })
  end,
  ft = { 'markdown' },
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'DiffviewViewLeave',
  callback = function()
    vim.cmd ':DiffviewClose'
  end,
})

vim.cmd.colorscheme "catppuccin"
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.cmd.colorscheme("catppuccin")
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  end,
})

if vim.env.TMUX then
    local appearance = vim.fn.system("tmux show-environment -g APPEARANCE 2>/dev/null"):match("=(%w+)")
    vim.o.background = (appearance == "dark") and "dark" or "light"
end

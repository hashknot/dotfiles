vim.api.nvim_create_autocmd('User', {
  pattern = 'DiffviewViewLeave',
  callback = function()
    vim.cmd ':DiffviewClose'
  end,
})

vim.cmd.colorscheme "wildcharm"
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.cmd.colorscheme("wildcharm")
  end,
})

if vim.env.TMUX then
    local appearance = vim.fn.system("tmux show-environment APPEARANCE 2>/dev/null"):match("=(%w+)")
    vim.o.background = (appearance == "dark") and "dark" or "light"
end

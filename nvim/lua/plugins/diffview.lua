local actions = require('diffview.actions')

require('diffview').setup {
  default_args = {
    DiffviewOpen = { '--imply-local' },
  },
  keymaps = {
    view = {
      { 'n', 'q',  '<cmd>DiffviewClose<cr>',                   { desc = 'Close diffview' } },
      { 'n', ']f', actions.select_next_entry,                  { desc = 'Next file' } },
      { 'n', '[f', actions.select_prev_entry,                  { desc = 'Prev file' } },
    },
    file_panel = {
      { 'n', 'q',  '<cmd>DiffviewClose<cr>',                   { desc = 'Close diffview' } },
      { 'n', ']f', actions.select_next_entry,                  { desc = 'Next file' } },
      { 'n', '[f', actions.select_prev_entry,                  { desc = 'Prev file' } },
    },
    file_history_panel = {
      { 'n', 'q',  '<cmd>DiffviewClose<cr>',                   { desc = 'Close diffview' } },
      { 'n', ']f', actions.select_next_entry,                  { desc = 'Next file' } },
      { 'n', '[f', actions.select_prev_entry,                  { desc = 'Prev file' } },
    },
  },
}

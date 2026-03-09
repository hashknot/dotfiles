vim.keymap.set({'n', 'v'}, ';', ':', { noremap = true })
vim.keymap.set({'n', 'v'}, ':', ';', { noremap = true })
vim.keymap.set({'n', 'v'}, '0', '^', { noremap = true })
vim.keymap.set({'n', 'v'}, '^', '0', { noremap = true })

-- Jump to specific column within a line using '<mark>
vim.keymap.set({'n', 'v'}, "'", '`')
vim.keymap.set({'n', 'v'}, "`", "'")

local is_git_ignored = function(filepath)
  vim.fn.system('git check-ignore -q ' .. vim.fn.shellescape(filepath))
  return vim.v.shell_error == 0
end

if vim.g.vscode then
    local function moveCursor(direction)
        if (vim.v.count == 0  and vim.fn.reg_recording() == '' and vim.fn.reg_executing() == '') then
            return ('g' .. direction)
        else
            return direction
        end
    end

    vim.keymap.set('n', 'k', function()
        return moveCursor('k')
    end, { expr = true, remap = true })
    vim.keymap.set('n', 'j', function()
        return moveCursor('j')
    end, { expr = true, remap = true })


    local vscode = require('vscode')

    local function keymapVscall(mode, key, action)
        vim.keymap.set(mode, key, function()
            vscode.call(action)
        end)
    end

    keymapVscall('n', 'zM', 'editor.foldAll')
    keymapVscall('n', 'zR', 'editor.unfoldAll')
    keymapVscall('n', 'zc', 'editor.fold')
    keymapVscall('n', 'zC', 'editor.foldRecursively')
    keymapVscall('n', 'zo', 'editor.unfold')
    keymapVscall('n', 'zO', 'editor.unfoldRecursively')
    keymapVscall('n', 'za', 'editor.toggleFold')
    keymapVscall('n', 'ze', 'editor.action.marker.nextInFiles')
    keymapVscall('n', '<space>h', 'workbench.action.navigateLeft')
    keymapVscall('n', '<space>l', 'workbench.action.navigateRight')
    keymapVscall('n', '<space>k', 'workbench.action.navigateUp')
    keymapVscall('n', '<space>j', 'workbench.action.navigateDown')
    keymapVscall('n', '<space>f', 'workbench.files.action.showActiveFileInExplorer')
    keymapVscall('n', '<space>=', 'workbench.action.evenEditorWidths')
else
    -- Move one view line, and not based on lines in file.
    vim.keymap.set('n', 'j', 'gj')
    vim.keymap.set('n', 'k', 'gk')

    vim.keymap.set('i', '<C-f>', '<C-x><C-f>')
    vim.keymap.set('i', '<C-l>', '<C-x><C-l>')
    vim.keymap.set('n', '<space>q', '<c-W>q')
    vim.keymap.set('n', '<space>H', '<c-W>H')
    vim.keymap.set('n', '<space>J', '<c-W>J')
    vim.keymap.set('n', '<space>K', '<c-W>K')
    vim.keymap.set('n', '<space>L', '<c-W>L')
    vim.keymap.set('n', '<space>h', '<c-W>h')
    vim.keymap.set('n', '<space>j', '<c-W>j')
    vim.keymap.set('n', '<space>k', '<c-W>k')
    vim.keymap.set('n', '<space>l', '<c-W>l')
    vim.keymap.set('n', '<space>w', '<c-W>w')
    vim.keymap.set('n', '<space>W', '<c-W>W')
    vim.keymap.set('n', '<space>=', '<c-W>=')
    vim.keymap.set('n', '<space>|', '<c-W>|')
    vim.keymap.set('n', '<space>>', '5<c-W>>')
    vim.keymap.set('n', '<space><', '5<c-W><')
    vim.keymap.set('n', '<space>+', '<cmd>resize +1<CR>')
    vim.keymap.set('n', '<space>-', '<cmd>resize -1<CR>')
    vim.keymap.set('n', '<space>o', '<cmd>tab sp<CR>')
    vim.opt.autochdir = true

    vim.keymap.set('v', '<Leader>S', "<cmd>'<,'>:!sort<cr>")
    vim.keymap.set('n', '<Leader>d', '<cmd>DiffviewOpen<cr>')

    -- Quit all windows in the current tab
    vim.keymap.set('n', '<Leader>x', '<cmd>windo q<cr>')
end

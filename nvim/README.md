# Neovim Config

## Structure

```
init.lua                  -- Entry point, requires the modules below
lua/
  options.lua             -- Vim options (leader, search, display, tabs)
  keymaps.lua             -- Key mappings, with separate sections for vscode-neovim and terminal nvim
  autocmds.lua            -- Autocommands and colorscheme setup
  plugins/
    init.lua              -- Plugin declarations via lazy.nvim
    <plugin>.lua          -- Per-plugin configuration (setup, keymaps, options)
```

## Guidelines

### Adding a plugin

1. Add the plugin spec to `plugins/init.lua`.
2. If the plugin needs more than just `opts = {}`, create a dedicated `plugins/<plugin>.lua` file and reference it with `config = function() require('plugins.<plugin>') end`.
3. Keep plugin-specific keymaps in the plugin spec (`keys = { ... }`) or in the plugin's config file — not in `keymaps.lua`.
4. Use lazy-loading where possible (`event`, `keys`, `cmd`, `ft`).

### Keymaps

- `keymaps.lua` is for general-purpose mappings only.
- The file has a `vim.g.vscode` branch — vscode-neovim specific mappings go in the `if` block, terminal nvim mappings go in the `else` block.
- Plugin-specific keymaps belong with their plugin config.

### Options and autocmds

- `options.lua` — vim options only, no logic.
- `autocmds.lua` — autocommands, colorscheme selection, and environment-dependent setup (e.g. tmux appearance detection).

### General

- Prefer minimal config. Don't add options or keymaps you won't use.
- This config is also loaded by vscode-neovim — anything in the top-level `keymaps.lua` and `options.lua` runs in both contexts. Guard terminal-only code with `if not vim.g.vscode`.

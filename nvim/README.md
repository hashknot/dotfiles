# Neovim Config

## Structure

```
init.lua                  -- Entry point, requires the modules below
lua/
  options.lua             -- Vim options (leader, search, display, tabs)
  keymaps.lua             -- Key mappings, with separate sections for vscode-neovim and terminal nvim
  autocmds.lua            -- Autocommands and colorscheme setup
  plugins/
    init.lua              -- Plugin declarations via lazy.nvim (explicit list, not auto-scanned)
    <plugin>.lua          -- Per-plugin configuration (setup, keymaps, options)
  custom/
    directory-watcher.lua -- vim.uv fs_event watcher utility
```

## Guidelines

### Adding a plugin

Plugins are **not** auto-scanned — every plugin must be explicitly listed inside the `require('lazy').setup({ ... })` table in `plugins/init.lua`.

**Simple plugin** (inline spec, no dedicated file):

```lua
-- plugins/init.lua
{ 'author/plugin.nvim', opts = {} },
```

**Complex plugin** (dedicated config file):

1. Create `plugins/<plugin>.lua` returning a lazy spec table (i.e. `return { 'author/plugin.nvim', config = function() ... end }`).
2. Add `require('plugins.<plugin>')` as an entry in the `require('lazy').setup({ ... })` table in `plugins/init.lua`.

Keep plugin-specific keymaps in the plugin spec (`keys = { ... }`) or in the plugin's config file — not in `keymaps.lua`.
Use lazy-loading where possible (`event`, `keys`, `cmd`, `ft`).

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

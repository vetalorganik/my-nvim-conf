# Neovim Config

Personal Neovim configuration built on Neovim's native plugin manager (`vim.pack`) — no lazy.nvim or other third-party bootstrapper required.

## Requirements

- Neovim 0.11+
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal
- `git` on PATH (plugin manager uses it to clone repos)
- Language-specific tools installed via Mason (`:Mason` to open the UI)

## Features

### Editor

| Feature | Details |
|---|---|
| Line numbers | Relative + absolute |
| Cursor | Highlighted current line, 10-line scroll margin |
| Indentation | 4 spaces, auto-detected per file via `guess-indent` |
| Clipboard | Synced with the OS clipboard |
| Undo | Persistent across sessions (no swap files) |
| Auto-save | Saves on `InsertLeave` / `TextChanged` for normal file buffers |
| Spellcheck | English, Russian, Ukrainian (`en`, `ru`, `uk`) |
| Yank highlight | Briefly highlights yanked text |
| Live substitution | `:s` preview splits open as you type |

### LSP

Powered by `nvim-lspconfig` + `mason.nvim`. Mason-installed servers are detected and enabled automatically — no manual registration needed.

| Capability | Details |
|---|---|
| Diagnostics | Virtual text inline; float opens automatically on cursor jump |
| Neovim API completions | `lazydev.nvim` — full `vim.*` types without extra workspace scanning |
| Progress indicator | `fidget.nvim` shows spinner in bottom-right corner |
| Inlay hints | Toggle with `<leader>th` |

LSP keymaps (active when an LSP is attached):

| Key | Action |
|---|---|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grD` | Go to declaration |
| `grd` | Go to definition |
| `grr` | Go to references |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |

### Completion

`blink.cmp` with the `super-tab` preset. Sources: LSP, path, snippets, buffer, and lazydev (Neovim API). Documentation auto-shows after 200 ms.

### Formatting

`conform.nvim` formats on save for these file types:

| Language | Formatter |
|---|---|
| Lua | `stylua` |
| Python | `black` |
| Rust | `rustfmt` |
| JavaScript / TypeScript | `eslint_d` |
| Svelte | `prettierd` → `prettier` |

| Key | Action |
|---|---|
| `<leader>f` | Format current buffer |
| `<leader>F` | Format all open buffers |

### Syntax Highlighting

`nvim-treesitter` with auto-install. Parsers bundled by default: Bash, C, diff, HTML, Lua, Markdown, Vim, Vimdoc. Auto-installed on first open: JavaScript, TypeScript, Python, Rust, C++, Svelte, Dockerfile. Any other supported language parser is auto-installed when you open a file of that type.

### File Tree

`neo-tree.nvim` sidebar (30 columns wide).

- Auto-closes when a file is opened
- Follows the current file in the tree
- Git status icons in the sidebar

| Key | Action |
|---|---|
| `<leader>e` | Toggle / reveal current file in tree |

### Fuzzy Search

`telescope.nvim` with `fzf-native` for fast matching and `ui-select` for code action menus.

| Key | Action |
|---|---|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search word under cursor |
| `<leader>sb` | Open buffers |
| `<leader>sd` | Diagnostics |
| `<leader>sh` | Help tags |
| `<leader>sk` | Keymaps |
| `<leader>sc` | Commands |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>s/` | Fuzzy search in current buffer |
| `<leader>sn` | Search in Neovim config files |

### Git

`gitsigns.nvim` shows change markers in the sign column (`+` add, `~` change, `_` / `‾` delete).

| Key | Action |
|---|---|
| `]c` / `[c` | Jump to next / previous hunk |
| `<leader>hs` | Stage hunk (normal + visual) |
| `<leader>hr` | Reset hunk (normal + visual) |
| `<leader>hS` | Stage entire buffer |
| `<leader>hR` | Reset entire buffer |
| `<leader>hp` | Preview hunk (float) |
| `<leader>hi` | Preview hunk inline |
| `<leader>hb` | Blame current line (full) |
| `<leader>hd` | Diff against index |
| `<leader>hD` | Diff against last commit |
| `<leader>hq` | Hunk quickfix list (current file) |
| `<leader>hQ` | Hunk quickfix list (whole repo) |
| `<leader>hx` | Close diff window |
| `<leader>tb` | Toggle inline blame |
| `<leader>tw` | Toggle word diff |
| `ih` | Text object — select hunk (operator + visual) |

### UI

| Plugin | Role |
|---|---|
| `tokyonight.nvim` | Color scheme (Night variant) |
| `mini.statusline` | Lightweight status line with file info and cursor position |
| `mini.tabline` | Buffer tabs at the top |
| `mini.starter` | Dashboard on startup with quick-access actions |
| `indent-blankline` | Indent guide lines |
| `nvim-web-devicons` | File type icons (requires Nerd Font) |
| `which-key.nvim` | Keymap hint popup (appears after 400 ms) |
| `todo-comments.nvim` | Highlights `TODO`, `FIXME`, `NOTE`, etc. |

### Text Editing Utilities

From `mini.nvim`:

| Module | What it does |
|---|---|
| `mini.pairs` | Auto-closes brackets, quotes, etc. |
| `mini.surround` | Add / delete / replace surrounding characters (`sa`, `sd`, `sr`) |
| `mini.ai` | Extended `a`/`i` text objects (`va)`, `ci'`, `yiiq`, …) |

## General Keymaps

Leader key: `Space`

| Key | Action |
|---|---|
| `<leader>w` | Save file |
| `<leader>W` | Save all files |
| `<leader>q` | Save and quit |
| `<leader>Q` | Quit without saving |
| `jk` | Exit insert mode |
| `<Esc>` | Clear search highlight |
| `<C-h/j/k/l>` | Move focus between splits |
| `<A-h/j/k/l>` | Move cursor in insert mode |
| `<A-j/k>` | Move selected lines up / down (visual) |
| `<A-p>` | Paste from system clipboard |
| `<Esc><Esc>` | Exit terminal mode |

### Buffer Management

| Key | Action |
|---|---|
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bd` | Delete current buffer |
| `<leader>ba` | Delete all buffers except current |

### Diagnostics

| Key | Action |
|---|---|
| `<leader>do` | Open diagnostic location list |
| `<leader>dc` | Close diagnostic location list |
| `<leader>df` | Toggle focus into / out of diagnostic list |

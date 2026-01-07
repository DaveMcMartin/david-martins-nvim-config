# David Martins Neovim Config

A feature-rich Neovim configuration using native vim pack plugin management. Includes LSP support, debugger (DAP), code completion, Telescope fuzzy finder, and more.

## Features

- **LSP Support**: Full language server protocol integration with Mason
- **Code Completion**: nvim-cmp with snippet support (LuaSnip)
- **Fuzzy Finder**: Telescope for files, buffers, grep
- **Debugger**: DAP (Debug Adapter Protocol) with UI
- **File Explorer**: Neo-tree for filesystem navigation
- **Syntax Highlighting**: Treesitter with incremental parsing
- **Testing**: Neotest integration with adapters
- **Git Integration**: Gitsigns and LazyGit
- **Code Formatting**: Conform with multiple formatters
- **Diagnostics**: Trouble for workspace/document diagnostics
- **UI Enhancements**: Bufferline, Lualine, Noice notifications

## Requirements

- **Neovim** >= 0.12 (for native vim pack plugin manager)
- **Git** (for plugin management)
- **ripgrep** (for Telescope live_grep)
- **Node.js** >= 16 (for TypeScript, JavaScript, JSON LSPs)
- **Python** >= 3.8 (for Python LSP)
- **Go** >= 1.18 (for Go LSP)
- **lazygit** (Git UI - for LazyGit plugin)
- **fd** (faster alternative to find)
- **fzf** (optional, for better Telescope integration)

## Installation

### Prerequisites

#### macOS

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install neovim ripgrep node git

# Optional
brew install lazygit fd fzf
```

#### Linux (Ubuntu/Debian)

```bash
# Update package manager
sudo apt update

# Install required tools
sudo apt install -y neovim ripgrep git nodejs npm

# Optional
sudo apt install -y lazygit fd-find fzf
```

#### Linux (Fedora/RHEL)

```bash
# Install required tools
sudo dnf install -y neovim ripgrep git nodejs npm

# Optional
sudo dnf install -y lazygit fd-find fzf
```

#### Windows (PowerShell as Administrator)

```powershell
# Using Chocolatey
choco install neovim ripgrep git nodejs

# Or using Windows Package Manager
winget install Neovim.Neovim RipGrep Git.Git nodejs

# Optional
choco install lazygit fd fzf
```

### Setup Neovim Config

1. **Clone or link the config**:

```bash
# Clone this repository to your nvim config directory
git clone https://github.com/your-username/nvim ~/.config/nvim
```

2. **First Launch**:

```bash
# Start neovim - it will automatically load plugins from pack/plugins/start
nvim
```

The native vim pack structure automatically loads all plugins from `~/.config/nvim/pack/plugins/start/` directories.

## Keymaps

### General Navigation

| Keymap  | Action                            |
| ------- | --------------------------------- |
| `jk`    | Exit insert mode                  |
| `<C-h>` | Move to left window               |
| `<C-j>` | Move to bottom window             |
| `<C-k>` | Move to top window                |
| `<C-l>` | Move to right window              |
| `<C-d>` | Page down (centered)              |
| `<C-u>` | Page up (centered)                |
| `n`     | Next search result (centered)     |
| `N`     | Previous search result (centered) |

### Window Management

| Keymap       | Action                    |
| ------------ | ------------------------- |
| `<leader>sv` | Split window vertically   |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Make splits equal size    |
| `<leader>sx` | Close current split       |
| `<leader>sm` | Maximize/minimize split   |

### Tab Management

| Keymap       | Action                         |
| ------------ | ------------------------------ |
| `<leader>to` | Open new tab                   |
| `<leader>tx` | Close current tab              |
| `<leader>tn` | Go to next tab                 |
| `<leader>tp` | Go to previous tab             |
| `<leader>tb` | Open current buffer in new tab |

### Buffer Management

| Keymap      | Action               |
| ----------- | -------------------- |
| `<leader>q` | Close current buffer |

### File Explorer (Neo-tree)

| Keymap       | Action                            |
| ------------ | --------------------------------- |
| `<leader>ee` | Toggle file explorer (filesystem) |
| `<leader>eb` | Toggle buffer explorer            |

### Telescope (Fuzzy Finder)

| Keymap       | Action                         |
| ------------ | ------------------------------ |
| `<leader>ff` | Find files in cwd              |
| `<leader>fo` | Find recent files              |
| `<leader>fs` | Find string in cwd (live grep) |
| `<leader>fw` | Find word under cursor         |
| `<leader>ft` | Find todos                     |
| `<leader>fb` | Find open buffers              |
| `<leader>fm` | Show notifications             |

### Diagnostics & Trouble

| Keymap       | Action                       |
| ------------ | ---------------------------- |
| `<leader>xx` | Toggle Trouble list          |
| `<leader>xw` | Workspace diagnostics        |
| `<leader>xd` | Document diagnostics         |
| `<leader>xl` | Location list                |
| `<leader>xq` | Quickfix list                |
| `[d`         | Jump to previous diagnostic  |
| `]d`         | Jump to next diagnostic      |
| `<leader>d`  | Show diagnostic under cursor |
| `<leader>D`  | Show all diagnostics in file |

### LSP (Language Server Protocol)

| Keymap       | Action                   |
| ------------ | ------------------------ |
| `gd`         | Go to definition         |
| `gD`         | Go to declaration        |
| `gi`         | Go to implementation     |
| `gt`         | Go to type definition    |
| `gR`         | Show references          |
| `K`          | Show hover documentation |
| `<leader>rn` | Rename symbol            |
| `<leader>ca` | Code actions             |
| `<leader>rs` | Restart LSP              |

### Code Editing

| Keymap           | Action                                   |
| ---------------- | ---------------------------------------- |
| `<C-k>` (visual) | Move selection up                        |
| `<C-j>` (visual) | Move selection down                      |
| `s<motion>`      | Substitute with motion (substitute.nvim) |
| `ss`             | Substitute line                          |
| `S`              | Substitute to end of line                |
| `<leader>ic`     | Invert case (word under cursor)          |
| `<leader>icw`    | Invert case (whole word)                 |
| `<leader>+`      | Increment number                         |
| `<leader>-`      | Decrement number                         |

### Testing (Neotest)

| Keymap       | Action                 |
| ------------ | ---------------------- |
| `<leader>tt` | Run test at cursor     |
| `<leader>tf` | Run tests in file      |
| `<leader>td` | Run tests in directory |
| `<leader>ts` | Run test summary       |
| `<leader>tc` | Cancel tests           |

### Git

| Keymap       | Action       |
| ------------ | ------------ |
| `<leader>lg` | Open LazyGit |
| `<leader>fc` | Format code  |
| `<leader>l`  | Format file  |

### Search & Replace

| Keymap       | Action                  |
| ------------ | ----------------------- |
| `<leader>cl` | Clear search highlights |

### Formatting

| Keymap       | Action                    |
| ------------ | ------------------------- |
| `<leader>fc` | Format selection (visual) |
| `<leader>l`  | Format entire file        |

## Architecture

This config uses **native Vim pack** for plugin management:

- Plugins are stored in `pack/plugins/start/`
- Each plugin is a git submodule or cloned repository
- Configuration is organized in `lua/david/` directory:
  - `core/` - Core settings and keymaps
  - `plugins/` - Plugin configurations organized by category

## Troubleshooting

### Plugins not loading

- Ensure all submodules are initialized: `git submodule update --init --recursive`
- Check that plugins are in `pack/plugins/start/` directory

### LSP not working

- Run `:Mason` to install language servers
- Verify language server is installed: `:MasonToolsInstall`

### Telescope not finding files

- Ensure `ripgrep` is installed
- Check $PATH includes ripgrep location

## Credits

This is a personal Neovim configuration by David Martins.


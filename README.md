# Neovim Config

A "minimal" config (plugin-wise) that has every feature I need. Some setups end up an IDE with 20+ plugins; There's nothing wrong with that, but I find it hard to maintain as time goes on. This is my effort to make something useable with some newer (2022) plugins.

## Features
-   [Lazy](https://github.com/folke/lazy.nvim) for plugin management.
-   [Mini](https://github.com/echasnovski/mini.nvim) provides completions, comments, indent lines, statusline, auto-pairs, tabline, and a few others.
-   [FzfLua](https://github.com/ibhagwan/fzf-lua) where most people would use Telescope. I find Telescope can slow down on larger projects, and this modern implementation of FZF offers nearly the same features, just faster.
-   [Rooter](https://github.com/notjedi/nvim-rooter.lua) for searching within project directory.
-   LSP with [Null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) for all formatting/linting.
-   And a few others... ([which-key](https://github.com/folke/which-key.nvim), [toggleterm](https://github.com/akinsho/toggleterm.nvim), and [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)).

### Dependencies
-   Neovim > 0.8
-   [FZF](https://github.com/junegunn/fzf) > 0.27

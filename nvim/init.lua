-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ----------------------
--  vim plug
-- ----------------------

local vim = vim

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('shaunsingh/solarized.nvim')

Plug('tpope/vim-sensible')
Plug('tpope/vim-fugitive')

Plug('preservim/nerdtree')

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

Plug('stevearc/oil.nvim')

Plug('lukas-reineke/indent-blankline.nvim')
-- lsp
Plug('neovim/nvim-lspconfig')

Plug('norcalli/nvim-colorizer.lua')

vim.call('plug#end')

-- ----------------------
-- vim commands
-- ----------------------
vim.cmd('colorscheme solarized')
vim.cmd('set background=light')
vim.cmd('set nowrap')

vim.cmd('set path+=**')

-- line numbers
vim.cmd('set number')
vim.cmd('set relativenumber')

-- always show warning/error line
vim.cmd('set signcolumn=yes:1')

-- cursorline
vim.cmd('set cursorline')

-- spell check
-- vim.cmd('set spell')
vim.cmd('set spelllang=en_us,cjk')
vim.cmd('set spellsuggest=best,9')

-- smaller tabs size
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
-- spaces instead of tabs
vim.cmd('set expandtab')
-- except for godot
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.gd"},
  command = "set noexpandtab",
})


-- ----------------------
-- Godot debug config
-- ----------------------

-- write breakpoint to new line
vim.api.nvim_create_user_command('GodotBreakpoint', function()
    vim.cmd('normal! obreakpoint' )
    vim.cmd('write' )
end, {})
vim.keymap.set('n', '<leader>b', ':GodotBreakpoint<CR>')

-- delete all breakpoints in current file
vim.api.nvim_create_user_command('GodotDeleteBreakpoints', function()
    vim.cmd('g/breakpoint/d')
end, {})
vim.keymap.set('n', '<leader>BD', ':GodotDeleteBreakpoints<CR>')

-- search all breakpoints in project
vim.api.nvim_create_user_command('GodotFindBreakpoints', function()
    vim.cmd(':grep breakpoint | copen')
end, {})
vim.keymap.set('n', '<leader>BF', ':GodotFindBreakpoints<CR>')

-- ----------------------
-- plugins config
-- ----------------------

-- ----------------------
-- NERDTree
-- ----------------------
vim.cmd('let NERDTreeShowHidden=1')
vim.keymap.set('n', '<leader>n', ':NERDTreeFocus<CR>')
vim.keymap.set('n', '<C-n>', ':NERDTree<CR>')
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>')

-- except for godot
vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"NERD_tree_*"},
  command = "execute 'normal R'",
})


-- open NERDTree when opening a directory, not a single file
vim.api.nvim_create_autocmd({"VimEnter"}, {
  pattern = {"*"},
  command = "if !argc() | NERDTree | wincmd p | endif",
})

-- ----------------------
-- oil
-- ----------------------
require("oil").setup({
    default_file_explorer = true,
    delete_to_trash = true,
    -- skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
    },
})
vim.keymap.set('n', '<leader>o', ':Oil<CR>')

-- ----------------------
-- treesitter
-- -- ----------------------
require'nvim-treesitter.configs'.setup {
    ensure_installed = {'gdscript', 'godot_resource', 'gdshader', 'java', 'lua', 'bash', 'xml', 'yaml', 'json', 'go', 'vimdoc'},
    highlight = {
        enable = true,
    },
    auto_install = false,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
}

-- ----------------------
-- lsp
-- ----------------------
local lspconfig = require('lspconfig')

lspconfig.gdscript.setup{}
-- lspconfig.jdtls.setup{}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- create first cache with
-- mkdir .cache/nvim
local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end

-- ----------------------
-- indent-blankline.nvim
-- ----------------------
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }

-- colorizer
require("colorizer").setup()

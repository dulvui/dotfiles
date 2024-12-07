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

Plug('preservim/nerdtree')

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' } )

Plug('stevearc/oil.nvim')

Plug('lukas-reineke/indent-blankline.nvim')
-- lsp and daps
Plug('neovim/nvim-lspconfig')
Plug('mfussenegger/nvim-dap')


Plug('tpope/vim-fugitive')

vim.call('plug#end')

-- ----------------------
-- vim commands
-- ----------------------
vim.cmd('colorscheme solarized')
vim.cmd('set background=light')
vim.cmd('set nowrap')

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
-- visible tabs
-- vim.cmd('set list')


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
-- telescope
-- ----------------------
local builtin = require('telescope.builtin')
-- default
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- custom
vim.keymap.set('n', '<leader>fr', builtin.resume, {})

-- ----------------------
-- treesitter
-- ----------------------
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
-- dap
-- ----------------------
local dap = require('dap')
-- default remaps from help dap-mappings
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
  }
}

dap.configurations.gdresource = {
  {
    type = "godot",
    request = "launch",
    name = "Launch current scene",
    scene = "pinned",
    project = "${workspaceFolder}",
  }
}

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


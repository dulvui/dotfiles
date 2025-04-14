-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ----------------------
-- vim commands
-- ----------------------

-- set path to all files and recursive subdirs, for find command
vim.cmd('set path+=**')
-- ignore godot .uid files in wild menus
vim.cmd('set wildignore+=**.uid')

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
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {'*.gd'},
  command = 'set noexpandtab',
})
-- except for godot
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {'*.gd'},
  command = 'set noexpandtab',
})

-- ----------------------
-- Left padding if only one window is open
-- ----------------------
vim.cmd('set number')
vim.cmd('set relativenumber')
vim.cmd('set numberwidth=4')

local statuscolumn = "                                  %C%s %r "

-- set default
vim.wo.signcolumn = 'yes:1'
vim.wo.foldcolumn = '1'
vim.o.statuscolumn = statuscolumn


-- check window list count and adapt padding
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter', 'BufWinLeave', 'WinEnter', 'WinLeave', 'WinResized', 'VimResized' }, {
  callback = function()
      local list = vim.api.nvim_list_wins()
      -- full size is 191
      local winwidth = vim.api.nvim_win_get_width(0)
      if winwidth > 120 and # list == 1 then
        vim.o.statuscolumn = statuscolumn
      else
        vim.o.statuscolumn = "%C%s %l "
      end
  end,
})


-- ----------------------
--  from https://github.com/nvim-lua/kickstart.nvim
-- ----------------------

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
-- vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10


-- ----------------------
--  vim plug
-- ----------------------

local vim = vim

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('shaunsingh/solarized.nvim')

Plug('tpope/vim-sensible')

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

Plug('stevearc/oil.nvim')

Plug('neovim/nvim-lspconfig')

Plug('norcalli/nvim-colorizer.lua')

vim.call('plug#end')

-- ----------------------
-- Solarized
-- ----------------------
vim.cmd('colorscheme solarized')
vim.cmd('set background=light')
vim.cmd('set nowrap')

-- ----------------------
-- Godot
-- ----------------------

-- paths to check for project.godot file
local paths_to_check = {'/', '/../'}
local is_godot_project = false
local godot_project_path = ''
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
    if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
        is_godot_project = true
        godot_project_path = cwd .. value
        break
    end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. '/server.pipe')
-- start server, if not already running
if is_godot_project and not is_server_running then
    vim.fn.serverstart(godot_project_path .. '/server.pipe')
end

-- ----------------------
-- Godot commands
-- ----------------------
if is_godot_project then
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

    -- append '# TRANSLATORS: ' to current line
    vim.api.nvim_create_user_command('GodotTranslators', function(opts)
        vim.cmd('normal! A # TRANSLATORS: ')
    end, {})
end

-- ----------------------
-- plugins config
-- ----------------------

-- ----------------------
-- oil
-- ----------------------
local oil = require('oil')
oil.setup({
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
            -- for godot projects ignore *.uid files
            if is_godot_project then
                -- ignore *.uid files introduced in godot 4.4
                if vim.endswith(name, '.uid') then
                    return true
                end
                -- ignore server.pipe file
                if name == 'server.pipe' then
                    return true
                end
            else
                return false
            end
        end,
    },
})

-- like vim-vinegar
vim.keymap.set('n', '-', ':Oil<CR>')

-- ----------------------
-- treesitter
-- -- ----------------------
require('nvim-treesitter.configs').setup {
    ensure_installed = {'gdscript', 'godot_resource', 'gdshader', 'lua', 'bash', 'yaml', 'json'},
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    auto_install = false,
}

-- ----------------------
-- lsp
-- ----------------------
local lspconfig = require('lspconfig')

-- godot lsp
if is_godot_project then
    -- setup lsp
    lspconfig.gdscript.setup {}
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


-- colorizer
require('colorizer').setup()


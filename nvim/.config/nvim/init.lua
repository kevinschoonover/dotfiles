-- https://github.com/ThePrimeagen/init.lua
-- https://github.com/nvim-lua/kickstart.nvim

require("plugins")

function is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

-- ref: https://github.com/martinsione/dotfiles/tree/master/src/.config/nvim
--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

-- tab control
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- use system clipboard
-- WSL takes forever to setup the system clipboard
if (vim.fn.hostname() ~= "DESKTOP-M773RCT") then
  vim.opt.clipboard = "unnamedplus"
end

--Save undo history
vim.opt.undofile = true
local undo_dir = vim.fn.stdpath("data") .. "/undo"
if not is_directory(undo_dir) then
  vim.fn.mkdir(undo_dir, "p")
end
vim.opt.backupdir = undo_dir

--Backup files
vim.opt.backup = true
local backup_dir = vim.fn.stdpath("data") .. "/backups"
if not is_directory(backup_dir) then
  vim.fn.mkdir(backup_dir, "p")
end
vim.opt.backupdir = backup_dir

-- gutentags
local tags_path = vim.fn.stdpath("data") .. "/tags"
if not is_directory(tags_path) then
  vim.fn.mkdir(tags_path, "p")
end
vim.g.gutentags_cache_dir = tags_path

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = "yes"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd([[colorscheme onedark]])

--Set statusbar
vim.g.lightline = {
  colorscheme = "onedark",
  active = { left = { { "mode", "paste" }, { "gitbranch", "readonly", "filename", "modified" } } },
  component_function = { gitbranch = "fugitive#head" },
}

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- junmp to last position when reopening the file
vim.cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
]])

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

require("modules.init")
require("filetype")

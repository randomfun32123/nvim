require("gruvbox").setup({
    contrast = "hard",
    transparent_mode = true,
})

-- Basic options
vim.o.termguicolors = true      -- full color support
vim.o.number = true             -- line numbers
vim.o.relativenumber = true     -- relative line numbers
vim.o.cursorline = true         -- highlight current line
vim.o.signcolumn = "yes"        -- always show sign column (prevents layout shift)
vim.o.scrolloff = 8             -- keep 8 lines visible above/below cursor
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true          -- spaces instead of tabs
vim.o.smartindent = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.undofile = true           -- persistent undo across sessions
vim.o.ignorecase = true         -- case insensitive search
vim.o.smartcase = true          -- unless you type a capital
vim.o.updatetime = 250          -- faster completion/gitsigns response

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.mousemoveevent = true;

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins (empty for now, add specs to lua/plugins/ as you go)
require("lazy").setup("plugins")

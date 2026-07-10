-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  git = {
    timeout = 12000,
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 2
vim.opt.mouse = ""
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.hlsearch = true
vim.cmd("syntax on")
vim.opt.compatible = false

vim.cmd("colorscheme gruvbox")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.keymap.set('t', '<M-o>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set('n', '<M-Up>', '<Cmd>resize +2<CR>', { desc = "Increase horizontal window size" })
vim.keymap.set('n', '<M-Down>', '<Cmd>resize -2<CR>', { desc = "Decrease horizontal window size" })
vim.keymap.set('n', '<M-Left>', '<Cmd>vertical resize -5<CR>', { desc = "Decrease vertical window size" })
vim.keymap.set('n', '<M-Right>', '<Cmd>vertical resize +5<CR>', { desc = "Increase vertical window size" })


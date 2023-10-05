local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup({
  spec = {
    {"neovim/nvim-lspconfig"},
    {"tpope/vim-fugitive"},
    {"jacoborus/tender.vim"},
    {"junegunn/fzf"},
    {"junegunn/fzf.vim"},
    {"ntpeters/vim-better-whitespace"},
    {"sdiehl/vim-ormolu"},
    'vim-airline/vim-airline',
    'dense-analysis/ale',
    -- haskell tools doesn't seem to work
    --{"mrcjkb/haskell-tools.nvim",
    --    dependencies = {
    --        "nvim-lua/plenary.nvim"
    --    },
    --    version = "^2",
    --    ft = {"haskell", "lhaskell", "cabal", "cabalproject"},
    --},
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "tender", "tokyonight" } },
  checker = { enabled = true },
})


-- keybindings
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", " ", ":")
-- TODO disable this in special buffers (what does this mean?)
vim.keymap.set("n", "<cr>", ":w<cr>")

-- TODO colourscheme
vim.cmd("colorscheme tender")
-- TODO whitespace eliminator
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitelines_at_eof = 1

-- TODO LSP/ALE/Haskell tools, linters
vim.g.ale_linters_ignore = { haskell = { 'cabal_ghc', 'stack_ghc', 'stack_build', 'ghc', } }
vim.g.ale_floating_preview = 1
vim.g.ale_floating_window_border = {'│', '─', '╭', '╮', '╯', '╰'}
vim.g.ale_haskell_hls_args = {"-dl", "/tmp/hls.out"}
vim.keymap.set('n', '<F1>', ":ALEHover<cr>")

-- fourmolu
vim.g.ormolu_command = "fourmolu"
vim.g.ormolu_options = {"--stdin-input-file", "."}
vim.g.ormolu_suppress_stderr = 1

-- TODO Omnicompletion
-- in/outdenting
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- nohlsearch
vim.keymap.set("n", "<F12>", ":nohlsearch<cr>")
-- TODO incsearch
-- TODO open splits right/below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- TODO telescope
-- TODO treesitter
-- TODO git differ and viewer
-- TODO airline

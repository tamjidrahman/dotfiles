-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", ":TmuxNavigateLeft<cr>", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", ":TmuxNavigateDown<cr>", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", ":TmuxNavigateUp<cr>", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", ":TmuxNavigateRight<cr>", { desc = "Go to Right Window", remap = true })

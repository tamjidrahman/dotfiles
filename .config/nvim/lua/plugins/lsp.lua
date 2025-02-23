return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable this keymap for blink-cmp select previous item
      keys[#keys + 1] = { "<C-k>", false }
    end,
  },
}

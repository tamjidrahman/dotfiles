return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
    "echasnovski/mini.diff",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },
  },
  keys = {
    -- Normal and Visual mode
    {
      "<leader>ca",
      "<cmd>CodeCompanionActions<cr>",
      desc = "Code Companion Actions",
      mode = { "n", "v" },
    },
    {
      "<leader>a",
      "<cmd>CodeCompanionChat Toggle<cr>",
      desc = "Toggle Code Companion Chat",
      mode = { "n", "v" },
    },
    -- Visual mode
    {
      "ga",
      "<cmd>CodeCompanionChat Add<cr>",
      desc = "Add to Code Companion Chat",
      mode = "v",
    },
  },
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  config = function(_, opts)
    require("avante").setup(opts)
    -- Gruvbox background for Avante popups with opacity
    vim.api.nvim_set_hl(0, "AvantePromptInput", { bg = "#282828", blend = 10 })
    vim.api.nvim_set_hl(0, "AvantePromptInputBorder", { fg = "#504945", bg = "#282828", blend = 10 })
    vim.api.nvim_set_hl(0, "AvantePopupHint", { fg = "#d8a657" })
  end,
  opts = {
    provider = "claude",
    behaviour = {
      auto_suggestions = true,
      auto_set_highlight_group = false,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    mappings = {
      ask = "<leader>aa",
      edit = "<leader>ae",
      refresh = "<leader>ar",
    },
    selection = {
      hint_display = "none",
    },
    windows = {
      wrap = true,
      sidebar_header = {
        rounded = false,
      },
      edit = {
        border = "rounded",
      },
      ask = {
        border = "rounded",
      },
    },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

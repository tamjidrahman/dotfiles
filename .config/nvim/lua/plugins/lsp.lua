return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Configure LSP servers
      opts = opts or {}
      opts.servers = opts.servers or {}

      -- Global LSP keymaps configuration (v15 pattern)
      -- Disable <C-k> keymap to free it for blink-cmp select previous item
      opts.servers["*"] = {
        keys = {
          { "<C-k>", false },
        },
      }

      -- Python language servers configuration
      -- Configure Ruff first for linting and formatting
      opts.servers.ruff_lsp = {
        init_options = {
          settings = {
            -- Ruff settings
            lint = {
              run = "onSave",
            },
            fixAll = true,
          },
        },
      }

      -- Pyright for type checking (with reduced diagnostics since Ruff handles linting)
      opts.servers.pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              -- Disable some Pyright diagnostics since Ruff will handle them
              diagnosticSeverityOverrides = {
                reportUnusedImport = "none",
                reportUnusedVariable = "none",
              },
            },
          },
        },
      }

      return opts
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}

      -- Add Python LSP server to ensure_installed
      table.insert(opts.ensure_installed, "pyright")
      table.insert(opts.ensure_installed, "ruff-lsp")

      return opts
    end,
  },
}

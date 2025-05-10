return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.dbs = {
      { name = "cellar-dev", url = "mysql://tamjid.rahman:@127.0.0.1:3307/cellar" },
      { name = "vitesse-stage", url = "mysql://tamjid.rahman:@127.0.0.1:15308" },
      { name = "vitesse-prod", url = "mysql://tamjid.rahman:@127.0.0.1:15309" },
      { name = "cellar-merlot-stage", url = "mysql://tamjid.rahman:@127.0.0.1:3338/cellar" },
      { name = "cellar-chardonnay-stage", url = "mysql://tamjid.rahman:@127.0.0.1:3328/cellar" },
      { name = "cellar-malbec-prod", url = "mysql://tamjid.rahman:@127.0.0.1:3329/cellar" },
      { name = "cellar-riesling-prod", url = "mysql://tamjid.rahman:@127.0.0.1:3339/cellar" },
    }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbout",
      callback = function()
        vim.wo.foldenable = false
      end,
    })
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>db", "<cmd>DBUIToggle<cr>", { desc = "Toggle DBUI" })
  end,
}

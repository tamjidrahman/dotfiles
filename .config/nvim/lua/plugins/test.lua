return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  config = function()
    vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>")
    vim.keymap.set("n", "<leader>tf", ":TestFile<CR>")
    vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>")
    vim.keymap.set("n", "<leader>tl", ":TestLast<CR>")
    vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>")
    vim.cmd("let test#strategy = 'vimux'")

    local current_dir = vim.fn.getcwd()
    if string.match(current_dir, "front%-porch") then
      vim.cmd([[
				let test#python#pytest#executable = 'peach'
				let test#python#pytest#options = 'test -t'
			]])
    end
  end,
}

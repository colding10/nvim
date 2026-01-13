local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>lsp", function()
    require("lspmenu.lspmenu").open()
  end, { desc = "Open LSP Menu" })

  vim.api.nvim_create_user_command("LspMenu", function()
    require("lspmenu.lspmenu").open()
  end, { desc = "Open LSP Telescope menu" })
end


return M

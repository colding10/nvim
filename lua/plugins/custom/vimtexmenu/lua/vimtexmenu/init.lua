-- vimtexmenu/lua/vimtexmenu/init.lua
local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>tex", function()
    require("vimtexmenu.vimtexmenu").open()
  end, { desc = "VimTeX menu" })

  vim.api.nvim_create_user_command("VimtexMenu", function()
    require("vimtexmenu.vimtexmenu").open()
  end, { desc = "Open Telescope VimTeX menu" })
end

return M

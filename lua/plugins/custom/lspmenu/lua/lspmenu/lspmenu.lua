local M = {}

function M.open()
  local builtin = require("telescope.builtin")
  local actions = {
    { name = "Rename Symbol", func = vim.lsp.buf.rename },
    { name = "Code Action", func = vim.lsp.buf.code_action },
    { name = "Hover Docs", func = vim.lsp.buf.hover },
    { name = "Go to Definition", func = builtin.lsp_definitions },
    { name = "Find References", func = builtin.lsp_references },
    { name = "Implementations", func = builtin.lsp_implementations },
    { name = "Type Definitions", func = builtin.lsp_type_definitions },
    { name = "Diagnostics", func = function() vim.diagnostic.open_float() end },
    { name = "Format Buffer", func = function() vim.lsp.buf.format({ async = true }) end },
  }

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions_state = require("telescope.actions.state")
  local actions_t = require("telescope.actions")

  pickers.new({}, {
    prompt_title = "LSP Actions",
    finder = finders.new_table {
      results = actions,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(_, map)
      local function run_action(bufnr)
        local selection = actions_state.get_selected_entry()
        actions_t.close(bufnr)
        selection.value.func()
      end
      map("i", "<CR>", run_action)
      map("n", "<CR>", run_action)
      return true
    end,
  }):find()
end

return M

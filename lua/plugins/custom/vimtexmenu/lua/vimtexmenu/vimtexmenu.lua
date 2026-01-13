-- vimtexmenu/lua/vimtexmenu/vimtexmenu.lua
local M = {}

local ok, pickers = pcall(require, "telescope.pickers")
if not ok then
  return M
end
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions_state = require("telescope.actions.state")
local telescope_actions = require("telescope.actions")

local function cmd_exists(name)
  return vim.fn.exists(":" .. name) == 2
end

local function make_actions()
  local a = {}

  if cmd_exists("VimtexCompile") then
    table.insert(a, { name = "Compile (VimtexCompile)", cmd = "VimtexCompile" })
  end
  if cmd_exists("VimtexStop") then
    table.insert(a, { name = "Stop Compile (VimtexStop)", cmd = "VimtexStop" })
  end
  if cmd_exists("VimtexView") then
    table.insert(a, { name = "View (VimtexView)", cmd = "VimtexView" })
  end
  if cmd_exists("VimtexClean") then
    table.insert(a, { name = "Clean Aux Files (VimtexClean)", cmd = "VimtexClean" })
  end
  if cmd_exists("VimtexTocOpen") then
    table.insert(a, { name = "Open TOC (VimtexTocOpen)", cmd = "VimtexTocOpen" })
  elseif cmd_exists("VimtexTocToggle") then
    table.insert(a, { name = "Toggle TOC (VimtexTocToggle)", cmd = "VimtexTocToggle" })
  end
  if cmd_exists("VimtexErrors") then
    table.insert(a, { name = "Show Errors (VimtexErrors)", cmd = "VimtexErrors" })
  end
  if cmd_exists("VimtexReload") then
    table.insert(a, { name = "Reload (VimtexReload)", cmd = "VimtexReload" })
  end

  -- always useful
  table.insert(a, { name = "Open quickfix (copen)", cmd = "copen" })

  return a
end

local function run_cmd(cmd)
  vim.cmd(cmd)
end

function M.open()
  local items = make_actions()
  if #items == 0 then
    vim.notify("No VimTeX commands detected in runtime", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "VimTeX Actions",
    finder = finders.new_table {
      results = items,
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
      local function do_action(prompt_bufnr)
        local selection = actions_state.get_selected_entry()
        telescope_actions.close(prompt_bufnr)
        if selection and selection.value and selection.value.cmd then
          run_cmd(selection.value.cmd)
        end
      end
      map("i", "<CR>", do_action)
      map("n", "<CR>", do_action)
      return true
    end,
  }):find()
end

return M

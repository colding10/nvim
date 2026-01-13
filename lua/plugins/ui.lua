return {
    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = {
                    normal = {
                        a = { fg = "#000000", bg = "#76946a" },
                        b = { fg = "#dcd7ba", bg = "#1a1a1a" },
                        c = { fg = "#dcd7ba", bg = "#111111" },
                    },
                    insert = { a = { fg = "#000000", bg = "#7e9cd8" } },
                    visual = { a = { fg = "#000000", bg = "#957fb8" } },
                    replace = { a = { fg = "#000000", bg = "#e46876" } },
                    command = { a = { fg = "#000000", bg = "#e6c384" } },
                    inactive = {
                        a = { fg = "#727169", bg = "#000000" },
                        b = { fg = "#727169", bg = "#000000" },
                        c = { fg = "#727169", bg = "#000000" },
                    },
                },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { { "mode", icon = "" } },
                lualine_b = { { "filename", path = 1 } },
                lualine_c = { { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " } } },
                lualine_x = {
                    { "branch", icon = "" },
                    {
                        function()
                            local clients = vim.lsp.get_clients({ bufnr = 0 })
                            if #clients == 0 then
                                return ""
                            end
                            local names = {}
                            for _, client in ipairs(clients) do
                                table.insert(names, client.name)
                            end
                            return " " .. table.concat(names, ", ")
                        end,
                    },
                },
                lualine_y = { "filetype" },
                lualine_z = {
                    function()
                        local line = vim.fn.line(".")
                        local col = vim.fn.col(".")
                        return "󰦨 " .. line .. ":" .. col
                    end,
                },
            },
        },
    },

    -- Bufferline (tabs)
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                mode = "buffers",
                always_show_bufferline = false,
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true,
                    },
                },
                show_buffer_close_icons = false,
                show_close_icon = false,
                indicator = { style = "underline" },
                separator_style = "thin",
            },
            highlights = {
                buffer_selected = {
                    italic = false,
                    bold = false,
                },
                diagnostic_selected = {
                    italic = false,
                },
                hint_selected = {
                    italic = false,
                },
                pick_selected = {
                    italic = false,
                },
                pick_visible = {
                    italic = false,
                },
                pick = {
                    italic = false,
                },
            },
        },
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        keys = {
            { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
            { "<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "Focus file tree" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            filters = { dotfiles = false },
            disable_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                width = 30,
                preserve_window_proportions = true,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                indent_markers = { enable = true },
                icons = {
                    glyphs = {
                        default = "󰈚",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                        },
                        git = { unmerged = "" },
                    },
                },
            },
        },
    },

    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>c", group = "code" },
                { "<leader>f", group = "find" },
                { "<leader>g", group = "git" },
                { "<leader>S", group = "session" },
            })
        end,
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = { char = "│" },
            scope = { enabled = true },
        },
    },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
}

return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                compile = false,
                undercurl = true,
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = {},
                statementStyle = {},
                typeStyle = {},
                transparent = false,
                dimInactive = false,
                terminalColors = true,
                colors = {
                    palette = {
                        -- Darker end (backgrounds)
                        sumiInk0 = "#000000",  -- main editor background
                        sumiInk1 = "#080808",  -- subtle bg variation
                        sumiInk2 = "#121212",  -- floats, popups
                        sumiInk3 = "#181818",  -- cursorline, subtle UI
                        sumiInk4 = "#1e1e1e",  -- statusline bg
                        sumiInk5 = "#252525",  -- visual selection
                        sumiInk6 = "#2e2e2e",  -- lighter UI elements
                        -- Foreground adjustments
                        fujiWhite = "#c5c9c5", -- slightly muted white
                    },
                    theme = {
                        dragon = {
                            ui = {
                                bg = "#000000",
                                bg_gutter = "none",
                            },
                        },
                    },
                },
                overrides = function(colors)
                    local p = colors.palette
                    return {
                        -- Core backgrounds
                        Normal = { bg = "#000000" },
                        NormalNC = { bg = "#000000" },
                        NormalFloat = { bg = "#121212" },
                        SignColumn = { bg = "#000000" },
                        EndOfBuffer = { bg = "#000000", fg = "#000000" },
                        MsgArea = { bg = "#000000" },

                        -- Cursor and selection
                        CursorLine = { bg = "#0c0c0c" },
                        CursorLineNr = { fg = p.roninYellow, bg = "#000000", bold = false },
                        LineNr = { fg = "#3a3a3a", bg = "#000000" },
                        Visual = { bg = "#252525" },

                        -- Window chrome
                        StatusLine = { bg = "#101010", fg = p.fujiWhite },
                        StatusLineNC = { bg = "#080808", fg = "#505050" },
                        WinSeparator = { fg = "#1e1e1e", bg = "#000000" },
                        VertSplit = { fg = "#1e1e1e", bg = "#000000" },

                        -- Search
                        Search = { bg = "#2d4f67", fg = p.fujiWhite },
                        IncSearch = { bg = p.roninYellow, fg = "#000000" },
                        CurSearch = { bg = p.roninYellow, fg = "#000000" },

                        -- Floats and borders
                        FloatBorder = { bg = "#121212", fg = "#505050" },
                        FloatTitle = { bg = "#121212", fg = p.dragonBlue, bold = true },

                        -- Completion menu (standard)
                        Pmenu = { bg = "#121212" },
                        PmenuSel = { bg = "#2d4f67", fg = p.fujiWhite },
                        PmenuSbar = { bg = "#181818" },
                        PmenuThumb = { bg = "#3a3a3a" },

                        -- nvim-cmp custom highlights
                        CmpPmenu = { bg = "#121212" },
                        CmpSel = { bg = "#2d4f67", fg = p.fujiWhite },
                        CmpDoc = { bg = "#121212" },

                        -- Markup (keep emphasis)
                        ["@markup.heading"] = { bold = true, underline = true },
                        ["@markup.strong"] = { bold = true },
                        ["@markup.italic"] = { italic = true },
                        ["@markup.underline"] = { underline = true },
                        Title = { bold = true },

                        -- Remove bold from code elements
                        Constant = { bold = false },
                        Operator = { bold = false },
                        ["@operator"] = { bold = false },
                        ["@keyword.operator"] = { bold = false },
                        Boolean = { bold = false },
                        Number = { bold = false },
                    }
                end,
                theme = "dragon",
            })
            vim.cmd.colorscheme("kanagawa-dragon")
        end,
    },
}

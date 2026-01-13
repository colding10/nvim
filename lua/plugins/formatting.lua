return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = { "ConformInfo" },
        opts = {
            formatters_by_ft = {
                lua = { "stylua", lsp_format = "prefer" },
                css = { "prettier" },
                html = { "prettier" },
                cpp = { "clang-format" },
                tex = { lsp_format = "prefer" },
                python = { "isort", "black" },
                markdown = { "mdformat" },
                typst = { "typstyle" },
                ["_"] = { "trim_whitespace" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
    },
}

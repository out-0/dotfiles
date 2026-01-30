return {
  -- Mason for managing LSPs
  {
    --"williamboman/mason.nvim",
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",    -- C/C++
        "lua-language-server",
        "bash-language-server",
        "python-lsp-server",
        "flakeheaven",
        "pyright",
        "ruff",
        --"pyment"
      },
    },
  },
}

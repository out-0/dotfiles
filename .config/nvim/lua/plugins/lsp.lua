return {
  -- Mason for managing LSPs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",    -- C/C++
        "pyright",   -- Python
        "lua-language-server",
        "bash-language-server",
      },
    },
  },
}

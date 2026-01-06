return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add your languages to the existing list
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
    end
  end,
}

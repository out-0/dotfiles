return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    -- This keeps the standard LazyVim behavior (C-n and C-p)
    -- but allows you to add your custom sources
    local cmp = require("cmp")
    
    -- Ensure emoji is in the list of sources
    table.insert(opts.sources, { name = "emoji" })
    
    -- We leave opts.mapping ALONE so the defaults work perfectly
  end,
}

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, colors)
        hl.WinSeparator = { fg = colors.blue }
      end,
    },
  },
}


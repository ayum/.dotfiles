---@type LazySpec
return {
  {
    "folke/which-key.nvim",
    opts = {
      ---@param mapping wk.Mapping|wk.Keymap
      filter = function(mapping)
        -- config.ru_layout mirrors every mapping into the Russian layout, so which-key sees each
        -- command twice: once under the Latin keys and once under the Russian ones. Only the Latin
        -- spelling is worth showing -- the menu exists to describe commands, and the Russian keys
        -- are just how the terminal spells them.
        --
        -- The mirror is filtered here rather than hidden with `desc = "which_key_ignore"` because
        -- which-key builds prefix nodes and triggers from the raw byte sequences of the Alt/Ctrl
        -- forms (`ESC`+char, `CSI <codepoint> ; 3 u`), which would survive as Russian entries under
        -- `<Esc>` and `<Space>`.
        local lhs = type(mapping.lhs) == "string" and mapping.lhs or ""
        return not lhs:match("[\128-\255]")
      end,
    },
  },
}

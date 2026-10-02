return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- LazyVim maps `K` to LSP hover on LspAttach (applied via snacks in `vim.schedule`,
            -- which runs after `config/keymaps.lua`). Appending our own `K` last makes the scroll
            -- mapping win; hover stays on `<leader>K`.
            { "K", "<C-u>", desc = "Scroll Half Page Up" },
          },
        },
      },
    },
  },
}
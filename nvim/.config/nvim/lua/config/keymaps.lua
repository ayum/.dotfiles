-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Normal-mode H/J/K/L
vim.keymap.set("n", "H", "^", { desc = "Go to Start of Line" })
vim.keymap.set("n", "J", "<C-d>", { desc = "Scroll Half Page Down" })
vim.keymap.set("n", "K", "<C-u>", { desc = "Scroll Half Page Up" })
vim.keymap.set("n", "L", "$", { desc = "Go to End of Line" })

-- Keep scroll-half-page on K even in LSP buffers (overrides buffer-local hover)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserKeymapsLsp", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "K", "<C-u>", { buffer = args.buf, desc = "Scroll Half Page Up" })
  end,
})

-- Relocations
vim.keymap.set("n", "<leader>J", "J", { desc = "Join Lines" })
vim.keymap.set("n", "<leader>K", function()
  if next(vim.lsp.get_clients({ bufnr = 0 })) then
    vim.lsp.buf.hover()
  else
    vim.cmd("normal! K")
  end
end, { desc = "Hover / Keywordprg" })

-- Alt+arrows in n/i/s/o/c/t and h/l in visual
for _, mode in ipairs({ "n", "i", "s", "o", "c", "t" }) do
  vim.keymap.set(mode, "<M-h>", "<Left>", { desc = "Left" })
  vim.keymap.set(mode, "<M-j>", "<Down>", { desc = "Down" })
  vim.keymap.set(mode, "<M-k>", "<Up>", { desc = "Up" })
  vim.keymap.set(mode, "<M-l>", "<Right>", { desc = "Right" })
end
for _, mode in ipairs({ "v", "x" }) do
  vim.keymap.set(mode, "<M-h>", "<Left>", { desc = "Left" })
  vim.keymap.set(mode, "<M-l>", "<Right>", { desc = "Right" })
end

-- Alt+HJKL in n/v/x/s/o
for _, mode in ipairs({ "n", "v", "x", "s", "o" }) do
  vim.keymap.set(mode, "<M-H>", "^", { desc = "Go to Start of Line" })
  vim.keymap.set(mode, "<M-J>", "<C-d>", { desc = "Scroll Half Page Down" })
  vim.keymap.set(mode, "<M-K>", "<C-u>", { desc = "Scroll Half Page Up" })
  vim.keymap.set(mode, "<M-L>", "$", { desc = "Go to End of Line" })
end

-- Alt+HJKL in insert
vim.keymap.set("i", "<M-H>", "<Home>", { desc = "Go to Start of Line" })
vim.keymap.set("i", "<M-L>", "<End>", { desc = "Go to End of Line" })
vim.keymap.set("i", "<M-J>", "<C-o><C-d>", { desc = "Scroll Half Page Down" })
vim.keymap.set("i", "<M-K>", "<C-o><C-u>", { desc = "Scroll Half Page Up" })

-- Alt+HJKL in cmdline
vim.keymap.set("c", "<M-H>", "<C-b>", { desc = "Command Line Beginning" })
vim.keymap.set("c", "<M-L>", "<C-e>", { desc = "Command Line End" })

-- Alt+HJKL in terminal
vim.keymap.set("t", "<M-H>", "<Home>", { desc = "Home" })
vim.keymap.set("t", "<M-L>", "<End>", { desc = "End" })
vim.keymap.set("t", "<M-J>", "<PageDown>", { desc = "Page Down" })
vim.keymap.set("t", "<M-K>", "<PageUp>", { desc = "Page Up" })

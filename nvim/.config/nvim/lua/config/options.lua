-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.fillchars = {
  vert = "│", -- Vertical split bar
  horiz = "─", -- Horizontal split bar
  horizup = "┴", -- Horizontal split intersecting a vertical split from above
  horizdown = "┬", -- Horizontal split intersecting a vertical split from below
  vertleft = "┤", -- Vertical split intersecting a horizontal split from the left
  vertright = "├", -- Vertical split intersecting a horizontal split from the right
  verthoriz = "┼", -- The exact cross-intersection point where 4 splits meet
}

vim.opt.spelllang = { "en", "ru" }

vim.opt.tabstop = 4      -- Табуляция равна 4 пробелам
vim.opt.shiftwidth = 4   -- Размер автоматического отступа равен 4 пробелам
vim.opt.softtabstop = 4  -- Нажатие Tab в режиме вставки добавляет 4 пробела

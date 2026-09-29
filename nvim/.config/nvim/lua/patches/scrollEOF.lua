--- Local patches for third-party plugins, applied by lazy.nvim's `build` hook right after the
--- plugin is installed (see ../plugins/scrollEOF.lua for the spec that uses this).
---
--- The patched plugin stays a normal lazy.nvim/git plugin, so it keeps its entry in lazy-lock.json
--- and stays visible in `:Lazy`, but two caveats come with it:
---
---   1. `:Lazy update` (and `:Lazy restore`, same pipeline) aborts on a plugin whose worktree is
---      dirty -- it runs `git ls-files -d -m` and errors with "You have local changes ...". This
---      patch is a local change by design, so updating scrollEOF.nvim takes three steps:
---
---        cd ~/.local/share/nvim/lazy/scrollEOF.nvim && git checkout -- .   -- drop the patch
---        :Lazy update                                                        -- now allowed
---        :Lazy build                                                         -- re-apply it
---
---      Verified working end to end. Deleting the plugin and installing it again also works, since
---      that re-clones and re-runs `build`.
---   2. Because of that, the patch must fail loudly if upstream changes the block below. A silently
---      unapplied patch would bring the bug back, so we `error()` instead.

local M = {}

local MARKER = "-- [scrollEOF.nvim local patch]"
local FILE = "lua/scrollEOF.lua"

--- Block to replace, verbatim from e462b9a (the commit pinned in lazy-lock.json).
local NEEDLE = [[  if visual_distance_to_eof < scrolloff then
    local win_view = vim.fn.winsaveview()
    vim.fn.winrestview({
      skipcol = 0, -- Without this, `gg` `G` can cause the cursor position to be shown incorrectly
      topline = win_view.topline + scrolloff - visual_distance_to_eof,
    })
  end]]

--- Replacement; ../plugins/scrollEOF.lua explains why each part is needed.
local REPLACEMENT = [[-- [scrollEOF.nvim local patch] applied by lazy.nvim's `build` hook; do not edit by hand,
-- see ~/.config/nvim/lua/plugins/scrollEOF.lua
  -- Only bother when the last line of the buffer is actually on screen. This
  -- is the case the plugin exists for: at the end of the file Neovim cannot
  -- keep 'scrolloff' context because there are no lines left below. Anywhere
  -- else 'scrolloff' already does the right thing, and the extra scroll this
  -- plugin performs there is not just useless but actively harmful: it runs
  -- from CursorMoved/WinScrolled, i.e. in the middle of whatever else is
  -- driving the view. With animated scrolling (snacks.animate drives the view
  -- and the cursor with `keepjumps normal! {count}<C-e>{row}H{col}|`) the
  -- interleaved winrestview() corrupts the animation, which then scrolls past
  -- the target and leaves the cursor pinned to the window edge at column 1.
  --
  -- Upstream had this guard before commit 345deec ("use screen line APIs to
  -- work with wrapped lines, fixes #3") and dropped it in the rewrite.
  if visual_distance_to_eof < scrolloff and vim.fn.line('w$') >= vim.fn.line('$') then
    local cursor_lnum = vim.api.nvim_win_get_cursor(0)[1]

    -- Scroll one buffer line at a time until the cursor has `scrolloff` screen
    -- rows below it again, and never further than the cursor's own line: a view
    -- that starts past the cursor hides it, and Neovim then clamps the cursor
    -- back into the window at column 1. Iterating over buffer lines (instead of
    -- adding the screen-row distance straight to `topline`) is what keeps the
    -- two units apart with 'wrap' on, where one buffer line can span many
    -- screen rows. Each step is re-measured with winline() because how many
    -- screen rows a line actually costs depends on where it was cut off.
    --
    -- At most `win_height` steps: every step moves the cursor up by at least
    -- one screen row, so that is always enough to reach the goal.
    for _ = 1, win_height do
      local topline = vim.fn.winsaveview().topline
      if win_height - vim.fn.winline() >= scrolloff or topline >= cursor_lnum then
        break
      end
      vim.fn.winrestview({
        skipcol = 0, -- Without this, `gg` `G` can cause the cursor position to be shown incorrectly
        topline = topline + 1,
      })
    end
  end]]

--- @param plugin LazyPlugin
function M.scrollEOF(plugin)
  local path = plugin.dir .. "/" .. FILE
  local src = table.concat(vim.fn.readfile(path), "\n")
  if src == "" then
    error("scrollEOF patch: " .. path .. " is missing or empty")
  end

  if src:find(MARKER, 1, true) then
    return -- already patched, e.g. on `:Lazy build` or when the spec is reloaded
  end

  local patched, n = src:gsub(vim.pesc(NEEDLE), (REPLACEMENT:gsub("%%", "%%%%")), 1)
  if n ~= 1 then
    error("scrollEOF patch did not apply to " .. path .. ": upstream no longer contains the\n"
      .. "expected block. The scrolloff/search bug is back until this patch is updated\n"
      .. "(see lua/plugins/scrollEOF.lua) or the plugin is reinstalled with `:Lazy restore`.")
  end

  vim.fn.writefile(vim.split(patched, "\n"), path)
end

return M

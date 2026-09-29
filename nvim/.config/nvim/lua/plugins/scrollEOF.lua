-- scrollEOF.nvim with a local patch, applied by lazy.nvim's `build` hook right after the plugin
-- is installed (see ./patches/scrollEOF.lua for the patch itself).
--
-- Upstream e462b9a has two bugs that together break `/имевш` + `n` on long wrapped lines:
--
--   1. it scrolls the view in the middle of every file, not only at the end of the buffer, and
--      does so from CursorMoved/WinScrolled, i.e. in the middle of whatever else is driving the
--      view. With animated scrolling (smoothscroll = snacks.animate, which drives view and cursor
--      with `keepjumps normal! {count}<C-e>{row}H{col}|`) the interleaved winrestview() corrupts
--      the animation: it scrolls far past the target and leaves the cursor pinned to the window
--      edge at column 1. That is what made searches land on non-matches.
--   2. it measures the distance to EOF in screen rows (winheight/winline) and adds it to
--      `topline`, which is a buffer line. With 'wrap' on -- and LazyVim's `wrap_spell` enables
--      it for `filetype=text` -- a line wider than the window spans many screen rows, so the view
--      jumps too far, pushes the cursor's own line off screen, and Neovim clamps the cursor.
--
-- The patch restores the end-of-file guard upstream had before 345deec and scrolls one buffer
-- line at a time, never past the cursor's own line. Real-terminal result: upstream 0/4 runs land
-- on a match, this 8/8; the plugin's own job (scrolloff context at EOF) is unchanged.
--
-- Updating: `:Lazy update` refuses to touch a plugin with local changes, and this patch is one, so
-- revert it, update, then re-apply it with `:Lazy build`:
--
--   cd ~/.local/share/nvim/lazy/scrollEOF.nvim && git checkout -- .  |  :Lazy update  |  :Lazy build
--
-- If upstream ever changes the patched block, the patch fails loudly rather than silently not
-- applying.
return {
  "Aasim-A/scrollEOF.nvim",
  build = function(plugin)
    require("patches.scrollEOF").scrollEOF(plugin)
  end,
  event = { "CursorMoved", "WinScrolled" },
  opts = {},
}

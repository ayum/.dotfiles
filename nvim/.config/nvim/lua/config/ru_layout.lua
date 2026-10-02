--- ЙЦУКЕН -> US key translation, so keymaps keep working while the terminal is in Russian.
---
--- The terminal sends the character the physical key produces, so with a Russian layout `j` arrives as
--- `о`, `gg` as `пп` and `<leader>ff` as ` аа`. Three mechanisms cover that:
---
--- 1. Per-key translation, for everything Neovim handles itself: `о` -> `j`, `ж` -> `;`, `х` -> `[`.
---    Insert mode is left alone, so typing Russian text keeps working.
--- 2. Whole-sequence mapping for the builtin commands a prefix key starts, see `SEQUENCES`.
--- 3. Mirroring the mapping table, for plugin and user mappings. This is not optional: Neovim looks a
---    whole multi-key sequence up at once, so ` аа` is one lookup of three characters and there is
---    never a single `а` mapping in between to apply. Mirroring reads every registered mapping and
---    registers the same one under the keys the Russian layout produces.
---
--- Deliberately not translated:
---   * the command line: `:` and `/` are commands, but what you type into them is usually Russian
---     (`/имевш`), and translating that would break every search. Ex commands need an English
---     layout, or one of the `<leader>` mappings;
---   * the character argument of `f`, `t`, `r`, `m`, `` ` `` and `'`. Neovim reads that argument
---     without applying mappings, so `fс` looks for the Cyrillic `с` rather than the Latin `c`, and
---     `rс` replaces with `с`. Translating it would take the other trade: every `f`/`t` would find
---     Latin characters, and finding Cyrillic text inside a buffer would be impossible (`/имевш`
---     keeps working either way, the command line is not translated);
---   * terminal mode, which is left to the shell;
---   * mappings that start with Ctrl/Alt, see `add_modified` below.
---
--- Disable it with `let g:ru_layout = 0` before Neovim starts.

local M = {}

--- Physical keys: US on the left, what the key produces in ЙЦУКЕН on the right.
---
--- The first row is the grave key, the one left of `1`: on a Russian keyboard it is the dedicated
--- `ё` key. ЙЦУКЕН puts `ё`/`Ё` there and nothing anywhere else, so this is the only key in the
--- layout that has no US letter of its own -- the grave key is simply what that key is on a US
--- keyboard, hence `ё` -> `` ` `` and `Ё` -> `~`.
local ROWS = {
  { "`~", "ёЁ" },
  { "qwertyuiop[]", "йцукенгшщзхъ" },
  { "asdfghjkl;'", "фывапролджэ" },
  { "zxcvbnm,./", "ячсмитьбю." },
  { "QWERTYUIOP{}|", "ЙЦУКЕНГШЩЗХЪ/" },
  { 'ASDFGHJKL:"', "ФЫВАПРОЛДЖЭ" },
  { "ZXCVBNM<>?", "ЯЧСМИТЬБЮ," },
}

--- Modes where a keystroke is a command, so the physical key has to keep its US meaning.
local MODES = { "n", "v", "x", "s", "o" }

--- Builtin commands that start with a prefix key instead of an operator.
---
--- Per-key translation is enough for `dd` and `cc`: an operator reads its motion through the mapping
--- system, so `вв` becomes `dd` on its own. A prefix command is different -- once `g` is on screen,
--- `nv_g_cmd` reads the next key *without* applying mappings, so the second `п` arrives as a literal
--- `п`, `gg` never happens and Neovim reports an unknown command. The same applies to `z`, `[`, `]`,
--- `` ` ``, `@` and `q`. Those sequences therefore have to be registered as whole mappings.
---
--- Only builtins that really are prefix commands belong here, and only the ones in common use: the
--- mirror below covers plugin sequences, and the longest match still wins, so a plugin mapping for
--- `gg0` or `zc` can be registered later and takes precedence over these.
local SEQUENCES = {
  "g?",
  "g0",
  "g$",
  "g;",
  "g:",
  "ga",
  "ge",
  "gg",
  "gi",
  "gI",
  "gj",
  "gk",
  "go",
  "gO",
  "gH",
  "gL",
  "gm",
  "gu",
  "gU",
  "g~",
  "guu",
  "gUU",
  "g~~",
  "za",
  "zA",
  "zc",
  "zd",
  "zf",
  "zi",
  "zm",
  "zo",
  "zO",
  "zR",
  "zM",
  "zz",
  "z=",
  "[[",
  "[]",
  "[{",
  "[}",
  "[(",
  "[)",
  "]]",
  "][",
  "]{",
  "}]",
  "](",
  "])",
  "]p",
  "]P",
  "q:",
  "q/",
  "q?",
  "@:",
  "@/",
}

--- What the Russian layout produces -> the US key it sits on.
local RU_TO_US = {}

--- The US key -> what the Russian layout produces for it, i.e. the reverse direction, used to
--- rewrite a key sequence into the one the terminal sends.
local US_TO_RU = {}

--- Splits a string into UTF-8 characters, so ЙЦУКЕН pairs up with the US row by character instead of
--- by byte (a byte-wise `sub(i, i)` yields a lone lead byte, not the letter).
--- @param s string
--- @return string[]
local function chars(s)
  local out = {}
  local i = 1
  while i <= #s do
    local b = s:byte(i)
    local len = b < 0x80 and 1 or b < 0xE0 and 2 or b < 0xF0 and 3 or 4
    out[#out + 1] = s:sub(i, i + len - 1)
    i = i + len
  end
  return out
end

--- @param modes string[]
--- @param lhs string
--- @param rhs string
local function map(modes, lhs, rhs)
  -- No `desc`: which-key only lists mappings that have one, which keeps these out of the way.
  vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true })
end

--- Modified keys have to be registered as the exact bytes a terminal sends, not as `<M-ь>`
--- notation: Neovim only reads that notation as a keycode when the character behind it is a single
--- byte, so for a Cyrillic letter it would store the mapping as literal text nothing ever matches.
---
--- Alt arrives either as `ESC` + character, or with the kitty keyboard protocol as
--- `CSI <codepoint> ; 3 u`. Ctrl has no byte for a Cyrillic letter at all, so it only ever arrives
--- in the protocol form, as `CSI <codepoint> ; 5 u`.
--- @param ru string
--- @param us string
local function add_modified(ru, us)
  local codepoint = vim.fn.char2nr(ru)

  map(MODES, "\27" .. ru, "\27" .. us)
  map(MODES, string.format("\27[%d;3u", codepoint), "\27" .. us)
  map(MODES, string.format("\27[%d;5u", codepoint), string.char(us:byte(1) % 32))

  map({ "i", "c" }, "\27" .. ru, "\27" .. us)
  map({ "i", "c" }, string.format("\27[%d;3u", codepoint), "\27" .. us)
end

--- @param us string
--- @param ru string
local function add(us, ru)
  if us == ru or ru == "" then
    return
  end

  RU_TO_US[ru] = us
  US_TO_RU[us] = ru
  map(MODES, ru, us)

  if us:match("[a-zA-Z]") then
    add_modified(ru, us)
  end
end

--- Rewrites the printable ASCII of a key sequence into what the Russian layout produces. Special key
--- names are copied over untouched: translating the `c` of `<Esc>` would produce `<Esс>`, which is
--- not a key at all.
--- @param lhs string
--- @return string
local function translate(lhs)
  local out = {}
  local i = 1
  while i <= #lhs do
    local byte = lhs:byte(i)
    if lhs:sub(i, i) == "<" then
      local close = lhs:find(">", i + 1, true)
      if close then
        out[#out + 1] = lhs:sub(i, close)
        i = close + 1
      else
        out[#out + 1] = "<"
        i = i + 1
      end
    else
      local char = lhs:sub(i, i)
      out[#out + 1] = byte >= 0x20 and byte < 0x7F and US_TO_RU[char] or char
      i = i + 1
    end
  end
  return table.concat(out)
end

--- @param bufnr number|nil
--- @return boolean
local function buf_mapped(bufnr, mode, lhs)
  for _, km in ipairs(vim.api.nvim_buf_get_keymap(bufnr, mode)) do
    if km.lhs == lhs then
      return true
    end
  end
  return false
end

--- Registers the mapping of every keymap already in the table under its Russian-layout equivalent.
--- @param mode string
--- @param bufnr number|nil buffer to scan for buffer-local mappings, global mappings when nil
local function mirror(mode, bufnr)
  local keymaps = bufnr and vim.api.nvim_buf_get_keymap(bufnr, mode) or vim.api.nvim_get_keymap(mode)

  for _, km in ipairs(keymaps) do
    local lhs = km.lhs
    local rhs = km.callback or km.rhs
    if lhs and rhs then
      local translated = translate(lhs)
      local first = lhs:byte(1)
      -- Only sequences that open with a printable ASCII key: a control byte in front means it is a
      -- Ctrl/Alt sequence, which `add_modified` covers, and translating it would be guesswork.
      -- Anything already mapped is left alone, so a mirrored sequence never overwrites the simpler
      -- per-key translation or another plugin's own Cyrillic mapping.
      --
      -- `mapcheck` is deliberately not part of this test: which-key registers a catch-all trigger
      -- mapping that it reports for almost any sequence, which made the mirror pass depend on
      -- whether which-key happened to be registered already.
      if
        translated ~= lhs
        and first
        and first >= 0x20
        and first < 0x7F
        and vim.fn.maparg(translated, mode) == ""
        and (not bufnr or bufnr < 1 or not buf_mapped(bufnr, mode, translated))
      then
        local opts = { noremap = km.noremap ~= 0, silent = true, expr = km.expr == 1 }
        if km.nowait == 1 then
          opts.nowait = true
        end
        if bufnr and bufnr > 0 then
          opts.buffer = bufnr
        elseif km.buffer and km.buffer > 0 then
          opts.buffer = km.buffer
        end
        pcall(vim.keymap.set, mode, translated, rhs, opts)
      end
    end
  end
end

--- @private
--- @param bufnr number|nil buffer to also scan for buffer-local mappings, global ones only when nil
function M.mirror(bufnr)
  for _, mode in ipairs(MODES) do
    mirror(mode, bufnr)
  end
end

function M.setup()
  if vim.g.ru_layout == 0 then
    return
  end

  for _, row in ipairs(ROWS) do
    local us_chars = chars(row[1])
    for i, ru_char in ipairs(chars(row[2])) do
      add(us_chars[i] or "", ru_char)
    end
  end

  -- `US_TO_RU` is filled in by the loop above, so this has to come after it.
  for _, us in ipairs(SEQUENCES) do
    local ru = translate(us)
    if ru ~= us then
      map(MODES, ru, us)
    end
  end

  -- Plugin keymaps exist by the time the user config is sourced, but LazyVim registers its own while
  -- this runs, and LSP and filetype keymaps are attached to buffers even later. `VeryLazy` has
  -- already fired by now, so the passes are timed instead.
  M.mirror()
  vim.defer_fn(M.mirror, 250)
  vim.defer_fn(M.mirror, 1000)
  vim.defer_fn(M.mirror, 3000)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("RuLayout", { clear = true }),
    callback = function(args)
      -- `nvim_get_keymap` only reports global mappings, so the buffer's own ones have to be asked
      -- for separately, with the buffer they belong to.
      M.mirror(args.buf)
    end,
  })
end

return M

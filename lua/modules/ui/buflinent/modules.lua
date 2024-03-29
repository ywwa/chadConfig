local api = vim.api
local fn = vim.fn
local g = vim.g

local txt = require("modules.ui.buflinent.utils").txt
local btn = require("modules.ui.buflinent.utils").btn
local strep = string.rep
local style_buf = require("modules.ui.buflinent.utils").style_buf
local cur_buf = api.nvim_get_current_buf

vim.cmd "function! TbGoToBuf(bufnr,b,c,d) \n execute 'b'..a:bufnr \n endfunction"

vim.cmd [[
   function! TbKillBuf(bufnr,b,c,d) 
        call luaeval('require("modules.ui.buflinent").close_buffer(_A)', a:bufnr)
  endfunction]]

vim.cmd "function! TbNewTab(a,b,c,d) \n tabnew \n endfunction"
vim.cmd "function! TbGotoTab(tabnr,b,c,d) \n execute a:tabnr ..'tabnext' \n endfunction"
vim.cmd "function! TbCloseAllBufs(a,b,c,d) \n lua require('modules.ui.buflinent').closeAllBufs() \n endfunction"
vim.cmd "function! TbToggleTabs(a,b,c,d) \n let g:TbTabsToggled = !g:TbTabsToggled | redrawtabline \n endfunction"


local function getNvimTreeWidth()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
      return api.nvim_win_get_width(win)
    end
  end
  return 0
end

local M = {}

local function available_space()
  local str = ""

  for key, value in pairs(M) do
    if key ~= "buffers" then
      str = str .. value()
    end
  end

  local modules = api.nvim_eval_statusline(str, { use_tabline = true })
  return vim.o.columns - modules.width
end

M.treeOffset = function()
  if getNvimTreeWidth() > 0 then
    return "%#NvimTreeNormal#"
      .. strep(" ", getNvimTreeWidth())
      .. "%#NvimTreeWinSeparator#"
      .. "│"
  else
    return ""
  end
end

M.buffers = function()
  local buffers = {}
  local has_current = false -- have we seen current buffer yet?

  for i, nr in ipairs(vim.t.bufs) do
    if ((#buffers + 1) * 23) > available_space() then
      if has_current then
        break
      end

      table.remove(buffers, 1)
    end

    has_current = cur_buf() == nr
    table.insert(buffers, style_buf(nr, i))
  end

  return table.concat(buffers) .. txt("%=", "Fill") -- buffers + empty space
end

g.TbTabsToggled = 0

M.tabs = function()
  local result, tabs = "", fn.tabpagenr "$"

  if tabs > 1 then
    for nr = 1, tabs, 1 do
      local tab_hl = "TabO" .. (nr == fn.tabpagenr() and "n" or "ff")
      result = result .. btn(" " .. nr .. " ", tab_hl, "GotoTab", nr)
    end

    local new_tabtn = btn("  ", "TabNewBtn", "NewTab")
    local tabstoggleBtn = btn(" 󰅂 ", "TabTitle", "ToggleTabs")
    local small_btn = btn(" 󰅁 ", "TabTitle", "ToggleTabs")

    return g.TbTabsToggled == 1 and small_btn
      or new_tabtn .. tabstoggleBtn .. result
  end

  return ""
end

M.btns = function()
  local closeAllBufs = btn(" 󰅖 ", "CloseAllBufsBtn", "CloseAllBufs")
  return closeAllBufs
end

return function()
  local order = { "treeOffset", "buffers", "tabs", "btns" }
  local result = {}

  for _, v in ipairs(order) do
    table.insert(result, M[v]())
  end

  return table.concat(result)
end

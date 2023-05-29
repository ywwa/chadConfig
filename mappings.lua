---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<ESC>"] = { ":noh <CR>", "Clear highlights", opts = { silent = true } },
    ["<leader>h"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal terminal",
    },
    ["<leader>v"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical terminal",
    },
  },
}

M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",

    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",

    ["<Up>"] = "",
    ["<Down>"] = "",
    ["<Left>"] = "",
    ["<Right>"] = "",

    ["<leader>gb"] = "",

    ["H"] = "",
    ["J"] = "",
    ["K"] = "",
    ["L"] = "",
  },
}

M.typing = {
  n = {
    ["<A-j>"] = { "<cmd> m+1<CR>==", "Move line down" },
    ["<A-k>"] = { "<cmd> m-2<CR>==", "Move line up" },
  },

  i = {
    ["<A-j>"] = { "<cmd> m+1<CR>==", "Move line down" },
    ["<A-k>"] = { "<cmd> m-2<CR>==", "Move line up" },
  },

  x = {
    ["<A-j>"] = { "<cmd> m+1<CR>==", "Move line down" },
    ["<A-k>"] = { "<cmd> m-2<CR>==", "Move line up" },
  },

  v = {
    ["<A-j>"] = { "<cmd> m+1<CR>==", "Move line down" },
    ["<A-k>"] = { "<cmd> m-2<CR>==", "Move line up" },
  },
}

M.ship = {
  n = {
    ["<leader>sr"] = {
      "<cmd> Ship <CR>",
      "Run Http request",
    },
    ["<leader>sq"] = {
      "<cmd> ShipCloseResponse <CR>",
      "Close Ship response",
    },
  },
}

M.peek = {
  n = {
    ["<leader>mo"] = {
      "<cmd> PeekOpen <CR>",
      "Open markdown preview",
    },
    ["<leader>mq"] = {
      "<cmd> PeekClose <CR>",
      "Close markdown preview",
    },
  },
}

M.tabufline = {
  n = {
    ["<leader>to"] = {
      "<cmd> tabnew <CR>",
      "Open new Tab",
    },
    ["<leader>tq"] = {
      "<cmd> tabclose <CR>",
      "Close tab",
    },
    ["<leader>tn"] = {
      "<cmd> tabnext <CR>",
      "Next Tab",
    },
    ["<leader>tp"] = {
      "<cmd> tabprevious <CR>",
      "Previous Tab",
    },
  },
}

M.trouble = {
  n = {
    ["<leader>tt"] = {
      "<cmd> TroubleToggle <CR>",
      "Toggle Trouble",
    },
  },
}

M.custom = {
  n = {
    ["<leader>tc"] = {
      "<cmd> CCToggle <CR>",
      "Toggle Color column",
    },

    ["<leader>td"] = {
      function()
        vim.api.nvim_input ":tcd "
      end,
      "Run tcd command",
    },
  },
}

M.git = {
  n = {
    ["<leader>gb"] = {
      "<cmd> Gitsigns toggle_current_line_blame <CR>",
      "Toggle Current line blame",
    },
  },
}

return M

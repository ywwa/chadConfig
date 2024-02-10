local overrides = require "custom.overrides"

---@type NvPluginSpec[]
return {
  { -- nvim-lspconfig
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "pmizio/typescript-tools.nvim",
        ft = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        opts = {},
        config = function()
          require("typescript-tools").setup {
            on_attach = function(client, _)
              client.server_capabilities.semanticTokensProvider = nil
            end,
          }
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.core.plugin_configs.lspconfig"
    end,
  },

  { -- mason
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  { -- treesitter
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      { -- comment
        "numToStr/Comment.nvim",
        opts = function()
          return {
            pre_hook = require(
              "ts_context_commentstring.integrations.comment_nvim"
            ).create_pre_hook(),
          }
        end,
      },
    },
    opts = overrides.treesitter,
  },

  { -- CMP
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "ray-x/cmp-treesitter",
      "chrisgrieser/cmp-nerdfont",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item)
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end

      opts.sources = {
        {
          name = "nvim_lsp",
          keyword_length = 5,
          group_index = 1,
          max_item_count = 30,
        },
        { name = "nvim_lua" },
        { name = "vim_lsp" },
        { name = "codeium" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "path" },
        { name = "emoji" },
        { name = "nerdfont" },
      }
    end,
  },

  { -- colorizer
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  { -- telescope
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "barrett-ruth/telescope-http.nvim",
      {
        "danielvolchek/tailiscope.nvim",
        dir = "~/.local/sources/tailiscope.nvim",
      },
      {
        "ywwa/telescope-nodua",
        dir = "~/.local/sources/telescope-nodua",
      },
    },
    opts = overrides.telescope,
  },

  { -- better escape
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        clear_empty_lines = true,
      }
    end,
  },

  --
  { -- nvim-tree
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  { -- indent blankline
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = { char = "." },
    },
  },

  { -- autopairs
    "windwp/nvim-autopairs",
    enabled = false,
  },
}

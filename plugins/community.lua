return {
  "AstroNvim/astrocommunity",
  { "luisiacc/gruvbox-baby" },
  -- {
  --   "barrett-ruth/live-server.nvim",
  --   build = "yarn global add live-server",
  --   event = "User AstroFile",
  --   config = true,
  -- },
  {
    "turbio/bracey.vim",
    event = "User AstroFile",
    opts = {},
  },
  { "kartikp10/noctis.nvim" },
  { "sainnhe/sonokai" },

  -- colorscheme
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  --{ import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.colorscheme.fluormachine-nvim" },
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },
  { import = "astrocommunity.colorscheme.nordic-nvim" },
  -- { import = "astrocommunity.colorscheme.catppuccino-nvim" },
  -- end colorscheme
  --
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.media.pets-nvim" },
  { import = "astrocommunity.bars-and-lines.vim-illuminate" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.media.vim-wakatime" },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      terminal_colors = true,
      devicons = true, -- highlight the icons of `nvim-web-devicons`
      filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
      plugins = {
        indent_blankline = {
          context_highlight = "pro", -- default | pro
          context_start_underline = false,
        },
      },
    },
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function() require("catppuccin").setup {} end,
  },
  { import = "astrocommunity.completion.copilot-lua" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    opts = { suggestion = { auto_trigger = true, debounce = 150 } },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    opts = function(_, opts)
      local cmp, copilot = require "cmp", require "copilot.suggestion"
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      if not snip_status_ok then return end
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end
      if not opts.mapping then opts.mapping = {} end
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if copilot.is_visible() then
          copilot.accept()
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<C-x>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.next() end
      end)

      opts.mapping["<C-z>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.prev() end
      end)

      opts.mapping["<C-right>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_word() end
      end)

      opts.mapping["<C-l>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_word() end
      end)

      opts.mapping["<C-down>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_line() end
      end)

      opts.mapping["<C-j>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_line() end
      end)

      opts.mapping["<C-c>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.dismiss() end
      end)

      return opts
    end,
  },
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- 使用 init 函数，在这里设置变量绝对不会报错
  init = function()
    vim.env.cc = "gcc"
    require("nvim-treesitter.install").compilers = { "gcc" }
  end,
  opts = {
    -- 这里放你原本的 treesitter 配置，例如：
    ensure_installed = { },
    highlight = { enable = true },
  },
}

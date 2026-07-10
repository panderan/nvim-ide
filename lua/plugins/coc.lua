return {
  {
    'neoclide/coc.nvim', branch = 'release',
    lazy = false,
    keys = {
      {"<leader>jg", "<Plug>(coc-definition)", desc = "jump definition"},
      {"<leader>jc", "<Plug>(coc-references)", desc = "jump references"},
      {"<leader>jd", "<Plug>(coc-type-definition)", desc = "jump type-definition"},
      {"<leader>ji", "<Plug>(coc-implementation)", desc = "jump implementation"},

      {"<leader>lb", ":<C-u>CocList buffers<CR>", desc = "current buffer list"},
      {"<leader>lf", ":<C-u>CocList files<CR>", desc = "search files from current cwd"},
      {"<leader>lg", ":<C-u>CocList grep<CR>", desc = "grep text from current cwd"},
      {"<leader>ll", ":<C-u>CocList lines<CR>", desc = "search lines by regex patterns"},
      {"<leader>lw", ":<C-u>CocList words<CR>", desc = "search word in current buffer"},
    },
    config = function()
      -- 创建一个 Lua 函数来处理文档显示逻辑
      local function show_documentation()
        if vim.fn['CocAction']('hasProvider', 'hover') then
          vim.fn['CocActionAsync']('doHover')
        else
          vim.api.nvim_feedkeys('K', 'in', false)
        end
      end

      -- 在 lazy.nvim 的 config 中绑定快捷键
      vim.keymap.set('n', 'K', show_documentation, {
        silent = true,
        desc = "Coc: Show Documentation"
      })
    end
  }
}

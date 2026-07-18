return {
  "carlos-algms/agentic.nvim",
  lazy = false,

  --- @type agentic.PartialUserConfig
  opts = {
    -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp" | "kiro-acp" | "pi-acp"
    provider = "opencode-acp", -- setting the name here is all you need to get started
    acp_providers = {
        ["opencode-acp"] = {
            name = "opencode",
            command = vim.fn.has("win32") == 1 and "opencode.cmd" or "opencode",
            args = {"acp"},
            default_mode = "plan",
            initial_model = "deepseek/deepseek-v4-flash",
        },
        ["cursor-acp"] = {
            name = "cursor",
            command = vim.fn.has("win32") == 1 and "agent.cmd" or "agent",
            args = {"acp"},
            -- default_mode = "",
            -- initial_model = "",
        }
    },
    diff_preview = {
      enabled = true,
      layout = "split",  -- "split" or "inline"
      center_on_navigate_hunks = true,
    },
  },

  config = function(_, opts)
    -- 1. 正常初始化插件
    require("agentic").setup(opts)
    
    -- 2. 覆盖默认的蓝底色，将其链接到你的主题标题色
    vim.api.nvim_set_hl(0, "AgenticTitle", { link = "Title" })
  end,

  -- these are just suggested keymaps; customize as desired
  keys = {
    {
      "<C-\\>",
      function() require("agentic").toggle({auto_add_to_context = false, focus_prompt = false}) end,
      mode = { "n", "v", "i" },
      desc = "Toggle Agentic Chat"
    },
    {
      "<A-i>i",
      function() require("agentic").add_selection_or_file_to_context({focus_prompt = false}) end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic to Context"
    },
    {
      "<A-i>x",
      function() require("agentic").stop_generation() end,
      mode = { "n", "v", "i" },
      desc = "Stop the agent's current generation or tool execution."
    },
    {
      "<A-i>sn",
      function() require("agentic").new_session({auto_add_to_context = false}) end,
      mode = { "n", "v", "i" },
      desc = "New Agentic Session"
    },
    {
      "<A-i>sr", -- ai Restore
      function()
          require("agentic").restore_session()
      end,
      desc = "Agentic Restore session",
      silent = true,
      mode = { "n", "v", "i" },
    },
    {
      "<A-i>ad", -- ai Diagnostics
      function()
          require("agentic").add_current_line_diagnostics({focus_prompt = false})
      end,
      desc = "Add current line diagnostic to Agentic",
      mode = { "n" },
    },
    {
      "<A-i>aD", -- ai all Diagnostics
      function()
          require("agentic").add_buffer_diagnostics({focus_prompt = false})
      end,
      desc = "Add all buffer diagnostics to Agentic",
      mode = { "n" },
    },
    {
      "<A-i>sp", -- ai switch provider
      function()
          require("agentic").switch_provider()
      end,
      desc = "Add all buffer diagnostics to Agentic",
      mode = { "n" },
    },
  },
}

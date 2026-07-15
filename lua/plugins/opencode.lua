return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type for details
    }

    vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<M-a>", function() require("opencode").ask("") end, { desc = "Ask OpenCode…" })
    vim.keymap.set({ "n", "x" }, "<M-x>", function() require("opencode").select() end,       { desc = "Select OpenCode…" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Append range to OpenCode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Append line to OpenCode", expr = true })

    vim.keymap.set("n", "<M-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll OpenCode up" })
    vim.keymap.set("n", "<M-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })

    -- integrate with snacks.terminal
    local opencode_cmd = 'opencode --port'
    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      win = {
        position = 'right',
        enter = false,
      },
    }

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }

    -- Can also leverage toggle functionality.
    -- If you use <leader> here, remove 't' — otherwise Neovim will add input delay to your <leader> when typing in the terminal to watch for the mapping.
    vim.keymap.set({ 'n', 't' }, '<M-.>', function()
      require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
    end, { desc = 'Toggle OpenCode' })

    -- Optionally show upon submitting prompt
    vim.api.nvim_create_autocmd('User', {
      pattern = { 'OpencodeEvent:tui.command.execute' },
      callback = function(args)
        ---@type opencode.server.Event
        local event = args.data.event
        if event.properties.command == 'prompt.submit' then
          local win = require('snacks.terminal').get(opencode_cmd, { create = false })
          if win then
            win:show()
          end
        end
      end,
    })

  end,
}

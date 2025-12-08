return {
        {
    "harpoon2",
    for_cat = 'general.always',
    event = "DeferredUIEnter",
    -- dep of plenary?
    after = function (plugin)
        local harpoon = require('harpoon')
        harpoon.setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>n", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<leader><S-n>", function() harpoon:list():next() end)
    end
        },
  }

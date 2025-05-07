-- these are all default values
require("git-worktree").setup({
    change_directory_command = "cd",
    update_on_change = true,
    update_on_change_command = "e .",
    clearjumps_on_change = true,
    autopush = false
})

local Worktree = require("git-worktree")

Worktree.on_tree_change(function(op, metadata)
    -- Defer the reload of nvim-tree to avoid race conditions
    vim.defer_fn(function()
        local ok, nvim_tree_api = pcall(require, "nvim-tree.api")
        if ok then
            nvim_tree_api.tree.close()
            nvim_tree_api.tree.open()
        end
    end, 100)
end)

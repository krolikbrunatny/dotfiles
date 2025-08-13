return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- cmd = "Neotree",
    -- keys = {
    --   {
    --     "<leader>fe",
    --     function()
    --       require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
    --     end,
    --     desc = "Explorer NeoTree (Root Dir)",
    --   },
    --   {
    --     "<leader>fE",
    --     function()
    --       require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
    --     end,
    --     desc = "Explorer NeoTree (cwd)",
    --   },
    --   { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    --   { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    --   {
    --     "<leader>ge",
    --     function()
    --       require("neo-tree.command").execute({ source = "git_status", toggle = true })
    --     end,
    --     desc = "Git Explorer",
    --   },
    --   {
    --     "<leader>be",
    --     function()
    --       require("neo-tree.command").execute({ source = "buffers", toggle = true })
    --     end,
    --     desc = "Buffer Explorer",
    --   },
    -- },
    -- deactivate = function()
    --   vim.cmd([[Neotree close]])
    -- end,
    -- init = function()
    --   -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
    --   -- because `cwd` is not set up properly.
    --   vim.api.nvim_create_autocmd("BufEnter", {
    --     group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
    --     desc = "Start Neo-tree with directory",
    --     once = true,
    --     callback = function()
    --       if package.loaded["neo-tree"] then
    --         return
    --       else
    --         local stats = vim.uv.fs_stat(vim.fn.argv(0))
    --         if stats and stats.type == "directory" then
    --           require("neo-tree")
    --         end
    --       end
    --     end,
    --   })
    -- end,
    opts = {
      window = {
        mappings = {
          ["<leader>t"] = {
            function(state)
              -- Get the currently selected node from the tree.
              local node = state.tree:get_node()
              if not node or not node.path then
                vim.notify("Could not get a valid node.", vim.log.levels.WARN)
                return
              end

              local path = node.path
              -- Use vim.loop.fs_stat to get information about the path (e.g., is it a file or directory?).
              local stat = vim.loop.fs_stat(path)

              -- If we can't get stats for the path, something is wrong.
              if not stat then
                vim.notify("Could not get stats for path: " .. path, vim.log.levels.ERROR)
                return
              end

              ----------------------------------------------------------------------
              -- Case 1: The selected node is a file.
              ----------------------------------------------------------------------
              if stat.type == "file" then
                -- Read all lines of the file into a table.
                local content_lines = vim.fn.readfile(path)
                -- Concatenate the lines with newline characters.
                local content = table.concat(content_lines, "\n")

                -- Set the system clipboard register ('+').
                -- Use '*' for the default clipboard if '+' is not available.
                vim.fn.setreg("+", content)
                vim.notify("Copied file contents to clipboard.", vim.log.levels.INFO)
                return
              end

              ----------------------------------------------------------------------
              -- Case 2: The selected node is a directory.
              ----------------------------------------------------------------------
              if stat.type == "directory" then
                -- Use a table as a buffer to efficiently build the final string.
                local output_buffer = {}
                local base_dir_path = path

                ---
                -- Recursively walks through directories to find files.
                -- @param current_dir The directory path to scan.
                --
                local function walk_directory(current_dir)
                  -- vim.fs.dir provides an efficient iterator over directory entries.
                  -- It returns the name and type ('file', 'directory', etc.) for each item.
                  for name, type in vim.fs.dir(current_dir) do
                    local full_path = current_dir .. "/" .. name

                    if type == "directory" then
                      -- If it's a directory, recurse into it.
                      walk_directory(full_path)
                    elseif type == "file" then
                      -- If it's a file, process it.

                      -- 1. Calculate the relative path.
                      -- We strip the base directory path and the leading slash.
                      local relative_path = string.sub(full_path, #base_dir_path + 2)

                      -- 2. Read the file's content.
                      local file_content_lines = vim.fn.readfile(full_path)
                      local file_content = table.concat(file_content_lines, "\n")

                      -- 3. Format the block according to the specified format.
                      local formatted_block = string.format("%s\n```\n%s\n```", relative_path, file_content)

                      -- 4. Add the formatted block to our output buffer.
                      table.insert(output_buffer, formatted_block)
                    end
                  end
                end

                -- Start the recursive walk from the selected directory.
                walk_directory(base_dir_path)

                if #output_buffer > 0 then
                  -- Join all the collected blocks with two newlines in between.
                  local final_content = table.concat(output_buffer, "\n\n")
                  vim.fn.setreg("+", final_content)
                  vim.notify("Copied all file contents from directory to clipboard.", vim.log.levels.INFO)
                else
                  vim.notify("Directory is empty. Nothing to copy.", vim.log.levels.INFO)
                end
                return
              end

              -- If the node is not a file or directory (e.g., a symlink), do nothing.
            end,
            desc = "Open with System Application",
          },
        },
      },
    },
    -- config = function(_, opts)
    --   local function on_move(data)
    --     Snacks.rename.on_rename_file(data.source, data.destination)
    --   end
    --
    --   local events = require("neo-tree.events")
    --   opts.event_handlers = opts.event_handlers or {}
    --   vim.list_extend(opts.event_handlers, {
    --     { event = events.FILE_MOVED, handler = on_move },
    --     { event = events.FILE_RENAMED, handler = on_move },
    --   })
    --   require("neo-tree").setup(opts)
    --   vim.api.nvim_create_autocmd("TermClose", {
    --     pattern = "*lazygit",
    --     callback = function()
    --       if package.loaded["neo-tree.sources.git_status"] then
    --         require("neo-tree.sources.git_status").refresh()
    --       end
    --     end,
    --   })
    -- end,
  },
}

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
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
  },
}

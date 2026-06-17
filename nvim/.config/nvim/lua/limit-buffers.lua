---Return a list of unchanged open buffers
local function open_buffers()
  local bufs = {}
  -- only consider buffers without changes
  for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if buf.changed == 0 then
      table.insert(bufs, buf)
    end
  end
  return bufs
end

---Close the oldest open buffer once we open the 11th buffer
---@param limit number Number of buffers to keep open
local function clean_buffers(limit)
  -- return the closure to execute on BufAdd
  return function()
    local bufs = open_buffers()

    if #bufs > limit then
      -- Sort the open buffers by last used
      table.sort(bufs, function(a, b) return a.lastused < b.lastused end)
      for _, buf in ipairs(bufs) do
        -- never close the current buffer
        if buf.bufnr ~= vim.api.nvim_get_current_buf() then
          vim.cmd.bdelete(buf.bufnr)
          vim.notify("closed " .. buf.name)
          -- keep closing buffers until we are back at the limit
          if #open_buffers() <= limit then
            break
          end
        end
      end
    end
  end
end

-- Limit the number of open buffers to 10
vim.api.nvim_create_autocmd("BufAdd", { callback = clean_buffers(10) })

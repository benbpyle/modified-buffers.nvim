local M = {}

-- Default configuration
M.config = {
  width = 50,
  max_height = 15,
  border = 'rounded',
  title = ' Modified Buffers ',
}

-- Setup function to allow user configuration
function M.setup(opts)
  M.config = vim.tbl_deep_extend('force', M.config, opts or {})
end

-- Main function to show modified buffers
function M.show()
  local modified = {}
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(bufnr, 'modified') then
      local fullpath = vim.api.nvim_buf_get_name(bufnr)
      local filename = fullpath ~= '' and vim.fn.fnamemodify(fullpath, ':t') or '[No Name]'

      -- Get file icon if available
      local icon = '󰈚' -- Default file icon
      local icon_hl = ''
      if has_devicons and fullpath ~= '' then
        local ext = vim.fn.fnamemodify(fullpath, ':e')
        icon, icon_hl = devicons.get_icon(filename, ext, { default = true })
      end

      -- Format: "icon filename"
      local display = string.format(' %s  %s', icon, filename)
      table.insert(modified, { text = display, bufnr = bufnr, icon_hl = icon_hl })
    end
  end

  if #modified == 0 then
    vim.notify('No modified buffers', vim.log.levels.INFO)
    return
  end

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {}
  for _, item in ipairs(modified) do
    table.insert(lines, item.text)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Calculate window size
  local width = M.config.width
  local height = math.min(#modified + 2, M.config.max_height)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = M.config.border,
    title = M.config.title,
    title_pos = 'center',
  })

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_win_set_option(win, 'wrap', false)
  vim.api.nvim_win_set_option(win, 'cursorline', true)

  -- Add syntax highlighting for icons
  if has_devicons then
    for i, item in ipairs(modified) do
      if item.icon_hl and item.icon_hl ~= '' then
        vim.api.nvim_buf_add_highlight(buf, -1, item.icon_hl, i - 1, 1, 2)
      end
    end
  end

  -- Close on q or <Esc>
  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })

  -- Press Enter to jump to that buffer
  vim.keymap.set('n', '<CR>', function()
    local line_num = vim.api.nvim_win_get_cursor(win)[1]
    local item = modified[line_num]
    if item and item.bufnr then
      vim.api.nvim_win_close(win, true)
      vim.api.nvim_set_current_buf(item.bufnr)
    end
  end, { buffer = buf, silent = true })
end

return M

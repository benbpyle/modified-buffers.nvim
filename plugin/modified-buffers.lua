-- Prevent loading file twice
if vim.g.loaded_modified_buffers == 1 then
  return
end
vim.g.loaded_modified_buffers = 1

-- Create user command
vim.api.nvim_create_user_command('ModifiedBuffers', function()
  require('modified-buffers').show()
end, {
  desc = 'Show modified buffers in a floating window',
})

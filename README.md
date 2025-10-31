# modified-buffers.nvim

A lightweight Neovim plugin to quickly view and navigate to modified buffers in a clean floating window.

![Modified Buffers Demo](https://via.placeholder.com/600x200?text=Screenshot+Coming+Soon)

## Features

- 🎨 Clean floating window with file icons (using nvim-web-devicons)
- ⚡ Fast navigation - press `Enter` to jump to a buffer
- 🎯 Shows only modified buffers (unsaved changes)
- 🎨 Syntax-highlighted file icons matching file types
- ⌨️ Simple keybindings (`q`, `Esc` to close, `Enter` to select)

## Requirements

- Neovim >= 0.8.0
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) (optional, for file icons)

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'benbpyle/modified-buffers.nvim',
  keys = {
    { '<leader>bl', '<cmd>ModifiedBuffers<cr>', desc = 'Modified [B]uffer [L]ist' },
  },
  opts = {},
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'benbpyle/modified-buffers.nvim',
  config = function()
    require('modified-buffers').setup()
  end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'benbpyle/modified-buffers.nvim'
```

## Usage

### Command

```vim
:ModifiedBuffers
```

### Keybindings (in the floating window)

- `Enter` - Jump to the selected buffer
- `q` or `Esc` - Close the window
- `j/k` - Navigate up/down

## Configuration

You can customize the plugin by passing options to the `setup` function:

```lua
require('modified-buffers').setup({
  width = 50,           -- Width of the floating window
  max_height = 15,      -- Maximum height of the floating window
  border = 'rounded',   -- Border style: 'rounded', 'single', 'double', 'solid', 'shadow'
  title = ' Modified Buffers ',  -- Window title
})
```

### With lazy.nvim

```lua
{
  'benbpyle/modified-buffers.nvim',
  keys = {
    { '<leader>bl', '<cmd>ModifiedBuffers<cr>', desc = 'Modified [B]uffer [L]ist' },
  },
  opts = {
    width = 60,
    border = 'double',
  },
}
```

## Why This Plugin?

Built out of a need for a simple, focused way to see which buffers have unsaved changes without the clutter of showing all open buffers. Perfect for keeping track of your work-in-progress files.

## License

BSD 3-Clause - see [LICENSE](LICENSE) for details

## Contributing

Issues and pull requests are welcome!

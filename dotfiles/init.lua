vim.pack.add {
    { src = 'https://www.github.com/saghen/blink.cmp' },
    { src = 'https://www.github.com/saghen/blink.lib' },
    { src = 'https://www.github.com/mason-org/mason.nvim' },
    { src = 'https://www.github.com/neovim/nvim-lspconfig' },
    { src = 'https://www.github.com/nvim-lua/plenary.nvim' },
    { src = 'https://www.github.com/nvim-tree/nvim-tree.lua' },
    { src = 'https://www.github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://www.github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://www.github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://www.github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://www.github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://www.github.com/catppuccin/nvim', name = 'catppuccin' },
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.encoding = 'UTF-8'
vim.opt.clipboard = 'unnamedplus'
vim.opt.wrap = false
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.swapfile = false
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true


local telescope_builtins = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', telescope_builtins.find_files, { desc = 'Find Files using Telescope' })
vim.keymap.set('n', '<leader>g', telescope_builtins.live_grep, { desc = 'Live Grep using Telescope' })

local languages = {
    'cpp',
    'typst',
    'python',
    'haskell',
    'javascript',
    'typescript'
}

require('nvim-treesitter').install(languages)
vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function()
        pcall(vim.treesitter.start)
    end
})

local blink = require('blink.cmp')
blink.setup({
    fuzzy = {
        implementation = 'lua'
    }
})

require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = {
        'pyright',
        'clangd',
        'tinymist'
    }
}

local blink_capabilities = blink.get_lsp_capabilities()

vim.lsp.enable('clangd', {
    capabilities = blink_capabilities,
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy'
    }
})

vim.lsp.enable('tinymist', {
    capabilities = blink_capabilities
})

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' }
    }
}

require('nvim-tree').setup {
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    sync_root_with_cwd = true
}
vim.keymap.set('n', '<leader>a', ':NvimTreeOpen<CR>', { desc = 'File Browser via NvimTree' })

local mocha = require('catppuccin.palettes').get_palette('mocha')
require('catppuccin').setup({
    flavour = 'mocha',
    integrations = {
        nvimtree = true
    },
    custom_highlights = function()
        return {
            NvimTreeNormal = { bg = mocha.base },
            NvimTreeNormalNC = { bg = mocha.base },
            NvimTreeWinSeparator = {
                fg = mocha.surface1,
                bg = mocha.base
            }
        }
    end
})

vim.cmd.colorscheme 'catppuccin-mocha'

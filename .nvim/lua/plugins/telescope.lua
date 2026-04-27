return {
    'nvim-telescope/telescope.nvim', version = '0.2.1',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'jvgrootveld/telescope-zoxide',
    },
    config = function()
        local builtin = require('telescope.builtin')
        local telescope = require('telescope')

        telescope.setup({
            extensions = {
                zoxide = {
                    mappings = {
                        default = {
                            keepinsert = false,
                            action = function(selection)
                                -- 1. Muda o diretório interno do Neovim para a pasta selecionada
                                vim.cmd("cd " .. vim.fn.fnameescape(selection.path))
                                
                                -- 2. Tenta abrir o seu explorador de arquivos na nova pasta
                                
                                -- Se você usa o NvimTree:
                                local ok, _ = pcall(vim.cmd, "NvimTreeOpen")
                                
                                -- Se o comando acima falhar (ou seja, se você usar Neo-tree), ele tenta este:
                                if not ok then
                                    pcall(vim.cmd, "Neotree dir=" .. vim.fn.fnameescape(selection.path))
                                end
                            end
                        }
                    }
                }
            }
        })

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	vim.keymap.set('n', '<leader>fz', telescope.extensions.zoxide.list, { desc = 'Telescope Zoxide' })

        telescope.load_extension('fzf')
        telescope.load_extension('zoxide')

    end
}

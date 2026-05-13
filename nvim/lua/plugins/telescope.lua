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
                                vim.schedule(function()
                                    -- 1. Cria um arquivo vazio ("em branco") para não quebrar a tela
                                    vim.cmd("enew")

                                    -- 2. Varre e fecha todos os arquivos antigos (buffers listados)
                                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                                        -- Ignora o arquivo em branco que acabamos de criar, foca nos antigos
                                        if vim.bo[buf].buflisted and buf ~= vim.api.nvim_get_current_buf() then
                                            -- pcall tenta fechar de forma segura (se tiver algo sem salvar, ele não força e você não perde código)
                                            pcall(vim.api.nvim_buf_delete, buf, { force = false })
                                        end
                                    end

                                    -- 3. Muda o diretório interno do Neovim para a pasta nova
                                    vim.cmd("cd " .. vim.fn.fnameescape(selection.path))

                                    -- 4. Usa a API do NvimTree para abrir e focar na nova raiz
                                    local ok_api, nvim_tree_api = pcall(require, "nvim-tree.api")
                                    
                                    if ok_api then
                                        nvim_tree_api.tree.open({ path = selection.path })
                                    else
                                        pcall(vim.cmd, "Neotree dir=" .. vim.fn.fnameescape(selection.path))
                                    end
                                end)
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

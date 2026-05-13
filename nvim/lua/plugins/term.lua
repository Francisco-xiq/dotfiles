return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        -- Garante que o Neovim sempre abra novos painéis horizontais na parte de BAIXO da tela
        vim.opt.splitbelow = true 

        require("toggleterm").setup({
            size = 12, -- Aumentei levemente para 12 para não ficar tão espremido
            direction = 'horizontal',    
            shade_terminals = true,      
        })

        -- Atalho INTELIGENTE para o Terminal
        vim.keymap.set('n', '<leader>t', function()
            -- Se o cursor estiver preso no NvimTree, pula para a janela da direita primeiro
            if vim.bo.filetype == "NvimTree" then
                vim.cmd("wincmd l")
            end
            -- Abre o terminal garantindo que a direção seja horizontal
            vim.cmd("ToggleTerm direction=horizontal")
        end, { desc = 'Toggle Terminal' })

        function _G.set_terminal_keymaps()
            local opts = {buffer = 0}

            vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        end

        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        
        vim.api.nvim_create_autocmd("DirChanged", {
            pattern = "global",
            callback = function(args)
                local new_dir = args.file

                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.bo[buf].buftype == "terminal" then
                        local chan = vim.b[buf].terminal_job_id
                        if chan then
                            vim.api.nvim_chan_send(chan, "\x15cd " .. vim.fn.shellescape(new_dir) .. " && clear\r")
                        end
                    end
                end
            end,
        })
    end
}

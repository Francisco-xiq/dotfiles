return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",     -- Conecta o autocompletar à inteligência do LSP
        "hrsh7th/cmp-buffer",       -- Sugere palavras que você já digitou no arquivo atual
        "hrsh7th/cmp-path",         -- Sugere caminhos de pastas (ex: ../src/)
        "L3MON4D3/LuaSnip",         -- Motor de snippets (obrigatório para o cmp funcionar)
        "saadparwaiz1/cmp_luasnip", -- Ponte que faz o cmp mostrar os snippets do LuaSnip
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            -- O cmp exige que um motor de snippets seja configurado
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            
            -- Atalhos de teclado apenas quando o menu flutuante estiver aberto
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Rola a documentação para cima
                ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Rola a documentação para baixo
                ['<C-Space>'] = cmp.mapping.complete(),  -- Força o menu a abrir
                ['<C-e>'] = cmp.mapping.abort(),         -- Fecha o menu sem escolher nada
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirma a seleção com Enter
                
                -- Usa o Tab para navegar para a próxima sugestão
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback() -- Se não tiver menu aberto, faz um Tab normal
                    end
                end, { "i", "s" }),

                -- Usa Shift+Tab para navegar para a sugestão anterior
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            -- A ordem aqui importa! Ele vai priorizar sugestões do LSP antes das palavras do arquivo
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }, 
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
                { name = 'path' },
            })
        })
    end
}

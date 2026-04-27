vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("i", "<C-a>", "<Home>", { desc = "Ir para o início da linha" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Ir para o final da linha" })
vim.keymap.set("i", "<C-k>", "<C-o>D", { desc = "Deletar até o final da linha" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move linha para cima" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move linha para baixo" })

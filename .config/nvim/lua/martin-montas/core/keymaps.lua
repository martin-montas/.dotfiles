local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = false })
end

vim.keymap.set("n", "}", ":keepjumps normal! }<CR>")
vim.keymap.set("n", "{", ":keepjumps normal! {<CR>")

vim.keymap.set('n', "<C-c>", ":CodeiumDisable<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


map('n','<leader>h', ':wincmd h<CR>')
map('n','<leader>t', ':NvimTreeToggle<CR>')
map('n','<leader>j', ':wincmd j<CR>')
map('n','<leader>k', ':wincmd k<CR>')
map('n','<leader>l', ':wincmd l<CR>')
map('n','<leader>gg', ':G<CR>')
map('n','<leader>gc', ':G commit<CR>')
map('n','<leader>gp', ':G push<CR>')
map('n','m', '')
map('n',"'", "'")
vim.keymap.set("n", "-", ":Ex<CR>", { desc = "Open parent directory" })
map('v','J', ":m '>+1<CR>gv=gv")
map('v','K', ":m '>-2<CR>gv=gv")

vim.keymap.set('n', '<C-g>', ':RenderMardown toggle<CR>')

vim.keymap.set('c', '<C-l>', "<C-Right>")
vim.keymap.set('c', '<C-h>', "<C-Left>")

vim.keymap.set("n", "<leader>m", "<cmd>Trouble diagnostics toggle<cr>", { desc = "diagnostics" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")

vim.keymap.set("n", "<leader>o", function()
  local url = vim.fn.expand("<cfile>")

  vim.fn.jobstart({
    "librewolf",
    url
  }, {
    detach = true
  })
end)

vim.keymap.set('n', '<leader>o', ':e ~/personal/slipbox/org/tasks.org<CR>')

vim.keymap.set("n", "<leader>c", function()
  vim.cmd("w")

  local cmd = vim.fn.input("Compile command: ", "make ")

  vim.system(
    vim.split(cmd, " "),
    { text = true },
    function(obj)
      vim.schedule(function()
        vim.notify(obj.stdout .. obj.stderr)
      end)
    end
  )
end)

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-s>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)


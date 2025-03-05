-- ===============================
--    Configuración de Neovim
-- ===============================
-- ===============================
--    Plugins con Packer
-- ===============================
local packer = require('packer')
packer.startup(function(use)
  -- Packer se gestiona a sí mismo
  use 'wbthomason/packer.nvim'

  -- 🔹 Interfaz y Estética
  use 'ghifarit53/tokyonight-vim'       -- Tema Tokyonight
  use 'vim-airline/vim-airline'         -- Barra de estado mejorada
  use 'vim-airline/vim-airline-themes'  -- Temas para Airline
  use 'ryanoasis/vim-devicons'          -- Iconos para archivos
  use 'yggdroot/indentline'             -- Mostrar guías de indentación
  use 'lilydjwg/colorizer'              -- Resaltado de colores hex

  -- 🔹 Navegación y Gestión de Archivos
  use 'scrooloose/nerdtree'             -- Explorador de archivos
  use 'majutsushi/tagbar'               -- Vista de estructura de código

  -- 🔹 Funcionalidad Extra
  use 'scrooloose/nerdcommenter'        -- Comentar líneas fácilmente
  use 'jiangmiao/auto-pairs'            -- Completar paréntesis automáticamente
  use 'nvim-lua/plenary.nvim'           -- Requerido para muchos plugins

  -- 🔹 Autocompletado y Snippets
  use {'neoclide/coc.nvim', branch = 'release'} -- Autocompletado con CoC
  use 'Shougo/deoplete.nvim'                    -- Otra opción de autocompletado
  use 'SirVer/ultisnips'                        -- Snippets
  use 'honza/vim-snippets'                      -- Colección de snippets

  -- 🔹 Depuración
  use 'mfussenegger/nvim-dap'        -- Depuración en Neovim
  use 'mfussenegger/nvim-dap-python' -- Extensión DAP para Python
 
  use 'python-mode/python-mode'

end)

-- ===============================
--    Configuración de Neovim
-- ===============================
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.syntax = 'enable'
vim.opt.showcmd = true
vim.opt.encoding = 'utf-8'
vim.opt.showmatch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true -- Permitir colores mejorados

-- ===============================
--    Configuración de Tema
-- ===============================
vim.g.tokyonight_style = 'night'
vim.g.tokyonight_enable_italic = 1
vim.g.tokyonight_transparent_background = 1
vim.cmd([[colorscheme tokyonight]])

-- ===============================
--    Configuración de NERDTree
-- ===============================
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeDirArrowExpandable = '▸'
vim.g.NERDTreeDirArrowCollapsible = '▾'

vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- ===============================
--    Configuración de Tagbar
-- ===============================
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })

-- ===============================
--    Configuración de Airline
-- ===============================
vim.g['airline#extensions#tabline#enabled'] = 1

-- ===============================
--    Configuración de DAP (Depuración)
-- ===============================
local dap_python = require('dap-python')
dap_python.setup('python') -- Asegúrate de que `debugpy` está instalado

require('dap').configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}", -- Ejecuta el archivo actual
    },
}

-- ===============================
--    Mapeos de Teclas
-- ===============================
vim.g.mapleader = " " -- Tecla líder

vim.api.nvim_set_keymap('n', '<leader>q', ':bd<CR>', { noremap = true, silent = true })  -- Cerrar buffer
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })  -- Siguiente buffer
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true }) -- Buffer anterior

-- Iniciar depuración
vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dn', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })

-- ===============================
--    Ordenar Imports en Python
-- ===============================
vim.cmd([[
   autocmd BufWritePre *.py :CocCommand python.sortImports
]])



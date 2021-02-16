local nvim = mines.nvim

local load_module = mines.helper.load_module
local lspconfig = load_module "lspconfig"
local lsp = require "mines.plugins.lsp"
local action = require "mines.plugins.lsp.action"
local handlers = require "mines.plugins.lsp.handlers"

-- local set_autocmd = nvim.autocmds.set_autocmd

if lspconfig == nil then
    return false
end

lsp.init()


--[ Language Servers ]--
------------------------
local custom_on_attach = function(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    action.lsp_before_save()
  end

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  handlers()
end

lspconfig.ccls.setup {
  filetypes = {"css", "scss", "less", "sass"},
  root_dir = lspconfig.util.root_pattern("package.json", ".git")
}

lspconfig.gopls.setup {
  cmd = {"gopls","--remote=auto"},
  on_attach = custom_on_attach,
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  }
}

lspconfig.intelephense.setup {
  root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
  settings = {
    intelephense = {
      files = {
        exclude = {"**/vendor/**/fitdegree/**"};
      },
      completion = {
        insertUseDeclaration = false;
      }
    }
  }
}

lspconfig.jsonls.setup {
  settings = {
    json = {
      format = {enable = true},
      schemas = {
        {
          description = "Babel configuration",
          fileMatch = {".babelrc.json", ".babelrc", "babel.config.json"},
          url = "http://json.schemastore.org/lerna"
        },
        {
          description = "Bucklescript config",
          fileMatch = {"bsconfig.json"},
          url = "https://bucklescript.github.io/bucklescript/docson/build-schema.json"
        },
        {
          description = "Composer config",
          fileMatch = {"composer.json"},
          url = "http://json.schemastore.org/composer"
        },
        {
          description = "ESLint config",
          fileMatch = {".eslintrc.json", ".eslintrc"},
          url = "http://json.schemastore.org/eslintrc"
        },
        {
          description = "Lerna config",
          fileMatch = {"lerna.json"},
          url = "http://json.schemastore.org/lerna"
        },
        {
          description = "Lua sumneko setting schema validation",
          fileMatch = {"*.lua"},
          url = "https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json"
        },
        {
          description = "Package config",
          fileMatch = {"package.json"},
          url = "http://json.schemastore.org/package"
        },
        {
          description = "Prettier config",
          fileMatch = {".prettierrc", ".prettierrc.json", "prettier.config.json"},
          url = "http://json.schemastore.org/prettierrc"
        },
        {
          description = "Stylelint config",
          fileMatch = {".stylelintrc", ".stylelintrc.json", "stylelint.config.json"},
          url = "http://json.schemastore.org/stylelintrc"
        },
        {
          description = "TypeScript compiler configuration file",
          fileMatch = {"tsconfig.json", "tsconfig.*.json"},
          url = "http://json.schemastore.org/tsconfig"
        },
        {
          description = "Vercel Now config",
          fileMatch = {"now.json", "vercel.json"},
          url = "http://json.schemastore.org/now"
        }
      }
    }
  }
}

local sumneko_path = os.getenv('HOME') .. "/.local/server/lua-language-server"
local sumneko_binary = sumneko_path .. "/bin/Linux/lua-language-server"

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_path .. "/main.lua"},
  on_attach = custom_on_attach,

  -- Speeding up LSP attachment
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
  end,

  settings = {
    Lua = {
      awakened = {cat = true},
      --completion = { keywordSnippet = "Both" },
      diagnostics = { globals = {"vim", "use" } },
      indexes = {
        runtimepath = true,
        gap = 100,
        count = 8,
        projectRootPatterns = { "runtime", "nvim", ".git" },
      },
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      workspace = {
        maxPreload = 4000,
        preloadFileSize = 500,
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      }
    }
  }
}

lspconfig.tsserver.setup {
  -- cmd = {
  --   "typescript-language-server",
  --   "--stdio",
  --   "--tsserver-log-file", "tsserver.log",
  --   "--tsserver-log-verbosity", "verbose"
  -- },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    custom_on_attach(client)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifier = "non-relative",
        quoteStyle = "single"
      }
    }
  }
}

lspconfig.yamlls.setup {
  on_attach = custom_on_attach,
  settings = {
    yaml = {
      schemas = {
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        ["http://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}",
        ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}"
      },
      format = { enable = true
      },
      validate = true,
      hover = true,
      completion = true
    }
  }
}


local servers = { 'bashls', 'dockerls', 'graphql', 'html', 'vimls' }
for _,server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = custom_on_attach,
  }
end

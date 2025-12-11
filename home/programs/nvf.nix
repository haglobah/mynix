{
  config,
  pkgs,
  ...
}: {
  config = {
    programs.nvf = {
      enable = false;
      settings.vim = {
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          trouble.enable = true;
          lspSignature.enable = true;

          lspconfig.enable = true;
          lspconfig.sources = {
            clojure-lsp = ''
              lspconfig.clojure_lsp.setup {
                capabilities = capabilities,
                on_attach = default_on_attach,
                cmd = {"${pkgs.clojure-lsp}"},
              }
            '';
          };
        };

        luaConfigRC = {
          open_links = config.lib.dag.entryAnywhere ''
            local function open_links_in_selection()
              -- Get the visual selection
              local start_pos = vim.fn.getpos("'<")
              local end_pos = vim.fn.getpos("'>")
              local lines = vim.fn.getline(start_pos[2], end_pos[2])

              -- Combine lines into a single string
              local text = table.concat(lines, "\n")

              -- Extract URLs using a Lua pattern
              local urls = {}
              for url in string.gmatch(text, "(https?://[%w._%-%?&/=:#]+)") do
                table.insert(urls, url)
              end

              -- Open each URL
              for _, url in ipairs(urls) do
                local open_cmd = string.format("xdg-open '%s' &", url) -- Linux (replace with `open` for macOS or `start` for Windows)
                os.execute(open_cmd)
              end
            end

            vim.keymap.set('v', '<leader>o', function ()
              open_links_in_selection()
            end, { desc = "Open links in selection" })
          '';

          yank_highlight = config.lib.dag.entryAnywhere ''
            vim.api.nvim_create_autocmd('TextYankPost', {
              desc = 'Highlight when yanking (copying) text',
              group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
              callback = function()
                vim.highlight.on_yank()
              end,
            })
          '';
        };

        # This section does not include a comprehensive list of available language modules.
        # To list all available language module options, please visit the nvf manual.
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          # Languages that will be supported in default and maximal configurations.
          nix.enable = true;
          markdown.enable = true;

          # Languages that are enabled in the maximal configuration.
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          sql.enable = true;
          java.enable = true;
          ts.enable = true;
          lua.enable = true;
          zig.enable = true;
          python.enable = true;
          typst.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };

          # Language modules that are not as common.
          astro.enable = true;
          julia.enable = true;
          ocaml.enable = true;
          elixir.enable = true;
          haskell.enable = true;

          tailwind.enable = true;
          svelte.enable = true;
        };
        lazy.plugins = {
          ${pkgs.vimPlugins.neogit.pname} = {
            package = pkgs.vimPlugins.neogit;
            keys = [
              {
                mode = "n";
                key = "<leader>g";
                action = ":Neogit<CR>";
                desc = "Open Neogit";
              }
            ];
            # setupModule = "neogit";
            setupOpts = {integrations.diffview = true;};
          };
          ${pkgs.vimPlugins.auto-save-nvim.pname} = {
            package = pkgs.vimPlugins.auto-save-nvim;
            event = ["InsertLeave" "TextChanged"];
          };
          ${pkgs.vimPlugins.conjure.pname} = {
            package = pkgs.vimPlugins.conjure;
          };
          ${pkgs.vimPlugins.vim-sexp.pname} = {
            package = pkgs.vimPlugins.vim-sexp;
          };
          ${pkgs.vimPlugins.vim-sexp-mappings-for-regular-people.pname} = {
            package = pkgs.vimPlugins.vim-sexp-mappings-for-regular-people;
          };
        };
        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = false;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = false;
        };

        utility = {
          ccc.enable = false;
          icon-picker.enable = false;
          surround.enable = false;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };

          images = {
            image-nvim.enable = false;
          };
        };

        notes = {
          obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = false;
            navbuddy.enable = false;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = false;
            cmp.enable = false;
          };
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };
      };
    };
  };
}

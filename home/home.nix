{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    inputs.catppuccin.homeModules.catppuccin
    inputs.agenix.homeManagerModules.default
    inputs.nix-starter-kit.homeModules.timetracking
    inputs.nix-starter-kit.homeModules.khard
    inputs.vimium-options.homeManagerModules.vimium-options

    ./modules/registry.nix
    ./modules/email.nix
    ./modules/autostart.nix
    ./secrets.nix

    ./programs/git.nix
    # ./programs/vscode.nix
    # ./programs/nvf.nix
    ./programs/bash.nix
    ./programs/fish.nix
  ];

  config = {
    active-group = {
      timetracking = {
        enable = true;
        timetracking-token = config.age.secrets.timetracking-secret.path;
        arbeitszeiten-token = config.age.secrets.arbeitszeiten-secret.path;
        abrechenbare-zeiten-token = config.age.secrets.abrechenbare-zeiten-secret.path;
      };

      khard = {
        enable = true;
        storagePath = "/home/beat/ag/addresses/vcf";
      };
    };

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "beat";
    home.homeDirectory = "/home/beat";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "22.11"; # Please read the comment before changing.

    home.packages =
      with pkgs;
      [
        # CLI
        wget
        curl
        traceroute
        dnsutils
        jq
        tmux
        cachix
        dua
        gnupg
        pass
        nix-output-monitor

        # for secrets
        agenix

        # for `nix`
        nixd

        # for `alles`
        alles
        ydotool
        wl-clipboard

        # Emacs
        ((emacsPackagesFor emacs30).emacsWithPackages (epkgs: [ epkgs.mu4e ]))
        ripgrep
        fd
        emacs-lsp-booster

        # AI
        aider-chat-with-playwright
        python314
        claude-code
        claude-code-acp
        codex
        codex-acp
        gemini-cli
        opencode

        # Install globally to make gleam-ts-mode happy
        gleam

        # Neovim
        neovim
        zig
        gcc
        lua
        unzip
        gnumake
        markdownlint-cli

        # mob programming
        mob

        # other GUI Tools
        zed-editor
        tor-browser
        chromium
        librewolf
        obsidian
        discord
        signal-desktop
        telegram-desktop
        zoom-us
        thunderbird
        gnome-tweaks
        teams-for-linux

        # Useful for login networks: https://discourse.nixos.org/t/does-wifionice-wifi-on-deutsche-bahn-german-railway-work-for-you/41646
        captive-browser

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ]
      ++ [
        inputs.nixpkgs-24-11.legacyPackages."x86_64-linux".linphone
        pkgs.gnomeExtensions.run-or-raise
      ];

    home.file = {
      ".config/run-or-raise/shortcuts.conf".source = dotfiles/shortcuts.conf;

      ".config/zed/settings.json".source = dotfiles/zed/settings.json;
      ".config/zed/keymap.json".source = dotfiles/zed/keymap.json;

      ".claude/settings.json".source = dotfiles/claude/settings.json;

      ".mob".source = dotfiles/mob.sh/.mob;
    };

    # You can also manage environment variables but you will have to manually
    # source
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/beat/etc/profile.d/hm-session-vars.sh
    #
    # if you don't want to manage your shell through Home Manager.
    home.sessionVariables = {
      GNOME_SHELL_SLOWDOWN_FACTOR = 0.35;
      # https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
      LSP_USE_PLISTS = "true";
    };

    xdg.enable = true;

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [ "run-or-raise@edvard.cz" ];
      };
      "org/gnome/shell/keybindings" = {
        toggle-message-tray = [ ];
        toggle-quick-settings = [ ];
        focus-active-notification = [ ];
        toggle-application-view = [ ];
      };
    };

    # services.emacs.enable = true;

    programs.home-manager.enable = true;

    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";

        prompt = "enabled";
      };
    };

    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      clearDefaultKeybinds = true;
      settings = {
        font-size = 10;
        keybind = [
          "ctrl+t=new_tab"
          "alt+left=previous_tab"
          "alt+right=next_tab"
          "alt+shift+left=move_tab:-1"
          "alt+shift+right=move_tab:1"
          "ctrl+]=new_split:right"
          "ctrl+[=new_split:down"
          "shift+left=goto_split:left"
          "shift+right=goto_split:right"
          "shift+up=goto_split:up"
          "shift+down=goto_split:down"
          "ctrl+equal=reset_font_size"
          "ctrl+minus=decrease_font_size:1"
          # ctrl+s
          # ctrl+g
          # "ctrl+plus=increase_font_size:1"
        ];
      };
    };

    programs.kitty = {
      enable = true;
      shellIntegration.enableBashIntegration = true;
      shellIntegration.enableFishIntegration = true;

      settings = {
        enabled_layouts = "splits:split_axis=horizontal";
        allow_remote_control = "yes";
        hide_window_decorations = "yes";
        font_size = 16;
      };

      keybindings = {
        "ctrl+t" = "launch --cwd=current --type=tab";
        "alt+left" = "prev_tab";
        "alt+right" = "next_tab";
        "alt+shift+left" = "move_tab_backward";
        "alt+shift+right" = "next_tab_forward";
        "ctrl+]" = "launch --cwd=current --location=vsplit";
        "ctrl+[" = "launch --cwd=current --location=hsplit";
        "shift+left" = "neighboring_window left";
        "shift+right" = "neighboring_window right";
        "shift+up" = "neighboring_window up";
        "shift+down" = "neighboring_window down";
        "ctrl+shift+left" = "move_window left";
        "ctrl+shift+right" = "move_window right";
        "ctrl+shift+up" = "move_window up";
        "ctrl+shift+down" = "move_window down";
        "ctrl+plus" = "change_font_size all +1.0";
        "ctrl+equal" = "change_font_size all 10.0";
        "ctrl+minus" = "change_font_size all -1.0";
        "ctrl+s" = "send_text all \\x17";
        "ctrl+g" = "send_key alt+d";
      };
    };

    programs.firefox =
      let
        extensionPkgs = with inputs.firefox-addons.packages."x86_64-linux"; [
          custom-tab-title-from-file
          bitwarden
          darkreader
          videospeed
          vimium
          ublock-origin
        ];
      in
      {
        enable = true;
        profiles.beat = {
          isDefault = true;
          id = 0;
          name = "beat";
          settings = {
            "signon.rememberSignons" = false;
            "layout.spellcheckDefault" = "0";
          };

          extensions.packages = extensionPkgs;
          extensions.force = true;
        };
      };

    home.vimiumOptions = {
      enable = true;

      outputFilePath = ".cache/vimium-options.json";

      keyMappings = {
        unmapAll = true;
        map = {
          n = "goBack";
          e = "goForward";
          l = "scrollPageDown";
          u = "scrollPageUp";
          f = "LinkHints.activateMode";
          p = "LinkHints.activateModeToOpenInNewTab";
        };
      };

      exclusionRules = [
        {
          passKeys = "";
          pattern = "https?://mail.google.com/*";
        }
        {
          passKeys = "n";
          pattern = "https?://focus.nirvanahq.com/*";
        }
        {
          passKeys = "n";
          pattern = "https?://app.mochi.cards/*";
        }
      ];
    };

    programs.nix-index = {
      enable = true;
      enableBashIntegration = true;
      # enableFishIntegration = true;
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    catppuccin = {
      enable = true;
      flavor = "mocha";
      starship.enable = true;
      kitty.enable = true;
      gtk.icon.enable = true;
      fzf.enable = true;
      bat.enable = true;
      cursors.enable = true;
    };

    programs.starship = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;

      # Configuration written to ~/.config/starship.toml
      settings = {
        add_newline = false;

        format = builtins.concatStringsSep "" [
          "$line_break"
          "$all"
        ];

        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };

        battery = {
          display = [
            {
              threshold = 30;
              style = "bold red";
            }
          ];
        };
      };
    };

    programs.btop = {
      enable = true;
    };
    programs.bat = {
      enable = true;
    };
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      git = true;
    };
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    programs.broot = {
      enable = true;
    };
  };
}

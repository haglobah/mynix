{ config, lib, pkgs, ...}:
{
  config = {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ".." = "cd ..";
        "cp" = "cp -i";
        "h" = "history";
        "l" = "lla";
        "lta" = "lt -la";
        "mv" = "mv -i";
        "rm" = "rm -i";
        "wh" = "type -a";
        "du" = "du -ach | sort -h";

        "grep" = "grep --color=auto";

        "g" = "git";
        "gi" = "git init";
        "ga" = "git add";
        "gu" = "git restore --staged";
        "gs" = "git status -s -b";
        "gbr" = "git branch -a -v";
        "gb" = "git for-each-ref --color --sort=-committerdate --format=$'%(color:green)%(ahead-behind:HEAD)\t%(color:blue)%(refname:short)\t%(color:yellow)%(committerdate:relative)\t%(color:default)%(describe)'     refs/ | sed 's/ /\t/' | column --separator=$'\t' --table --table-columns='Ahead,Behind,Branch Name,Last Commit,Description'";
        "gl" = "git log --oneline --decorate --graph";
        "gls" = "git log --graph --stat";
        "gcm" = "git commit -m";
        "gam" = "git add . && git commit -m";
        "gp" = "git push";
        "gpf" = "git push --force-with-lease";
        "gpu" = "git push --set-upstream";
        "gpo" = "git push --set-upstream origin";
        "gf" = "git pull";
        "gF" = "git fetch";
        "gun" = "git rm --cached";
        "gcb" = "git checkout -b";
        "gsw" = "git switch";
        "gco" = "git checkout";
        "gme" = "git merge";
        "gra" = "git remote add";
        "gro" = "git remote add origin";
        "grv" = "git remote --verbose";
        "gca" = "git commit --amend";
        "gcan" = "git commit --amend --no-edit";
        "gacan" = "git add . && git commit --amend --no-edit";
        "gd" = "git diff --word-diff";
        "gdl" = "git diff";
        "gst" = "git stash";
        "gsh" = "git show";
        "gmb" = "git checkout HEAD^";

        "n" = "nix";
        "ni" = "nix repl";
        "nix-list" = "nix profile history --profile /nix/var/nix/profiles/system";
        "nix-rm-boot-entries" = "nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 30d";
        "nre" = "sudo nixos-rebuild switch --flake .";
        "nure" = "nix flake update && sudo nixos-rebuild switch --flake .";
        "nsh" = "nix shell";

        "nf" = "nix flake";
        "nfc" = "nix flake check";
        "nft" = "nix flake init --template";
        "nfn" = "nix flake new --template";
        "nfs" = "nix flake show";
        "nfu" = "nix flake update";
        "nr" = "nix run";
        "nru" = "nix run . --";
        "nl" = "nix run -L . --";
        "nb" = "nix build";
        "nd" = "nix develop";

        "da" = "direnv allow";
        "dr" = "direnv reload";

        "e" = "emacs";
        "c" = "code . &";
        
        "hm" = "home-manager";
        "hsw" = "home-manager switch --flake .";
        "reload" = ". ~/.bash_profile";
      };

      initExtra = ''
        md () {
          mkdir -p -- "$1" && cd -P -- "$1"
        } 

        freq () {
          history | cut -c8- | cut -d" " --fields=1"$1" | sort | uniq -c | sort -rn
        }

        gap () {
          git add . && git commit --message="$1" && git push 
        }
        gm () {
          git add "''${@:2}" && git commit --message="$1"
        }
        gcl () {
          git clone "$1" && cd "$(basename "$1" .git)"
        }
        gmf () {
          git checkout $(git rev-list --topo-order HEAD..''${1:-main})
        }

        export PATH="$PATH:~/.config/emacs/bin"
        export PATH="$PATH:~/.emacs.d/bin"
        export EDITOR="emacs"

        # if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        # then
        #   shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        #   exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        # fi
      '';
    };
  };
}
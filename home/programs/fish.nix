{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        "n" = "nix";
        "ni" = "nix repl";
        "nix-list" = "nix profile history --profile /nix/var/nix/profiles/system";
        "nix-rm-boot-entries" =
          "nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 30d";
        "rebuild" = "sudo nixos-rebuild switch --flake .";
        "nre" = "sudo nixos-rebuild switch --flake ~/mynix/";
        "nure" = "nix flake update && sudo nixos-rebuild switch --flake ~/mynix/";
        "nsh" = {
          expansion = "nix shell n#% -c fish";
          setCursor = true;
        };
        "nsu" = {
          expansion = "NIXPKGS_ALLOW_UNFREE=1 nix shell n#% --impure -c fish";
          setCursor = true;
        };

        "nf" = "nix flake";
        "nfc" = "nix flake check";
        "nft" = "nix flake init --template";
        "nfn" = {
          expansion = "nix flake new % --template";
          setCursor = true;
        };
        "nfs" = "nix flake show";
        "nfu" = "nix flake update";
        "nr" = "nix run";
        "nra" = "nix run . --";
        "nrn" = {
          expansion = "nix run n#%";
          setCursor = true;
        };
        "nru" = {
          expansion = "NIXPKGS_ALLOW_UNFREE=1 nix run n#% --impure";
          setCursor = true;
        };
        "nl" = "nix run -L . --";
        "nb" = "nix build";
        "nd" = {
          expansion = "nix develop % -c fish";
          setCursor = true;
        };

        "nrd" = "npm run dev";
        "nrp" = "npm run playground";

        "c" = "code . &";
        "v" = "nvim .";
        "e" = "emacs . &";
        "h" = "history";
        "rg" = "rg --line-number --context=2";
        "wh" = "which";
        "wha" = "type --all";

        "ae" = {
          expansion = "cd ~/nix-home/secrets/ && agenix --edit % && cd -";
          setCursor = true;
        };
        "ad" = {
          expansion = "cd ~/nix-home/secrets/ && agenix --decrypt % && cd -";
          setCursor = true;
        };

        "j" = "just";
        "js" = "just setup";
        "jd" = "just dev";
        "jr" = "just run";
        "jb" = "just build";
        "ja" = "just all";
        "jt" = "just test";
        "joc" = "just open chromium";
        "jod" = "just open chromium && just dev";

        "k" = "kubectl";
        "kg" = "kubectl get";
        "kd" = "kubectl describe";
        "ke" = "kubectl exec";

        "wm" = "wt remote";
        "ww" = "wt work";
        "ws" = "wt scratch";

        "g" = "git";
        "gi" = "git init";
        "gim" = "git init && git add . && git commit --message \"Initial commit\"";
        "gclo" = "git clone";
        "ga" = "git add";
        "gs" = "git status --short --branch";
        "gbr" = "git branch --all --verbose";
        "gbu" = "git branch --set-upstream-to=origin/(git_branch_name) (git_branch_name)";
        "gbm" = "git branch --move";
        "gcm" = "git commit --message";
        "gam" = "git add . && git commit --message";
        "gab" = "git add . && git commit --message 'Add content' && git push";
        "gp" = "git push";
        "gpf" = "git push --force-with-lease";
        "gpu" = "git push --set-upstream";
        "gpo" = "git push --set-upstream origin";
        "gpb" = "git push --set-upstream origin (git_branch_name)";
        "gf" = "git pull";
        "gfa" = "git fetch --all";
        "gfap" = "git fetch --all --prune";
        "gr" = "git remote";
        "gra" = "git remote add";
        "grr" = "git remote remove";
        "gro" = "git remote add origin";
        "grv" = "git remote --verbose";
        "gca" = "git commit --amend";
        "gcan" = "git commit --amend --no-edit";
        "gacan" = "git add . && git commit --amend --no-edit";
        "gd" = "git diff --word-diff";
        "gst" = "git stash";

        "gw" = "git worktree";
        "gwa" = "git worktree add";
        "gwr" = "git worktree remove";
        "gwl" = "git worktree list";

        "gre" = "git restore";
        "gu" = "git restore --staged";
        "gun" = "git rm --cached";
        "gsw" = "git switch";
        "gs-" = "git switch -";
        "gsc" = "git switch --create";
        "gco" = "git checkout";
        "gme" = "git merge";
        "gmb" = "git checkout HEAD^";
        "gl" = "git log --oneline --decorate --graph";
        "gls" = "git log --graph --stat";
        "gld" =
          "git -c color.ui=always log --graph --pretty=format:'%C(yellow)%h%C(auto) %d %s}%C(green)%cr%C(reset) | %C(blue)%an%C(reset)' --abbrev-commit --date=relative | column --separator '}' --table | less";
        "gsh" = "git show";

        "ghi" = {
          expansion = "gh repo create % --private --source=. --remote=origin";
          setCursor = true;
        };
        "gho" = {
          expansion = "gh repo create % --private --source=. --remote=origin && git push --set-upstream origin main";
          setCursor = true;
        };
        "ghp" = {
          expansion = "gh repo create % --public --source=. --remote=origin && git push --set-upstream origin main";
          setCursor = true;
        };

        "np" = "nix run github:haglobah/templater -Lv -- --to";
        "uf" = "echo \"use flake . -Lv\" >> .envrc";
        "ud" = "echo \"use flake . -Lv\" >> .envrc && direnv allow";
        "uda" = "git add flake.nix && echo \"use flake . -Lv\" >> .envrc && direnv allow";
        "da" = "direnv allow";
        "dr" = "direnv reload";

        "ds" = "doom sync";

        "hm" = "home-manager";
        "hsw" = "home-manager switch --flake .";
        "hs" = "home-manager switch --flake ~/nix-home/";
        "reload" = "source ~/.config/fish/config.fish";
      };
      shellAliases = {
        ".." = "cd ..";
        "cp" = "cp -i";
        "l" = "lla";
        "lta" = "lt -la";
        "mv" = "mv -i";
        "rm" = "rm -i";
        "du" = "du -ach | sort -h";
      };

      shellInit = ''
        function md
          mkdir -p $argv[1] && cd $argv[1]
        end

        function freq
          history | cut -c8- | cut -d" " --fields=1"$argv[1]" | sort | uniq -c | sort -rn
        end

        function gap
          git add . && git commit --message="$argv[1]" && git push
        end

        function gcl
          git clone $argv[1] && cd (string split : (basename $argv[1] .git))[-1]
        end

        function gcw
          set --function link $argv[1]

          if test (count $argv) -eq 1
            set --function folder_name (string split : (basename $argv[1] .git))[-1]
          else if test (count $argv) -eq 2
            set --function folder_name $argv[2]
          else
            echo "Wrong number of arguments"
            return 1
          end

          git clone $link $folder_name/work
          cd $folder_name/work

          git worktree add ../remote
          git worktree add ../scratch

        end

        function gc
          gcw $argv
        end

        function wt --description "Switch to a git worktree"
          # Get the list of worktrees
          set worktree_info (git worktree list | grep "/$argv[1] ")

          if test -z "$worktree_info"
              echo "Worktree '$argv[1]' not found."
              echo "Available worktrees:"
              git worktree list | cut -d' ' -f1 | xargs -n1 basename
              return 1
          end

          # Extract the path (first column)
          set worktree_path (echo $worktree_info | cut -d' ' -f1)
          cd $worktree_path
        end

        function gm
          git add ''$argv[2..-1]
          git commit --message="$argv[1]"
        end

        function gmf
          git checkout (git rev-list --topo-order HEAD..''$argv[1] | string collect; or echo)
        end

        function git_branch_name
          git rev-parse --abbrev-ref HEAD
        end

        function gb
          git for-each-ref --color --sort=-committerdate --format='%(color:green)%(ahead-behind:HEAD)%(color:reset)*%(color:blue)%(refname:short)%(color:reset)*%(color:yellow)%(committerdate:relative)%(color:reset)*%(describe)' refs/ | column --separator='*' --table --table-columns='Ahead-Behind,Branch Name,Last Commit,Description'
        end

        # bind " " expand-abbr or self-insert

        set -gx PATH $PATH "/home/beat/.config/emacs/bin"
        set -gx EDITOR "nvim"

        # for automatically adding completions from a Justfile (if supplied there as `_dev-complete`)
        complete --command just --condition '__fish_seen_subcommand_from dev' --arguments '(just _dev-complete)'
      '';
    };
  };
}

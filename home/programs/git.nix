{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    programs.git = {
      enable = true;
      includes = [
        {
          condition = "gitdir:~/ag/";
          contents = {
            user.email = "beat.hagenlocher@active-group.de";
          };
        }
      ];
      ignores = [
        ".envrc"
        ".direnv/"

        ".calva"

        # Emacs
        "*~"
        "\\#*\\#"
        ".\\#*"
        ".dir-locals.el"
      ];
      settings = {
        user.email = "bah@posteo.de";
        user.name = "Beat Hagenlocher";
        color.ui = "auto";
        core.sshCommand = "ssh -i ~/.ssh/id_rsa -i ~/.ssh/id_ed25519 2> /dev/null";
        init.defaultBranch = "main";
        checkout.defaultRemote = "origin";
        rerere.enabled = true;
        branch.sort = "-committerdate";
        diff = {
          algorithm = "histogram";
          mnemonicPrefix = true;
          renames = true;
        };
        merge.conflictStyle = "zdiff3";
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };
        url = {
          "https://github.com/" = {
            insteadOf = "gh:";
          };
          "git@github.com:" = {
            insteadOf = "gs:";
          };
          "git@github.com:haglobah/" = {
            insteadOf = "bah:";
          };
          "https://gitlab.com/" = {
            insteadOf = "gl:";
          };
          "git@gitlab.active-group.de:ag/" = {
            insteadOf = "ag:";
          };
          "git@github.com:active-group/" = {
            insteadOf = "agh:";
          };
        };
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = {
    programs.mbsync.enable = true;
    programs.msmtp.enable = true;
    programs.mu.enable = true;
    accounts.email.accounts = {
      ag = rec {
        address = "beat.hagenlocher@active-group.de";
        realName = "Beat Hagenlocher";
        userName = address;
        passwordCommand = "cat ~/.agpassword";
        imap = {
          host = "mail.active-group.de";
          port = null;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
        smtp = {
          host = "mail.active-group.de";
          port = null;
        };

        mbsync = {
          enable = true;
          create = "both";
          remove = "both";
          expunge = "both";
          patterns = [
            "*"
            "!Drafts"
            "!Deleted Messages"
          ];
        };
        mu.enable = true;
        msmtp = {
          enable = true;
          extraConfig = {
            "syslog" = "LOG_USER";
          };
        };
      };
      posteo = {
        primary = true;
        address = "hagenlob@posteo.de";
        realName = "Beat Hagenlocher";
        userName = "hagenlob@posteo.de";
        passwordCommand = "cat ~/.posteopassword";
        signature = {
          text = ''
            Liebe Grüße
            Beat Hagenlocher
          '';
          showSignature = "append";
        };

        imap = {
          host = "posteo.de";
          port = 993;
          tls.enable = true;
        };
        smtp = {
          host = "posteo.de";
          port = 465;
          tls.enable = true;
        };

        mbsync = {
          enable = true;
          create = "both";
          remove = "both";
          expunge = "both";
          patterns = [
            "*"
            "!Drafts"
            "!Deleted Messages"
          ];
        };
        msmtp.enable = true;
        mu.enable = true;
      };
    };
  };
}

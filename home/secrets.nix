{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = {
    age = {
      secrets = {
        openai-api-key.file = ./secrets/openai-api-key.age;
        anthropic-api-key.file = ./secrets/anthropic-api-key.age;
        google-api-key.file = ./secrets/google-api-key.age;
        bluesky-app-secret.file = ./secrets/bluesky-app-secret.age;
        timetracking-secret.file = ./secrets/timetracking-secret.age;
        arbeitszeiten-secret.file = ./secrets/arbeitszeiten-secret.age;
        abrechenbare-zeiten-secret.file = ./secrets/abrechenbare-zeiten-secret.age;
      };

      identityPaths = [
        "/home/beat/.ssh/id_rsa"
        "/home/beat/.ssh/id_ed25519"
      ];
    };

    home.sessionVariables = {
      OPENAI_API_KEY = "$(cat ${config.age.secrets.openai-api-key.path})";
      ANTHROPIC_API_KEY = "$(cat ${config.age.secrets.anthropic-api-key.path})";
      GOOGLE_API_KEY = "$(cat ${config.age.secrets.google-api-key.path})";
      BLUESKY_APP_SECRET = "$(cat ${config.age.secrets.bluesky-app-secret.path})";
      TIMETRACKING_SECRET = "$(cat ${config.age.secrets.timetracking-secret.path})";
    };
  };
}

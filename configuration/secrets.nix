{ config, ... }:
{
  config = {
    age = {
      secrets = {
        storage-box-secret.file = ../secrets/storage-box-secret.age;
        openai-api-key = {
          file = ../secrets/openai-api-key.age;
          owner = "beat";
        };
        anthropic-api-key = {
          file = ../secrets/anthropic-api-key.age;
          owner = "beat";
        };
        bluesky-app-secret = {
          file = ../secrets/bluesky-app-secret.age;
          owner = "beat";
        };
        timetracking-secret = {
          file = ../secrets/timetracking-secret.age;
          owner = "beat";
        };
        timereporting-secret = {
          file = ../secrets/timereporting-secret.age;
          owner = "beat";
        };
      };

      identityPaths = [
        "/home/beat/.ssh/id_rsa"
        "/home/beat/.ssh/id_ed25519"
      ];
    };

    environment.sessionVariables = {
      OPENAI_API_KEY = "$(cat ${config.age.secrets.openai-api-key.path})";
      ANTHROPIC_API_KEY = "$(cat ${config.age.secrets.anthropic-api-key.path})";
      BLUESKY_APP_SECRET = "$(cat ${config.age.secrets.bluesky-app-secret.path})";
      TIMETRACKING_SECRET = "$(cat ${config.age.secrets.timetracking-secret.path})";
      TIMEREPORTING_SECRET = "$(cat ${config.age.secrets.timereporting-secret.path})";
    };
  };
}

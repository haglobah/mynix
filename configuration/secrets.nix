{ config, ... }:
{
  config = {
    age = {
      secrets = {
        storage-box-secret.file = ../secrets/storage-box-secret.age;
      };

      identityPaths = [
        "/home/beat/.ssh/id_rsa"
        "/home/beat/.ssh/id_ed25519"
      ];
    };

  };
}

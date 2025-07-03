{ config, pkgs, ... }:
{
  config = {
    networking.hostName = "gondor";

    networking.nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    networking.networkmanager.dns = "none";

    environment.systemPackages = [
    ];
  };
}

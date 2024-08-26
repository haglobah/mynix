{ config, pkgs, ... }:
{
  config = {
    networking.hostName = "gondor";

    environment.systemPackages = [
      pkgs.linphone
    ];
  };
}

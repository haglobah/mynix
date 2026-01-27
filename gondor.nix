{ config, pkgs, ... }:
{
  config = {
    networking.hostName = "gondor";

    boot.kernelParams = [
      # router can't do ipv6 at home
      "ipv6.disable=1"
      # https://www.reddit.com/r/framework/comments/1goh7hc/anyone_else_get_this_screen_flickering_issue/
      "amdgpu.dcdebugmask=0x410"
    ];

    # Makes Roßleben school network work
    # networking.nameservers = [
    #   "1.1.1.1"
    #   "8.8.8.8"
    # ];
    # networking.networkmanager.dns = "none";

    environment.systemPackages = [
    ];
  };
}

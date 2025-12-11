{ config, lib, pkgs, inputs, ...}:
{
  config = {
    nix.registry = {
      my = {
        from = {
          id = "my";
          type = "indirect";
        };
        to = {
          owner = "haglobah";
          repo = "flakes";
          type = "github";
        };
      };
      n = {
        from = {
          id = "n";
          type = "indirect";
        };
        to = {
          type = "tarball";
          url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*.tar.gz";
        };
      };
      nu = {
        from = {
          id = "nu";
          type = "indirect";
        };
        to = {
          type = "github";
          owner = "nixos";
          repo = "nixpkgs";
          ref = "nixos-unstable";
        };
      };
      this.flake = inputs.nixpkgs;
    };
  };
}

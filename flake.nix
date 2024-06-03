{
  description = "My NixOS config flake";

  nixConfig = {
    extra-substituters = [
      "https://cache.lix.systems"
    ];
    extra-trusted-public-keys = [
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];
  };

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    lix = {
      url = "git+https://git.lix.systems/lix-project/lix?ref=refs/tags/2.90-beta.1";
      flake = false;
    };
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.lix.follows = "lix";
      inputs.nixpkgs.follows = "nixpkgs";
    };    
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, lix-module, agenix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      numenor = lib.nixosSystem {
        inherit system;
        modules = [ 
          lix-module.nixosModules.default
          ./configuration.nix
          ./hardware/numenor.nix
          ./numenor.nix
          agenix.nixosModules.default
        ];
      };
      eriador = lib.nixosSystem {
        inherit system;
        modules = [ 
          lix-module.nixosModules.default
          ./configuration.nix
          ./hardware/eriador.nix
          ./eriador.nix
          agenix.nixosModules.default
        ];
      };
      gondor = lib.nixosSystem {
        inherit system;
        modules = [
          lix-module.nixosModules.default
          ./configuration.nix
          ./hardware/gondor.nix
          ./gondor.nix
          agenix.nixosModules.default
        ];
      };
    };
  };
}

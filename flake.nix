{
  description = "My NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/7940a560bd61cb0313bf2dfdc64764856aff9d9c";
    
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, agenix }:
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
          ./configuration.nix
          ./hardware/numenor.nix
          ./numenor.nix
          agenix.nixosModules.default
        ];
      };
      eriador = lib.nixosSystem {
        inherit system;
        modules = [ 
          ./configuration.nix
          ./hardware/eriador.nix
          ./eriador.nix
          agenix.nixosModules.default
        ];
      };
    };
  };
}

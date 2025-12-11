{
  description = "My NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-24-11.url = "github:nixos/nixpkgs?ref=nixos-24.11";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    # Setting up nix-index for the `nix-locate` command
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    alles = {
      url = "github:haglobah/alles";
    };

    # nix-starter-kit = {
    #   url = "github:active-group/nix-starter-kit";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      agenix,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = [
          # use lix instead of nix
          # (final: prev: {
          #   inherit (final.lixPackageSets.stable)
          #     nixpkgs-review
          #     nix-direnv
          #     nix-eval-jobs
          #     nix-fast-build
          #     colmena
          #     ;
          # })
          (final: prev: {
            alles = inputs.alles.packages.${system}.default;
          })
          inputs.agenix.overlays.default
        ];
      };
      lib = nixpkgs.lib;
    in
    {
      devShells.${system}.default = pkgs.mkShell { packages = [ pkgs.nixfmt-rfc-style ]; };
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
        gondor = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./hardware/gondor.nix
            ./gondor.nix
            home-manager.nixosModules.home-manager
            ./the-home.nix
            agenix.nixosModules.default
          ];
        };
      };
    };
}

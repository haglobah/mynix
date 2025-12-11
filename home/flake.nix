{
  description = "Home Manager configuration of beat";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-24-11.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-starter-kit = {
      url = "github:active-group/nix-starter-kit";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            alles = inputs.alles.packages.${system}.default;
          })
          inputs.agenix.overlays.default
        ];
      };

    in
    {
      devShells.${system}.default = pkgs.mkShell { packages = [ pkgs.nixfmt-rfc-style ]; };
      homeConfigurations."beat" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs; };
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          inputs.nix-index-database.homeModules.nix-index
          inputs.catppuccin.homeModules.catppuccin
          inputs.agenix.homeManagerModules.default
          inputs.nix-starter-kit.homeModules.timetracking
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        # extraSpecialArgs = {
        #   stuff = "stuff";
        # };
        # And I can get them back in home.nix via config.stuff. Nice!
      };
    };
}

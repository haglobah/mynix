{
  inputs,
  ...
}:

{
  home-manager.users."beat" =
    {
      pkgs,
      config,
      ...
    }:
    {
      _module.args = { inherit inputs; };
      imports = [
        inputs.nix-index-database.homeModules.nix-index
        inputs.catppuccin.homeModules.catppuccin
        inputs.agenix.homeManagerModules.default
        inputs.nix-starter-kit.homeModules.timetracking
        ./home/home.nix
      ];

    };
}

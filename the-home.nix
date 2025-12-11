{
  inputs,
  ...
}:

{
  home-manager.users."beat" =
    {
      inputs,
      pkgs,
      config,
      ...
    }:
    {
      modules = [
        ./home/home.nix
        inputs.nix-index-database.homeModules.nix-index
        inputs.catppuccin.homeModules.catppuccin
        inputs.agenix.homeManagerModules.default
        inputs.nix-starter-kit.homeModules.timetracking
      ];
    };
}

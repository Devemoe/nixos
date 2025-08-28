{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astronvim = {
      url = "github:AstroNvim/template";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, astronvim, ... } @ inputs:
  let
    user = "Devemoe";
    hostname = "MoeOS";
    stateVersion = "25.05";
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in
  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      modules = [ ./nixos/modules ];
      specialArgs = { inherit inputs user hostname stateVersion; };
      inherit pkgs;
    };
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      modules = [ ./home-manager/home.nix ];
      extraSpecialArgs = { inherit inputs user hostname stateVersion; };
      inherit pkgs;
    };
  };
}

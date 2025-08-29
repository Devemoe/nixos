{
  description = "MoeOS";

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

  outputs = { self, nixpkgs, home-manager, astronvim, ... } @ inputs:
  let
    user = "Devemoe";

    hosts = [
      { hostname = "MoeLaptop"; system = "x86_64-linux"; stateVersion = "25.05"; }
    ];

    makeSystem = { hostname, system, stateVersion }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs user hostname system stateVersion;
      };

      modules = [
        ./hosts/${hostname}
        ./nixos/modules
        
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.${user} = ./home-manager/home.nix;
            extraSpecialArgs = {
              inherit inputs user stateVersion;
            };
          };
        }
      ];
    };
  in

  {
    nixosConfigurations = builtins.listToAttrs (map (host: {
      name = host.hostname;
      value = makeSystem {
        inherit (host) hostname system stateVersion;
      };
    }) hosts);
  };
}

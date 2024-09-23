{
  description = "flake for zlalanne machines";
  inputs = {
    nixpkgs = {
      url = "github:NixOs/nixpkgs/nixos-24.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOs/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in
    {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      };
    };
}

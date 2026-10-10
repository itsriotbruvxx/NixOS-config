{
  description = "A not so basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26-05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... } @ inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { };
      modules = [
        ./configuration.nixos

      ];
    };
  };
}

{
  description = "iancleary's example config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }:
  {
    nixosModules.default = import ./default.nix;
    nixosModules.home-manager = import ./default.nix;
  };
}

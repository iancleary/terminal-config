{
  description = "iancleary's example config";

  inputs = {
    # flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #home-manager.url = "github:nix-community/home-manager";
    #home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-plugins = {
      url = "github:LongerHV/neovim-plugins-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self
    # , flake-utils
    , nixpkgs
    , nixpkgs-unstable
    #, home-manager
    , neovim-plugins
  }:
  let
    overlays = {
      unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        inherit (nixpkgs-unstable.legacyPackages.${prev.system}) neovim-unwrapped;
      };
      neovimPlugins = neovim-plugins.overlays.defaulti;
    };

    legacyPackages = builtins.currentSystem (system:
      import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
          config.allowUnfree = true;
        }
    );
in
  {
    homeManagerModules.default = import ./default.nix;
    homeManagerModules.home-manager = import ./default.nix;
  };
}

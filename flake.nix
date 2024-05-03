{
  description = "iancleary's example config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-plugins = {
      url = "github:LongerHV/neovim-plugins-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self
    , nixpkgs
    , nixpkgs-unstable
    , neovim-plugins
  }:
  let
    overlays = {
      unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        inherit (nixpkgs-unstable.legacyPackages.${prev.system}) neovim-unwrapped;
      };
      neovimPlugins = neovim-plugins.overlays.default;
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
    overlays.default = neovim-plugins.overlays.default; # pass through the neovim-plugins overlay
    homeManagerModules.default = import ./default.nix;
    homeManagerModules.home-manager = import ./default.nix;
  };
}

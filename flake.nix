{
  description = "iancleary's terminal configuration (neovim, git, zsh, etc.)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    ## neovim-plugins
    # neotree
    neotree = {
      url = "github:nvim-neo-tree/neo-tree.nvim";
      flake = false;
    };
    devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    ##lsp
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    # theme
    oceanic-next = {
      url = "github:mhartington/oceanic-next";
      flake = false;
    };
    # search
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    telescope-file-browser = {
      url = "github:nvim-telescope/telescope-file-browser.nvim";
      flake = false;
    };
    mini = {
      url = "github:echasnovski/mini.nvim";
      flake = false;
    };
    indent-blankline = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    dressing = {
      url = "github:stevearc/dressing.nvim";
      flake = false;
    };
    oil = {
      url = "github:stevearc/oil.nvim";
      flake = false;
    };
    schemastore = {
      url = "github:b0o/SchemaStore.nvim";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    lspkind-nvim = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , neotree
    , nui
    , nvim-lspconfig
    , plenary
    , oceanic-next
    , telescope
    , telescope-file-browser
    , mini
    , indent-blankline
    , devicons
    , gitsigns
    , dressing
    , oil
    , schemastore
    , nvim-cmp
    , cmp-buffer
    , cmp-nvim-lsp
    , cmp-path
    , lspkind-nvim
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "aarch64-linux" "x86_64-linux" ];
      overlays = {
        unstable = final: prev: {
          unstable = nixpkgs-unstable.legacyPackages.${prev.system};
          inherit (nixpkgs-unstable.legacyPackages.${prev.system}) neovim-unwrapped;
        };
        neovimPlugins = final: prev:
          let
            mkPlugin = name: value:
              prev.pkgs.vimUtils.buildVimPlugin {
                pname = name;
                version = value.lastModifiedDate;
                src = value;
              };
            plugins = prev.lib.filterAttrs (name: _: name != "self" && name != "nixpkgs" && name != "nixpkgs-unstable") inputs;
          in
          {
            nvimPlugins = builtins.mapAttrs mkPlugin plugins;
          };
      };
    in
    {
      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
          config.allowUnfree = true;
        }
      );
      overlays.default = overlays.neovimPlugins;
      homeManagerModules.default = import ./default.nix;
      homeManagerModules.home-manager = import ./default.nix;

      devShells = forAllSystems (system: {
        lint = nixpkgs.legacyPackages.${system}.callPackage ./shells/lint.nix { };
      });

      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);
      nixosConfigurations.test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ pkgs, ... }: {
            boot.isContainer = true;
            nixpkgs.overlays = [ overlays.neovimPlugins ];
            system.stateVersion = "24.05";
            programs.neovim = {
              enable = true;
              configure.packages.myVimPackage = {
                opt = builtins.attrValues pkgs.nvimPlugins;
              };
            };
          })
        ];
      };
    };
}

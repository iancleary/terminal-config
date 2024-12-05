{ config, lib, pkgs, ... }@args:

let
  cfg = config.myTerminal.neovim;
  importPlugins = plugins: (map (path: import path args) plugins);
  plugins = (importPlugins [
    ./telescope.nix
    ./treesitter.nix
  ]) ++ [
    {
      plugin = pkgs.nvimPlugins.mini;
      configFile = ./mini.lua;
    }
    {
      plugin = pkgs.nvimPlugins.indent-blankline;
      main = "ibl";
      opts.scope.enabled = false;
    }
    { plugin = pkgs.nvimPlugins.oceanic-next; }
    { plugin = pkgs.nvimPlugins.neotree; 
      opts = {
        close_if_last_window = false; # -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded";
        enable_git_status = true;
        enable_diagnostics = true;
        };
    }
    { plugin = pkgs.nvimPlugins.nui; }
    { plugin = pkgs.nvimPlugins.devicons; }
    { plugin = pkgs.nvimPlugins.gitsigns; opts = { }; }
    { plugin = pkgs.nvimPlugins.dressing; opts = { }; }
    {
      plugin = pkgs.nvimPlugins.oil;
      opts.view_options.show_hidden = true;
      postConfig = ''
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      '';
    }
    { plugin = pkgs.vimPlugins.vim-sleuth; }
  ];
  lspPlugins = importPlugins [
    ./lspconfig.nix
    ./cmp.nix
  ];
in
{
  config = lib.mkIf cfg.enable {
    myTerminal.neovim.plugins = plugins ++ (lib.lists.optionals cfg.enableLSP lspPlugins);
  };
}

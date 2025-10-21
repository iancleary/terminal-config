{ pkgs, ... }:

{
  plugin = pkgs.nvimPlugins.nvim-cmp;
  configFile = ./cmp.lua;
  enable = true;
  dependencies = with pkgs.nvimPlugins; [
    cmp-nvim-lsp
    cmp-path
    cmp-buffer
    lspkind-nvim
  ];
}

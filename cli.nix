{ config, lib, pkgs, ... }:

let
  cfg = config.myTerminal.cli;
in
{
  options.myTerminal.cli = {
    enable = (lib.mkEnableOption "cli") // { default = true; };
    personalGitEnable = (lib.mkEnableOption "personalGitEnable") // { default = true; };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      gh.enable = true;
      zsh.shellAliases = {
        lg = "lazygit";
      };
      git = {
        enable = true;
        userName = lib.mkIf cfg.personalGitEnable "iancleary";
        userEmail = lib.mkIf cfg.personalGitEnable "github@iancleary.me";
      };
    };
    home.packages = with pkgs; [
      bat
      colordiff
      curl
      unstable.eza
      file
      fzf
      htop
      lazygit
      jq
      unstable.just
      neofetch
      nix-tree
      openssh
      p7zip
      ranger
      sd
      tree
      unzip
      wget
      xh
      yj
      yq

      # core
      nodejs_22
      unstable.pnpm
      unstable.bun
      rustup
      unstable.uv
    ];
  };
}

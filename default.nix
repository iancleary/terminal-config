{
  imports = [
    ./cli.nix
    ./neovim
    ./tmux.nix
    ./zsh
  ];

  myTerminal = {
    neovim = {
      enable = true;
      enableLSP = true;
    };
    zsh.enable = true;

  };
}

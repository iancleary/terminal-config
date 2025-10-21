{
  imports = [
    ./cli.nix
    ./tmux.nix
    ./zsh
  ];

  myTerminal = {
    zsh.enable = true;

  };
}

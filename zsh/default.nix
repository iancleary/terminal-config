{ lib, pkgs, ... }:

{
  options.myTerminal.zsh = with lib; {
    enable = mkEnableOption "zsh";
  };
  config = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    home = {
      file.".p10k.zsh".source = ./.p10k.zsh;
      file.".p10k.zsh".target = ".p10k.zsh";
    };

    programs.zsh = {
      enable = true;
      shellAliases = {
        l = "eza -alh --icons=auto";
        ll = "eza -l --icons=auto";
        la = "eza -la --icons=auto";
        ls = "eza --icons=auto";
        hg = "history|grep"; # search bash history, I swapped the letters for github-cli compatibility
        left = "eza -t -1"; # most recently edited files
        cg = "cd `git rev-parse --show-toplevel`"; # go to git main level
        n = "nvim";
        p = "pnpm";
        prd = "pnpm run dev";
        prb = "pnpm run build";
        prs = "pnpm run start";
        pi = "pnpm install";
        pa = "pnpm add";
        pad = "pnpm add --save-dev";
        pap = "pnpm add --save-peer";
        b = "bun";
        brd = "bun run dev";
        brb = "bun run build";
        brs = "bun run start";
        bi = "bun install";
        ba = "bun add";
        bad = "bun add -d";
        bao = "bun add --optional";
        bap = "bun add --peer";
        d = "docker";
        dc = "docker container";
        di = "docker image";
        dils = "docker image ls";
        dirm = "docker image rm";
        dcls = "docker container ls";
        dcs = "docker container stop";
        c = "cargo";
        j = "just";
      };

      # // use mkMerge
      # https://mynixos.com/home-manager/option/programs.zsh.initContent
      initContent =
        let
          zshConfigEarlyInit = lib.mkOrder 500 ''
            # Completion
            zstyle ':completion:*' menu yes select

            # Prompt
            autoload -U promptinit; promptinit

            # SSH
            eval $(ssh-agent)
            [[ ! -f ~/.ssh/github_id_ed25519 ]] || ssh-add ~/.ssh/github_id_ed25519

            # Load NVM
            [[ ! -f /usr/share/nvm/init-nvm.sh ]] || source /usr/share/nvm/init-nvm.sh
          '';
          zshConfig = lib.mkOrder 1000 ''
            source ${./git.zsh}

            bindkey '^[[Z' reverse-menu-complete

            # Workaround for ZVM overwriting keybindings
            zvm_after_init_commands+=("bindkey '^[[A' history-substring-search-up")
            zvm_after_init_commands+=("bindkey '^[OA' history-substring-search-up")
            zvm_after_init_commands+=("bindkey '^[[B' history-substring-search-down")
            zvm_after_init_commands+=("bindkey '^[OB' history-substring-search-down")

            ####
            # On each machine, run p10k configure once.  That should create ~/.p10k.zsh with my preferences.
            ####
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
            # setopt auto_cd
          '';
        in
        lib.mkMerge [ zshConfigEarlyInit zshConfig ];
      localVariables = {
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=13,underline";
        ZSH_AUTOSUGGEST_STRATEGY = [ "history" "completion" ];
        KEYTIMEOUT = 1;
        ZSHZ_CASE = "smart";
        ZSHZ_ECHO = 1;
      };
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      enableVteIntegration = true;
      historySubstringSearch = {
        enable = true;
        # searchUpKey = [ "^[[A" "^[OA" ];
        # searchDownKey = [ "^[[B" "^[OB" ];
      };

      # https://discourse.nixos.org/t/using-an-external-oh-my-zsh-theme-with-zsh-in-nix/6142/2
      plugins = [
        {
          name = "nix-shell";
          src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
        }
        {
          name = "you-should-use";
          src = "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use";
        }
        {
          name = "zsh-vi-mode";
          src = "${pkgs.unstable.zsh-vi-mode}/share/zsh-vi-mode";
        }
        {
          name = "zsh-z";
          src = "${pkgs.zsh-z}/share/zsh-z";
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
    };
  };
}

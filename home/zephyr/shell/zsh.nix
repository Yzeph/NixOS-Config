{ pkgs, ... }: {
  home.packages = with pkgs; [
    zsh-powerlevel10k
    zsh-completions
    nix-zsh-completions
  ];

  home.file.".p10k.zsh".source = ./p10k.zsh;

  programs.starship.enable = false;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      share = true;
    };

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      lta = "ls --tree --long --icons";
      ip = "ip --color=auto";
      grep = "grep --color=auto";

      nv = "nvim";
      snv = "sudo nvim";
      ff = "fastfetch";
      lg = "lazygit";

      proxy = "export http_proxy=http://127.0.0.1:7897 https_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897 no_proxy='localhost,127.0.0.1,::1,.local'";
      unproxy = "unset http_proxy https_proxy all_proxy";
      proxy_status = "env | grep -E 'proxy|PROXY'";

      nrs = "sudo nixos-rebuild switch --flake .#zephyr";
      nlg = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      ncg = "sudo nix-collect-garbage -d";
      nopt = "sudo nix-store --optimise";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "extract"
        "z"
        "colored-man-pages"
      ];
    };

    initContent = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      [ -f ~/.zsh_secrets ] && source ~/.zsh_secrets
      [ -f ~/.zsh_local ] && source ~/.zsh_local

      bindkey '^[[A' up-line-or-search
      bindkey '^[[B' down-line-or-search
    '';
  };
}

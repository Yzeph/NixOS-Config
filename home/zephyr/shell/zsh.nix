{pkgs, ...}: {
  # 软件包安装
  home.packages = with pkgs; [
    zsh-powerlevel10k
    zsh-completions
    nix-zsh-completions
  ];

  # 配置文件关联
  home.file.".p10k.zsh".source = ./p10k.zsh;

  # 禁用其他冲突提示符
  programs.starship.enable = false;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # 历史记录优化
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      share = true;
    };

    # 别名优化
    shellAliases = {
      # 基础命令增强
      ll = "ls -l";
      la = "ls -la";
      lta = "ls --tree --long --icons";
      ip = "ip --color=auto";
      grep = "grep --color=auto";
      
      # 开发工具
      nv = "nvim";
      snv = "sudo nvim";
      ff = "fastfetch";
      lg = "lazygit";
      
      # NixOS 维护命令
      nrs = "sudo nixos-rebuild switch --flake .#cook";
      nlg = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      ncg = "sudo nix-collect-garbage -d";
      nopt = "sudo nix-store --optimise"; # 优化存储（去重）
    };

    # Oh My Zsh 框架
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "extract"
        "z"
        "colored-man-pages" # 给 man 手册着色
      ];
    };

    # 脚本初始化
    initExtra = ''
      # 1. 优先加载 Powerlevel10k 瞬时提示以提高启动速度
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # 2. 加载 Powerlevel10k 主题
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      # 3. 本地化与密钥配置
      [ -f ~/.zsh_secrets ] && source ~/.zsh_secrets
      [ -f ~/.zsh_local ] && source ~/.zsh_local
      
      # 智能加载 Agenix 密钥
      if [ -f /run/agenix/ai_api_key ]; then
        # 尝试以 export 模式 source (处理 KEY=VAL 格式)
        set -a
        . /run/agenix/ai_api_key
        set +a
        # 如果 source 失败且文件不为空，则直接 cat 给 AI_API_KEY (处理纯文本格式)
        if [ -z "$AI_API_KEY" ]; then
           export AI_API_KEY=$(cat /run/agenix/ai_api_key)
        fi
      fi

      # 4. 其它细节设置
      bindkey '^[[A' up-line-or-search   # 方向键上：搜索历史
      bindkey '^[[B' down-line-or-search # 方向键下：搜索历史
    '';
  };
}



{ config, pkgs, ... }:

{
  imports = [
    ./vscode.nix
  ];
  home.username = "zephyr";
  home.homeDirectory = "/home/zephyr";
  home.stateVersion = "25.11";

  # 安装用户级软件包
  home.packages = with pkgs; [
    vscode 
    # 编译核心
    gcc
    gdb
    cmake
    # 静态检查、语法提示
    clang-tools
    # 绘图/可视化
    graphviz
    plantuml
    # PDF阅读
    zathura
    # 内存检测
    valgrind
    # C++ 静态分析
    cppcheck  
    # Google C++ 风格检查         
    cpplint
  ];

  # Git 配置
  programs.git = {
    enable = true;
    settings.user = {
      userName = "Zephyr";
      userEmail = "yanrui060127@outlook.com";
    };
  };

  # Zsh 配置
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll  = "ls -l";
      la  = "ls -la";
      lt  = "ls -lart";
      rebuild = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#nixos";
      update  = "cd /etc/nixos && sudo nix flake update";
      gc      = "sudo nix-collect-garbage --delete-older-than 7d";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "extract"
        "web-search"
      ];
    };
  };

  # 让 home-manager 管理会话变量
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}

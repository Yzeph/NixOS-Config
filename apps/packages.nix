{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # 全局系统软件包管理列表
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    fastfetch 
    htop      
    zoxide    
    eza       
    firefox   
    clash-verge-rev   
  ];
}
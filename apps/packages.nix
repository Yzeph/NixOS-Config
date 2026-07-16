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
    btop      
    zoxide    
    eza       
    microsoft-edge
    clash-verge-rev   
  ];
}
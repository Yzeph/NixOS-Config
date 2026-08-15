{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # 全局系统软件包管理列表
  environment.systemPackages = with pkgs; [
    kitty
    vim
    neovim
    git
    lazygit
    wget
    curl
    fastfetch 
    btop      
    zoxide    
    eza
    bat
    microsoft-edge
    clash-verge-rev   
    nodejs
    steam-run
    appimage-run
    go
 ];
}

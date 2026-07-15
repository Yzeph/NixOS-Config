{ config, pkgs, ... }:

{
  # 启用 TUN 模块
    boot.kernelModules = [ "tun" ];

  # 开启 Clash Verge 的安全包裹
    programs.clash-verge = {
        enable = true;
        package = pkgs.clash-verge-rev;
    };

}
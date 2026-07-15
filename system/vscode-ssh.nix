{ config, pkgs, ... }:

{
  # 开启 OpenSSH 服务
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  # 管理员免密码 sudo（解决 SSH 下 sudo 报错）
  security.sudo.wheelNeedsPassword = false;

  # ================= VS Code SSH 远程秒连修复 =================
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    glib
    xorg.libX11
    icu
    openssl
    curl
  ];

  systemd.user.extraConfig = ''
    DefaultEnvironment="NIX_LD=${config.hardware.graphics.package}/lib/ld-nix.so.1"
  '';

  systemd.user.services.vscode-server-fix = {
    description = "Fix VS Code Server on NixOS";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'mkdir -p ~/.vscode-server/bin; ln -sf /run/current-system/sw/bin/bash ~/.vscode-server/bin/bash || true'";
    };
  };
}
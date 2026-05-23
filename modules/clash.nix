{pkgs, pkgs-unstable, ...}: {
  # 配置 Clash Nyanpasu (Clash Verge Rev 的更稳定替代品)
  
  environment.systemPackages = [ 
    pkgs-unstable.clash-nyanpasu 
    pkgs.clash-verge-rev
  ];

  # 1. 赋予核心二进制文件网络管理权限（用于 TUN 模式）
  security.wrappers.clash-verge-rev = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_admin,cap_net_bind_service+ep";
    source = "${pkgs.clash-verge-rev}/bin/clash-verge";
  };

  # 2. 启用后端服务（用于“系统代理”开关和“Service Mode”）
  systemd.services.clash-verge-rev = {
    description = "Clash Verge Rev Backend Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.clash-verge-rev}/bin/clash-verge";
      Restart = "always";
    };
  };

  # 3. 必要的系统内核配置
  boot.kernelModules = [ "tun" ];

  # 4. 辅助 GSettings 代理设置
  services.dbus.packages = [ pkgs.gcr ];

  # 5. 系统级代理设置
  # 使用 networking.proxy 会自动设置所有环境变量 (http_proxy, https_proxy, etc.)
  # 并且对系统服务和 Nix 包管理器也生效，这是 NixOS 的标准做法。
  networking.proxy = {
    default = "http://127.0.0.1:7897";
    httpProxy = "http://127.0.0.1:7897";
    httpsProxy = "http://127.0.0.1:7897";
    all_proxy = "socks5://127.0.0.1:7897"; # 额外添加 all_proxy 变量
    noProxy = "localhost,127.0.0.1,::1,.local";
  };
}

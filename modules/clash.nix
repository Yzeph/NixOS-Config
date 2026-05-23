{pkgs, pkgs-unstable, ...}: {
  # 手动配置 Clash Verge Rev，避免系统模块可能导致的 SUID 冲突并确保权限正确
  
  environment.systemPackages = [ 
    pkgs-unstable.clash-verge-rev 
  ];

  # 1. 赋予核心二进制文件网络管理权限（用于 TUN 模式）
  security.wrappers.clash-verge = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_admin,cap_net_bind_service+ep";
    source = "${pkgs-unstable.clash-verge-rev}/bin/clash-verge";
  };

  # 2. 启用后端服务（用于“系统代理”开关和“Service Mode”）
  systemd.services.clash-verge = {
    description = "Clash Verge Backend Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs-unstable.clash-verge-rev}/bin/clash-verge-service";
      Restart = "always";
    };
  };

  # 3. 必要的系统内核配置
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernelModules = [ "tun" ];

  # 4. 辅助 GSettings 代理设置
  services.dbus.packages = [ pkgs.gcr ];
}

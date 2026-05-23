{pkgs, pkgs-unstable, ...}: {
  # 配置 Clash Nyanpasu (Clash Verge Rev 的更稳定替代品)
  
  environment.systemPackages = [ 
    pkgs-unstable.clash-nyanpasu 
    pkgs.clash-verge
  ];

  # 1. 赋予核心二进制文件网络管理权限（用于 TUN 模式）
  security.wrappers.clash-nyanpasu = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_admin,cap_net_bind_service+ep";
    source = "${pkgs-unstable.clash-nyanpasu}/bin/clash-nyanpasu";
  };

  # 2. 启用后端服务（用于“系统代理”开关和“Service Mode”）
  systemd.services.clash-nyanpasu = {
    description = "Clash Nyanpasu Backend Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs-unstable.clash-nyanpasu}/bin/clash-nyanpasu-service";
      Restart = "always";
    };
  };

  # 3. 必要的系统内核配置
  boot.kernelModules = [ "tun" ];

  # 4. 辅助 GSettings 代理设置
  services.dbus.packages = [ pkgs.gcr ];
}

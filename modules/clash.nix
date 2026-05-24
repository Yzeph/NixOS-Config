{ pkgs, pkgs-unstable, ... }: {
  environment.systemPackages = [
    pkgs-unstable.clash-nyanpasu
    pkgs.clash-verge-rev
  ];

  security.wrappers.clash-verge-rev = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_admin,cap_net_bind_service+ep";
    source = "${pkgs.clash-verge-rev}/bin/clash-verge";
  };

  systemd.services.clash-verge-rev = {
    description = "Clash Verge Rev Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.clash-verge-rev}/bin/clash-verge";
      Restart = "always";
    };
  };

  services.dbus.packages = [ pkgs.gcr ];
}

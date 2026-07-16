{ config, pkgs, ... }: {
  services.syncthing = {
    enable = true;
    user = "zephyr";
    dataDir = "/home/zephyr/Documents/Code";      # 同步文件夹
    configDir = "/home/zephyr/.config/syncthing";  # 配置文件
    overrideFolders = false;
    overrideDevices = false;
  };
}
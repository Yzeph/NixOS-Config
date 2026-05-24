{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./terminal
    ./niri
    ./noctalia
    ./wallpaper
    ./programs
    ./shell
    ./hyprland
    ./rofi
    ./music
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    libnotify
    grim                    # 截图
    slurp                   # 区域选择
    gtk-engine-murrine      # GTK 主题引擎
    catppuccin-gtk          # Catppuccin GTK 主题
    catppuccin-cursors      # Catppuccin 鼠标指针
    papirus-icon-theme      # Papirus 图标主题
  ];

  # 截图脚本
  home.activation.ensureScreenshotDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${config.home.homeDirectory}/screenshot"
  '';
  home.file.".config/niri/scripts/capture.sh" = {
    text = ''
      #!/usr/bin/env bash
      set -e
      SCREENSHOT_DIR="$HOME/screenshot"
      mkdir -p "$SCREENSHOT_DIR"
      FILENAME="Screenshot from $(date +%Y-%m-%d\ %H-%M-%S).png"
      grim -g "$(slurp)" "$SCREENSHOT_DIR/$FILENAME"
      notify-send "Screenshot saved" "$FILENAME"
    '';
    executable = true;
  };

  # 通知服务
  services.swaync.enable = true;

  # 空闲管理（自动锁屏）
  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "noctalia-shell ipc call lockScreen lock"; }
    ];
  };

  # GTK/Qt 主题
  gtk.enable = true;
  gtk.theme = {
    name = "catppuccin-mocha-mauve-standard+default";
    package = pkgs.catppuccin-gtk;
  };
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
  catppuccin.cursors.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "kvantum";
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };
  catppuccin.kvantum.enable = true;

  home.sessionVariables = {
    BROWSER = "microsoft-edge";
    EDITOR = "nvim";
    LANG = "zh_CN.UTF-8";
    LC_CTYPE = "zh_CN.UTF-8";
    LC_MESSAGES = "zh_CN.UTF-8";
  };

  # 默认应用关联
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "microsoft-edge.desktop" ];
    "x-scheme-handler/http" = [ "microsoft-edge.desktop" ];
    "x-scheme-handler/https" = [ "microsoft-edge.desktop" ];
    "x-scheme-handler/about" = [ "microsoft-edge.desktop" ];
    "x-scheme-handler/unknown" = [ "microsoft-edge.desktop" ];
  };

  home.stateVersion = "25.11";
}

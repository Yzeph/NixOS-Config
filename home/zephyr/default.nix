{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./shell
    ./programs
    ./terminal
    ./niri
    ./hyprland
    ./noctalia
    ./fcitx5
    ./rofi
    ./wallpaper
    ./music
  ];

  home.packages = with pkgs; [
    xwayland-satellite # xwayland support
    libnotify
  ];

  # 自动创建截图文件夹
  home.activation.ensureScreenshotDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${config.home.homeDirectory}/screenshot"
  '';

  # Catppuccin 全局主题设置
  catppuccin = {
    enable = true;
    flavor = "mocha"; # 可选: latte, frappe, macchiato, mocha
    accent = "mauve";  # 强调色
  };

  # 启用 GTK 与 Qt 的组件支持
  gtk.enable = true;
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
  # Catppuccin 模块会自动处理相应的配色
  catppuccin.kvantum.enable = true;

  # 消息通知
  services.swaync.enable = true;
  services.swayidle.enable = true;

  # services.mako.enable = true;
  # catppuccin.mako = {
  #   enable = true;
  #   accent = "mauve";
  #   flavor = "mocha";
  # };

  # 设置默认浏览器环境变量为 Google Chrome (Nix) 或 Edge (Flatpak)
  home.sessionVariables = {
    BROWSER = "google-chrome";
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "image/png" = ["imv.desktop"];
    "image/jpeg" = ["imv.desktop"];
    "image/gif" = ["imv.desktop"];
    "text/html" = ["google-chrome.desktop"];
    "x-scheme-handler/http" = ["google-chrome.desktop"];
    "x-scheme-handler/https" = ["google-chrome.desktop"];
    "x-scheme-handler/about" = ["google-chrome.desktop"];
    "x-scheme-handler/unknown" = ["google-chrome.desktop"];
    "x-scheme-handler/clash" = "clash-verge.desktop";
  };

  # 光标配置
  home.pointerCursor = {
    enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PATH = "$HOME/.local/bin:$PATH";
    LANG = "zh_CN.UTF-8"; # 系统主语言中文
    LC_CTYPE = "zh_CN.UTF-8"; # 字符显示支持中文
    LC_MESSAGES = "zh_CN.UTF-8"; # 程序输出信息也改为中文
  };

  home.stateVersion = "25.11";
  # home.enableNixpkgsReleaseCheck = false;
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    # wechat (下载超时，由于 web.archive.org 连接不稳定)
    qq
    vlc
    obsidian
    youtube-music
    spotify
    # microsoft-edge
    jetbrains.idea
    maven
    jdk
    # C/C++ 环境
    gnumake
    cmake
    gdb
    kdePackages.dolphin
    kdePackages.kirigami-addons
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
  ];

  # 谷歌浏览器设置 主题
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform-hint=auto"
      "--force-dark-mode"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
      "--password-store=basic"
    ];
    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      "bpoadfkcbjbfhfodiogcnhhhpibjhbnh" # 沉浸式翻译
      "egehpkpgpgooebopjihjmnpejnjafefi" # Better History | 管理、导出与删除历史记录
      "kjoehdlockiihccmfnoamenhobkkddng" # CSDN自动展开+一键复制代码
    ];
  };
  catppuccin.chromium = {
    enable = true;
    flavor = "mocha";
  };

  # 视频软件
  programs.mpv.enable = true;
  catppuccin.mpv = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };

  # 录制软件
  programs.obs-studio.enable = true;
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    wechat
    qq
    vlc
    discord
    obsidian
    youtube-music
    spotify
    # microsoft-edge
    jetbrains.idea-ultimate
    maven
    jdk
    # C/C++ 环境
    gcc
    gnumake
    cmake
    gdb
    kdePackages.dolphin
  ];

  # 谷歌浏览器设置 主题
  # programs.chromium = {
  #   enable = true;
  #   commandLineArgs = [
  #     "--force-dark-mode"
  #     "--enable-features=UseOzonePlatform"
  #     "--ozone-platform=wayland"
  #     "--force-device-scale-factor=1"
  #     "--enable-gpu-rasterization"
  #     "--enable-zero-copy"
  #   ];
  #   extensions = [
  #     "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
  #     "bpoadfkcbjbfhfodiogcnhhhpibjhbnh" # 沉浸式翻译
  #     "egehpkpgpgooebopjihjmnpejnjafefi" # Better History | 管理、导出与删除历史记录
  #     "kjoehdlockiihccmfnoamenhobkkddng" # CSDN自动展开+一键复制代码
  #   ];
  # };
  # catppuccin.chromium = {
  #   enable = true;
  #   flavor = "mocha";
  # };

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

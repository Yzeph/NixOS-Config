{
  lib,
  pkgs,
  config,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  # 引导加载 — GRUB（支持图片背景和 Catppuccin 主题）
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    configurationLimit = 3;
    splashImage = lib.mkForce ./home/zephyr/wallpaper/image/nix.png;
    useOSProber = true;
    default = "Windows Boot Manager (on /dev/nvme0n1p1)";
  };
  catppuccin.grub.enable = true;
  catppuccin.grub.flavor = "mocha";

  # 开机动画（Catppuccin 主题）
  boot.plymouth.enable = true;
  catppuccin.plymouth.enable = true;
  boot.kernelModules = [ "tun" ];

  # 窗口管理器（使用 unstable 源以获得模糊支持）
  programs.niri = {
    enable = true;
    package = pkgs-unstable.niri;
  };

  # Hyprland 窗口管理器（与 Niri 共存，可在 GDM 选择）
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # 通用 Wayland 会话管理器（UWSM）
  programs.uwsm = {
    enable = true;
    waylandCompositors.niri = {
      binPath = "/run/current-system/sw/bin/niri";
      comment = "Niri (UWSM)";
      extraArgs = [ "--session" ];
      prettyName = "Niri";
    };
  };

  # 内核参数（华硕 B760-G 声卡修复）
  boot.kernelParams = [
    "ahci.mobile_lpm_policy=1"
    "snd_hda_intel.model=alc1220"
    "snd_intel_dspcfg.dsp_driver=1"
  ];

  # 网络
  networking.hostName = "zephyr";
  networking.networkmanager.enable = true;

  # 用户
  users.users.zephyr = {
    isNormalUser = true;
    home = "/home/zephyr";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };

  # 容器
  virtualisation.docker.enable = true;

  # 时区与语言
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";

  # 输入法
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-rime
        qt6Packages.fcitx5-chinese-addons
        qt6Packages.fcitx5-configtool
      ];
    };
  };

  # Nix 核心设置
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Electron 兼容（Wayland + 输入法）
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    http_proxy = "http://127.0.0.1:7897";
    https_proxy = "http://127.0.0.1:7897";
    HTTP_PROXY = "http://127.0.0.1:7897";
    HTTPS_PROXY = "http://127.0.0.1:7897";
  };
  programs.dconf.enable = true;

  # 自动清理
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };
  nix.settings.auto-optimise-store = true;

  # 显示管理器
  services.displayManager.gdm.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # XWayland
  programs.xwayland.enable = true;
  programs.zsh.enable = true;

  # 字体
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    dejavu_fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif CJK SC" "Noto Serif" ];
    sansSerif = [ "Noto Sans CJK SC" "Noto Sans" ];
    monospace = [ "Fira Code" "JetBrainsMono Nerd Font" ];
  };

  # 音频服务（Pipewire）
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # 系统包
  environment.systemPackages = with pkgs; [
    alsa-utils
    sof-firmware
    pavucontrol
    git
  ];

  # 关闭 HDA Intel PCH Auto-Mute（避免每次开机手动改 alsamixer）
  systemd.services.disable-hda-auto-mute = {
    description = "Disable HDA Intel PCH Auto-Mute Mode";
    after = [ "sound.target" ];
    wants = [ "sound.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    serviceConfig.RemainAfterExit = true;
    serviceConfig.ExecStart = "${pkgs.alsa-utils}/bin/amixer -c PCH set 'Auto-Mute Mode' Disabled";
  };

  # 电源管理
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # 蓝牙
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Steam
  programs.steam.enable = true;

  # SSH
  services.openssh.enable = true;

  system.stateVersion = "25.05";
}

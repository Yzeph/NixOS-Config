{
  lib,
  pkgs,
  config,
  ...
}: {
  # 导入硬件配置和自定义模块
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  # Nix 设置
  nix.settings.trusted-users = ["root" "zephyr"]; # 信任用户
  nixpkgs.config.allowUnfree = true;                # 允许闭源软件
  nix.settings.experimental-features = ["nix-command" "flakes"]; # 启用 Flakes 特性

  # 系统级软件包
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks
    # google-chrome (已在 home-manager 中配置)
    # pulseaudio (已禁用，改用 pipewire-pulse)
    pciutils # lspci
    ffmpeg
    libva
    libva-utils
    power-profiles-daemon
    vim
    git
    curl
    wget
    bluez
    glib # 提供 gsettings 命令，供 Clash 等应用设置系统代理
    cachix
    alsa-utils
    sof-firmware # 许多现代主板（如 B760）音频所需的固件
    pavucontrol  # 图形化音频控制面板，建议用来检查是否被静音
    gnome-control-center # GNOME 设置
  ];

  # 会话环境变量
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # 强制 Electron 运行在 Wayland
    TERMINAL = "kitty";   # 默认终端
    # AMD 显卡优化环境变量
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER_NAME = "radeonsi";
    # WLR_NO_HARDWARE_CURSORS = "1"; # AMD 通常不需要，如果光标消失则启用
    # GTK_IM_MODULE = "fcitx";
    # QT_IM_MODULE = "fcitx";
    # QT5_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # 常用程序设置
  programs.steam.enable = true;
  programs.steam.fontPackages = with pkgs; [source-han-sans];
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  security.polkit.enable = true;

  # 启用 Flatpak
  services.flatpak.enable = true;

  # 用户配置
  users.users.zephyr = {
    description = "Zephyr";
    isNormalUser = true;
    home = "/home/zephyr";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    hashedPassword = "$6$d89dDb.7HKl8dx2J$NP00uF4ukMaVYoWzInQxoeokT7927qybXJGzrGwe7WYd7aRNMrNVfLbgnotRDPysU0lqTrZ1L0uTu7EjXsYwg/";
    extraGroups = ["wheel" "networkmanager" "audio" "input" "video" "docker" "kvm" "libvirtd"];
  };
  security.sudo.wheelNeedsPassword = false; # 使用 sudo 无需密码

  # 引导加载程序 (Systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3; # 限制启动项数量，最多保留 3 个
  boot.loader.efi.canTouchEfiVariables = true;
  
  # 内核参数与内核版本
  # 包含针对华硕 B760-G 声卡和低功耗 CPU 的修复
  boot.initrd.kernelModules = [ "amdgpu" ]; # 针对 AMD 显卡提前加载驱动
  boot.kernelModules = [ "tun" ];           # 启用 TUN 模块
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;              # 开启 IPv4 转发
    "net.ipv6.conf.all.forwarding" = 1;     # 开启 IPv6 转发
  };
  boot.kernelParams = [ 
    "ahci.mobile_lpm_policy=1"
    "snd_hda_intel.model=alc1220" # 尝试使用通用 model 名
    "snd_intel_dspcfg.dsp_driver=1" # 强制使用 legacy HDA 驱动，修复 B760 音频不识别
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # SSH 服务
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.timesyncd.enable = true; # 时间同步

  # 磁盘与打印服务
  services.udisks2.enable = true;   # U盘自动挂载
  services.printing.enable = true; # 开启打印

  # 网络配置
  networking.hostName = "zephyr";
  networking.networkmanager.enable = true; # 使用 NetworkManager 管理网络
  networking.firewall.allowedTCPPorts = [
    5900
  ];

  # 系统级静态代理
  networking.proxy = {
    default = "http://127.0.0.1:7897";
    httpProxy = "http://127.0.0.1:7897";
    httpsProxy = "http://127.0.0.1:7897";
    noProxy = "localhost,127.0.0.1,::1,*.local";
  };

  # 禁用所有形式的休眠 (配合某些硬件休眠唤醒可能出问题)
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes         # 允许睡眠
    AllowHibernation=no      # 禁用休眠 (Hibernate)
    AllowHybridSleep=no      # 禁用混合睡眠
    AllowSuspendThenHibernate=no # 禁用先睡眠后休眠
  '';

  # 时区与区域设置
  time.timeZone = "Asia/Shanghai";
  # 默认界面语言
  i18n.defaultLocale = "zh_CN.UTF-8";
  # 具体的日期、货币、测量单位等中文本地化
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
    LC_CTYPE = "zh_CN.UTF-8";
  };

  # 虚拟终端控制台字体与键位
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
    useXkbConfig = true;
  };

  # 字体配置
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    dejavu_fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Sans" "Noto Sans CJK SC"];
        sansSerif = ["Noto Serif" "Noto Serif CJK SC"];
        monospace = ["Fira Code"];
      };
    };
  };

  # 启用 XWayland 兼容层
  programs.xwayland.enable = true;

  # Niri 窗口管理器
  programs.niri.enable = true;

  # [优化] 修正 Portal 行为，防止混合桌面环境下的调用冲突
  # (KDE portal 由 services.desktopManager.plasma6.enable 自动处理)
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      common.default = [ "gtk" ];
      niri.default = [ "gnome" "gtk" ];
      hyprland.default = [ "hyprland" "gnome" "gtk" ];
      plasma.default = [ "kde" "gtk" ];
    };
  };

  # Hyprland 窗口管理器与 UWSM 支持
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # 桌面环境与登录管理器
  services.desktopManager.plasma6.enable = true; # KDE Plasma 6
  services.displayManager.gdm.enable = true;     # GDM 登录界面
  services.displayManager.gdm.wayland = true;
  services.gnome.gnome-keyring.enable = true;    # 密钥环
  services.gnome.gnome-settings-daemon.enable = true; # GNOME 设置守护进程（gnome-control-center 需要）
  security.pam.services.gdm.enableGnomeKeyring = true;

  # X11 服务配置 (即使主用 Wayland，部分基础服务仍需开启)
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # 自动清理过期的 Nix 软件包
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d"; # 清理超过 3 天的旧版本
  };

  nix.settings.auto-optimise-store = true; # 自动优化存储空间 (硬链接重复文件)

  # 音频服务 (使用 Pipewire 替代 Pulseaudio)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # 启用 JACK 支持
    wireplumber.enable = true; # 显式启用会话管理器
  };

  # 硬件支持
  hardware.bluetooth.enable = true;      # 蓝牙
  services.blueman.enable = true;        # 蓝牙管理 GUI
  services.power-profiles-daemon.enable = true; # 电源模式切换
  services.upower.enable = true;

  hardware = {
    enableAllFirmware = true;         # 自动安装所有固件
    cpu.intel.updateMicrocode = true; # Intel CPU 微码更新
    graphics = {                      # 显卡驱动配置 (AMD/Intel 通用)
      enable = true;
      enable32Bit = true;
      # AMD 显卡通常不需要像 Intel 那样指定额外的英特尔驱动包
    };
  };

  # NixOS 状态版本 (请勿随意修改)
  system.stateVersion = "25.05";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}

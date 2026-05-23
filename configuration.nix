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
  nix.settings = {
    trusted-users = ["root" "zephyr"]; # 信任用户
    experimental-features = ["nix-command" "flakes"]; # 启用 Flakes 特性

    # 替换或添加国内镜像源作为主 Substituter
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/" # 保留官方源作为保底备份
    ];

    # 对应的公钥
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  nixpkgs.config.allowUnfree = true;                # 允许闭源软件

  # 系统级软件包
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stable
    winetricks
    google-chrome
    pulseaudio
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
    cachix
    alsa-utils
  ];

  # 会话环境变量
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # 强制 Electron 运行在 Wayland
    TERMINAL = "kitty";   # 默认终端
    # GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    QT5_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # Agenix 密钥管理 (使用 SSH 密钥解密)
  age.identityPaths = [
    "/home/zephyr/.ssh/id_ed25519"
  ];
  age.secrets."ai_api_key" = {
    file = ./secrets/ai_api_key.age;
    owner = "zephyr";
  };

  # 常用程序设置
  programs.steam.enable = true;
  programs.steam.fontPackages = with pkgs; [source-han-sans];
  programs.zsh.enable = true;

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
  boot.loader.efi.canTouchEfiVariables = true;
  
  # 内核参数与内核版本
  # 包含针对华硕 B760-G 声卡和低功耗 CPU 的修复
  boot.kernelParams = [ 
    "ahci.mobile_lpm_policy=1"
    "snd_hda_intel.model=alc1220_vb"
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
  networking.hostName = "cook";
  networking.networkmanager.enable = true; # 使用 NetworkManager 管理网络
  networking.firewall.allowedTCPPorts = [
    5900
  ];

  # 系统全局网络代理 (用于终端和部分应用)
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
  i18n.defaultLocale = "en_US.UTF-8";
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
  security.pam.services.gdm.enableGnomeKeyring = true;

  # X11 服务配置 (即使主用 Wayland，部分基础服务仍需开启)
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # 自动清理过期的 Nix 软件包
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # 音频服务 (使用 Pipewire 替代 Pulseaudio)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # 硬件支持
  hardware.bluetooth.enable = true;      # 蓝牙
  services.blueman.enable = true;        # 蓝牙管理 GUI
  services.power-profiles-daemon.enable = true; # 电源模式切换
  services.upower.enable = true;

  hardware = {
    enableAllFirmware = true;         # 自动安装所有固件
    cpu.intel.updateMicrocode = true; # Intel CPU 微码更新
  };

  # 显卡驱动与硬件加速 (Intel)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
    ];
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

  #### systemd 用户环境加载器 (env-loader) ####
  # 作用：将 Agenix 解密后的敏感变量（如 API Keys）注入到图形界面会话和 Systemd 环境中。
  # 这样 Rofi、Hyprland 脚本以及所有 GUI 应用都能直接读取这些环境变量。
  systemd.user.services.env-loader = {
    description = "将 Agenix 的 API 密钥加载到图形会话环境变量中";
    wantedBy = ["graphical-session-pre.target"]; # 在图形界面启动前准备好
    before = ["graphical-session.target"];      # 确保在进入桌面环境前完成

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "env-loader" ''
          SECRET_FILE="${config.age.secrets.ai_api_key.path}"
          if [ -f "$SECRET_FILE" ]; then
          # 1. 临时开启自动导出功能 (set -a)，并 source 加密文件，读入变量
          set -a
          . "$SECRET_FILE"
          set +a

          # 2. 使用正则提取文件中的变量名 (匹配等号左边的字符)
          VARS=$(grep -oP '^[a-zA-Z_][a-zA-Z0-9_]*(?==)' "$SECRET_FILE")

          # 3. 将变量注入 D-Bus 激活环境 (解决 Rofi/GUI 应用无法识别环境变量的问题)
          ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd $VARS

          # 4. 同步到 systemd 用户级环境变量中，供后台服务使用
          for var in $VARS; do
            val=$(eval echo \$$var)
            ${pkgs.systemd}/bin/systemctl --user set-environment "$var"="$val"
          done
        fi
      '';
    };
  };
}

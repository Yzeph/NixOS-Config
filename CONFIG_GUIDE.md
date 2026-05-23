# NixOS 深度配置指南

这份文档详细介绍了 [NixOS-Config](NixOS-Config) 仓库中每个配置文件的作用、模块的功能以及系统的整体逻辑。

---

## 1. 基础架构 (Repository Core)

### [flake.nix](NixOS-Config/flake.nix)
- **入口**: 系统配置的总纲。
- **Inputs (源)**: 
  - `nixpkgs & nixpkgs-unstable`: 区分稳定版 (25.11) 与滚动更新。
  - `home-manager`: 管理用户级别的配置。
  - `agenix`: 处理加密秘钥。
  - `noctalia & CookNixvim`: 外部定制的桌面外壳和 Neovim 配置引入。
- **Outputs (输出)**: 定义了名为 `cook` 的配置，包含系统模块和 `zephyr` 用户的 `home-manager` 设置。

### [configuration.nix](NixOS-Config/configuration.nix)
- **系统全局配置**: 
  - **用户**: 定义 `zephyr` 用户。
  - **环境变量注入**: 包含一个自定义的 `env-loader` systemd 服务，专门用于将解密后的 Agenix 敏感变量注入到 D-Bus 和 Systemd 用户环境中，解决图形界面应用（如 Rofi）读取不到 API Key 的问题。
  - **核心服务**: 启用 `OpenSSH`, `NetworkManager`, `udisks2` (自动挂载) 以及 `printing` (打印支持)。
  - **网络**: 配置系统级代理 (127.0.0.1:7897) 和 `hostName = "cook"`。
  - **桌面组件**: 启用 `gdm` 登录管理器及 `Plasma 6` 的桌面服务端。
  - **注释**: 关键配置块均已添加详细的 **中文说明**，方便后续维护。

---

## 2. 硬件与底层驱动 (Hardware & Drivers)

### [hardware-configuration.nix](NixOS-Config/hardware-configuration.nix)
- **设备识别**: 定义磁盘 UUID 和分区 (Ext4 根分区, VFAT 引导分区)。
- **内核模块**: 特别加入了 `nvme` 和 `vmd` 以支持主流笔记本和桌面的硬盘控制器。

### 内核参数与修复 ([configuration.nix](NixOS-Config/configuration.nix))
- **音频补丁**: `snd_hda_intel.model=alc1220_vb` 修复 ASUS B760-G 主板音频无法识别的问题。
- **电源管理**: `ahci.mobile_lpm_policy=1` 防止部分低功耗 CPU 异常挂起。
- **版本**: 强制使用 `linuxPackages_latest` 以兼容最新硬件。

---

## 3. 独立系统模块 ([modules/](NixOS-Config/modules/))

- **[clash.nix](NixOS-Config/modules/clash.nix)**: 
  - 启用 `clash-verge`。
  - 默认配置为 **Tun 模式** 和 **服务模式** (Service Mode)，实现全局流量代理。
- **[virtualization.nix](NixOS-Config/modules/virtualization.nix)**: 
  - **Docker**: 全面支持容器化开发。
  - **Libvirtd**: 配置 QEMU 虚拟化，启用 `virt-manager` 图形管理界面和 `virtiofs` 文件共享支持。
- **[documentation.nix](NixOS-Config/modules/documentation.nix)**: 管理系统手册页及开发文档。

---

## 4. 用户环境 (Home-Manager: `home/zephyr/`)

### 桌面环境
- **[hyprland/](NixOS-Config/home/zephyr/hyprland/)**: 
  - 高度定制的平铺桌面。
  - `animations.conf`: 定义柔和的窗口动效。
  - `keybindings.conf`: 定义所有快捷键逻辑。
  - `scripts/`: 包含 `capture.sh` (全功能截图录屏) 和壁纸切换脚本。
- **[niri/](NixOS-Config/home/zephyr/niri/config.kdl)**: 水平滚动窗口管理器的完整配置文件。

### 软件程序 ([programs/](NixOS-Config/home/zephyr/programs/))
- **[app.nix](NixOS-Config/home/zephyr/programs/app.nix)**: 
  - 日常应用：WeChat, QQ, Obsidian, Spotify, VLC 等。
  - **Firefox**: 深度配置，包含中文语言包和隐私设置。
- **[tool.nix](NixOS-Config/home/zephyr/programs/tool.nix)**: 
  - 基础设施：`eza`, `bat`, `fd`, `ripgrep`。
  - 截图套件：`grim` + `slurp` + `satty`。
  - **Claude Code**: 集成了 Anthropic 的命令行 AI 工具。
- **[development/](NixOS-Config/home/zephyr/programs/development/)**: 专门的开发环境模块，包含 `direnv`、`lazygit`、`vscode`、`zed` 及其配置。

### 终端与 Shell ([shell/](NixOS-Config/home/zephyr/shell/))
- **Zsh**: 深度优化的交互环境：
  - **框架**: 使用 Oh My Zsh 提供基础插件支持 (`git`, `sudo`, `z` 等)。
  - **主题**: 使用 Powerlevel10k (p10k)，具备瞬时提示 (Instant Prompt) 功能，大幅提升冷启动速度。
  - **功能**: 集成了语法高亮、自动建议、智能路径跳转以及目录/Nix 存储优化别名。
- **Terminals**: 
  - **Kitty**: 默认图形终端，已同步 Mac 端配置（使用 `Maple Mono NF CN` 字体，支持 Catppuccin 主题和 GPU 加速渲染）。
  - **Alacritty**: 用于 Niri 桌面环境的轻量级备选。

---

## 5. 视觉主题: Catppuccin Mocha

本系统采用全套 **Catppuccin Mocha** 视觉方案：
- **全局生效**: 通过 `catppuccin.nix` 模块实现系统级与用户级的色彩统一。
- **覆盖范围**: 
  - **GTK/Qt (Kvantum)**: 所有图形应用均使用 Mocha 配色。
  - **系统组件**: 包括 `swaync` (通知中心)、`Waybar`、`Kitty`、`Rofi`。
  - **强调色**: 统一使用淡紫色 (`Mauve`) 作为高亮色。

---

## 6. 安全与秘钥 ([secrets/](NixOS-Config/secrets/))

- **[secrets.nix](NixOS-Config/secrets/secrets.nix)**: 定义秘钥访问控制列表。
- **[ai_api_key.age](NixOS-Config/secrets/ai_api_key.age)**: 加密存储的 AI API 秘钥。

---

## 6. 日常维护
- **更新系统**: `nix flake update`。
- **重构应用**: `sudo nixos-rebuild switch --flake .#cook`。
- **垃圾回收**: `nix-collect-garbage -d`。

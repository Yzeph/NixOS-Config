# NixOS-Config

个人 NixOS Flake 配置。基于 NixOS 25.11，用户 `zephyr`。

## 🚀 核心组件
- **桌面**: Hyprland, Niri, KDE Plasma 6
- **内核**: `linuxPackages_latest` + ASUS B760-G 音频修复
- **工具**: Zsh (p10k), Kitty, Neovim (Nixvim), Chrome, Firefox
- **其它**: 系统级代理

## 📂 结构
- `configuration.nix`: 系统主配置
- `home/zephyr/`: 用户 (Home-Manager) 配置
- `modules/`: 独立服务模块 (Docker, Proxy 等)

## 🛠️ 使用
```bash
sudo nixos-rebuild switch --flake .#zephyr
```

详细查阅：[配置说明](./CONFIG_GUIDE.md) | [快捷键](./KEYBINDINGS_GUIDE.md)

---

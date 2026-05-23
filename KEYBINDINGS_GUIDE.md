# NixOS 快捷键使用说明

这份文档整理了你系统中主要窗口管理器（Hyprland 和 Niri）的常用快捷键。

> **提示**: `SUPER` 键通常是菜单键（Windows 键）。

---

## 1. Hyprland 快捷键
主要修饰键：`SUPER` ($mainMod)

### 软件启动
- `SUPER + RETURN`: 打开默认终端 (Kitty)
- `SUPER + SHIFT + RETURN`: 打开浮动终端
- `SUPER + B`: 打开 Google Chrome (默认)
- `SUPER + SHIFT + B`: 打开 Firefox
- `SUPER + M`: 打开 Spotify (Flatpak)
- `SUPER + D`: 打开应用菜单 (Rofi)
- `ALT + SPACE`: 打开 Ulauncher (快速搜索)
- `SUPER + E`: 打开 Yazi 文件管理器 (Kitty)
- `SUPER + N`: 打开 Neovide (GUI Neovim)
- `SUPER + L`: 锁屏 (Hyprlock)

### 窗口管理
- `SUPER + Q`: 关闭当前活动窗口
- `SUPER + SHIFT + Q`: 关闭当前工作区所有窗口
- `SUPER + F`: 全屏模式
- `SUPER + SHIFT + F`: 假全屏 (保留状态栏)
- `SUPER + P`: 切换浮动/平铺模式
- `SUPER + V`: 切换伪平铺模式 (Pseudo)
- `SUPER + J`: 切换分割方向
- `SUPER + 方向键`: 移动焦点
- `SUPER + SHIFT + 方向键/HJKL`: 交换窗口位置
- `SUPER + ALT + 方向键`: 调整窗口大小
- `SUPER + 鼠标左键`: 拖动窗口
- `SUPER + 鼠标右键`: 缩放窗口

### 工作区控制
- `SUPER + 1-0`: 切换到指定工作区
- `SUPER + SHIFT + 1-0`: 将窗口移动到指定工作区
- `SUPER + [ / ]`: 切换上一个/下一个工作区
- `SUPER + Z`: 移动到最近的空工作区
- `SUPER + S`: 切换特殊工作区 (隐藏/显示备用区)
- `SUPER + SHIFT + S`: 将窗口移入特殊工作区

### 截图与系统
- `SUPER + SHIFT + G`: 区域截图（并打开编辑器）
- `SUPER + G`: 打开截图/录屏菜单脚本
- `SUPER + SHIFT + W`: 壁纸切换菜单
- `SUPER + SHIFT + R`: 重新加载 Hyprland & Waybar
- `SUPER + SHIFT + ESCAPE`: 退出会话菜单 (wlogout)

---

## 2. Niri 快捷键
主要修饰键：`Mod` (通常也是 SUPER)

### 常用操作
- `Mod + RETURN`: 打开终端 (Alacritty)
- `Mod + SHIFT + RETURN`: 打开浮动终端
- `Mod + D`: 应用启动器 (Fuzzel)
- `Mod + Shift + W`: 切换壁纸
- `Mod + G`: 打开截图/录屏菜单脚本
- `Mod + E`: Yazi 文件管理器 (Alacritty)
- `Mod + B`: Google Chrome 浏览器
- `Mod + SHIFT + B`: Firefox
- `Mod + N`: Neovim (Alacritty)
- `Mod + L`: 锁屏 (Noctalia Shell)
- `SUPER + SHIFT + V`: 剪切板管理 (Noctalia Shell)
- `SUPER + S`: 多功能启动器 (Noctalia Shell)
- `Mod + Q`: 关闭当前窗口
- `Mod + O`: 开启/关闭 全览模式 (Overview)
- `Mod + SHIFT + /`: 显示内置快捷键帮助菜单

### 导航与布局
- `Mod + H/J/K/L` 或 `方向键`: 移动焦点
- `Mod + Ctrl + H/J/K/L`: 移动窗口/列
- `Mod + SHIFT + H/J/K/L`: 切换显示器焦点
- `Mod + U / I` 或 `PageUp / PageDown`: 切换工作区
- `Mod + Ctrl + U / I`: 将窗口移动到上一个/下一个工作区

---

## 4. 终端常用别名 (Shell Aliases)
这些别名在 Zsh 中全局生效，极大地简化了日常操作：

### NixOS 维护
- `nrs`: `sudo nixos-rebuild switch --flake .#zephyr` (快速应用配置)
- `nlg`: 列出系统世代 (Generations)
- `ncg`: 清理陈旧的软件包 (垃圾回收)
- `nopt`: 优化 Nix 存储（硬链接去重）

### 常用工具
- `nv`: `nvim` (编辑文件)
- `snv`: `sudo nvim` (以 root 权限编辑)
- `lg`: `lazygit` (Git 图形客户端)
- `ff`: `fastfetch` (查看系统信息)
- `lta`: 以树形结构列出目录 (ls --tree --long --icons)

---

## 5. 多媒体与系统键
- `音量加/减/静音`: 对应设备上的多媒体键
- `亮度加/减`: 对应设备上的亮度键
- `播放/暂停/上一曲/下一曲`: 对应多媒体控制键 (playerctl)

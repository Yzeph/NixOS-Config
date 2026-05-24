# 快捷键索引

> 记录所有已配置模块的快捷键。Mod = Super (Win) 键。

---

## Niri — 窗口管理器

路径: `home/zephyr/niri/config.kdl`

### 启动程序

| 快捷键 | 功能 | 依赖模块 |
|--------|------|---------|
| `Mod + Return` | 打开终端 (Alacritty) | — |
| `Mod + Shift + Return` | 打开浮动终端 (Alacritty) | — |
| `Mod + D` | 应用启动器 (Fuzzel) | Niri 内置 |
| `Mod + Shift + W` | 切换壁纸 (swww + rofi) | [swww](#swww--壁纸), [rofi](#rofi--应用启动器) |
| `Mod + G` | 截图/录屏菜单 (rofi) | [截图脚本](#截图与录屏脚本), [rofi](#rofi--应用启动器) |
| `Mod + E` | 文件管理器 (Yazi) | — |
| `Mod + B` | 打开 Google Chrome | — |
| `Mod + Shift + B` | 打开 Firefox | — |
| `Mod + N` | 打开编辑器 (Neovim) | — |
| `Mod + Shift + Escape` | 系统菜单 (wlogout) | [Wlogout](#wlogout--系统菜单) |

### Noctalia 功能

| 快捷键 | 功能 | 依赖模块 |
|--------|------|---------|
| `Super + L` | 锁屏 | [Noctalia](#noctalia--锁屏与启动器) |
| `Super + Shift + V` | 剪贴板管理器 | [Noctalia](#noctalia--锁屏与启动器) |
| `Super + S` | 多功能启动器 | [Noctalia](#noctalia--锁屏与启动器) |

### 音量与亮度

| 快捷键 | 功能 | 依赖模块 |
|--------|------|---------|
| `XF86AudioRaiseVolume` | 音量 +10% | [Pipewire](#音频--pipewire) |
| `XF86AudioLowerVolume` | 音量 -10% | [Pipewire](#音频--pipewire) |
| `XF86AudioMute` | 静音切换 | [Pipewire](#音频--pipewire) |
| `XF86AudioMicMute` | 麦克风静音 | [Pipewire](#音频--pipewire) |
| `XF86MonBrightnessUp` | 亮度 +10% | — |
| `XF86MonBrightnessDown` | 亮度 -10% | — |

### 窗口操作

| 快捷键 | 功能 |
|--------|------|
| `Mod + Q` | 关闭窗口 |
| `Mod + F` | 最大化列 |
| `Mod + Shift + F` | 全屏窗口 |
| `Mod + V` | 切换浮动/平铺 |
| `Mod + Shift + V` | 焦点在浮动/平铺间切换 |
| `Mod + W` | 切换标签式显示 |
| `Mod + R` | 循环切换列宽预设 |
| `Mod + Shift + R` | 循环切换窗口高度预设 |
| `Mod + Ctrl + R` | 重置窗口高度 |
| `Mod + C` | 居中列 |
| `Mod + Ctrl + C` | 居中所有可见列 |
| `Mod + Ctrl + F` | 扩展列至可用宽度 |
| `Mod + -` | 列宽 -10% |
| `Mod + =` | 列宽 +10% |
| `Mod + Shift + -` | 窗口高度 -10% |
| `Mod + Shift + =` | 窗口高度 +10% |
| `Mod + [` | 向左并入/移出列 |
| `Mod + ]` | 向右并入/移出列 |
| `Mod + ,` | 从右侧吸收窗口到列底 |
| `Mod + .` | 从列底弹出窗口到右侧 |
| `Mod + O` | 切换概览 |

### 焦点移动

| 快捷键 | 功能 |
|--------|------|
| `Mod + Left / H` | 焦点向左一列 |
| `Mod + Right / L` | 焦点向右一列 |
| `Mod + Down / J` | 焦点向下一窗口 |
| `Mod + Up / K` | 焦点向上一窗口 |
| `Mod + Home` | 焦点到第一列 |
| `Mod + End` | 焦点到最后一列 |

### 窗口/列移动

| 快捷键 | 功能 |
|--------|------|
| `Mod + Ctrl + Left / H` | 列向左移 |
| `Mod + Ctrl + Right / L` | 列向右移 |
| `Mod + Ctrl + Down / J` | 窗口向下移 |
| `Mod + Ctrl + Up / K` | 窗口向上移 |
| `Mod + Ctrl + Home` | 列移到最左 |
| `Mod + Ctrl + End` | 列移到最右 |

### 显示器切换

| 快捷键 | 功能 |
|--------|------|
| `Mod + Shift + Left / H` | 焦点切换到左显示器 |
| `Mod + Shift + Right / L` | 焦点切换到右显示器 |
| `Mod + Shift + Down / J` | 焦点切换到下显示器 |
| `Mod + Shift + Up / K` | 焦点切换到上显示器 |
| `Mod + Shift + Ctrl + Left / H` | 列移到左显示器 |
| `Mod + Shift + Ctrl + Right / L` | 列移到右显示器 |
| `Mod + Shift + Ctrl + Down / J` | 列移到下显示器 |
| `Mod + Shift + Ctrl + Up / K` | 列移到上显示器 |

### 工作区 (Workspace)

| 快捷键 | 功能 |
|--------|------|
| `Mod + 1-9` | 聚焦工作区 N |
| `Mod + Page_Down / U` | 聚焦上个工作区 |
| `Mod + Page_Up / I` | 聚焦下个工作区 |
| `Mod + Ctrl + 1-9` | 移动列到工作区 N |
| `Mod + Ctrl + Page_Down / U` | 移动列到上个工作区 |
| `Mod + Ctrl + Page_Up / I` | 移动列到下个工作区 |
| `Mod + Shift + Page_Down / U` | 移动工作区向下 |
| `Mod + Shift + Page_Up / I` | 移动工作区向上 |
| `Mod + WheelScrollDown` | 滚动切换到上个工作区 |
| `Mod + WheelScrollUp` | 滚动切换到下个工作区 |
| `Mod + Ctrl + WheelScrollDown` | 滚动移动列到上个工作区 |
| `Mod + Ctrl + WheelScrollUp` | 滚动移动列到下个工作区 |

### 截图

| 快捷键 | 功能 |
|--------|------|
| `Print` | 截选区 |
| `Ctrl + Print` | 截全屏 |
| `Alt + Print` | 截当前窗口 |

### 系统

| 快捷键 | 功能 |
|--------|------|
| `Mod + Escape` | 切换快捷键抑制（远程桌面等场景） |
| `Mod + Shift + E` | 退出 Niri |
| `Ctrl + Alt + Delete` | 退出 Niri |
| `Mod + Shift + P` | 关闭显示器 |
| `Mod + Shift + /` | 显示快捷键帮助覆盖层 |

---

## Noctalia — 锁屏与启动器

路径: `home/zephyr/noctalia/noctalia.nix`

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `Super + L` | 锁屏 | Niri config.kdl |
| `Super + S` | 多功能启动器 | Niri config.kdl |
| `Super + Shift + V` | 剪贴板管理器 | Niri config.kdl |

- 自动锁屏: swayidle 5 分钟无操作后调用 (`home/zephyr/default.nix`)

---

## Swww — 壁纸

路径: `home/zephyr/wallpaper/swww.nix`

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `Mod + Shift + W` | 随机切换壁纸 (通过 rofi) | Niri config.kdl |

- 自启动: 由 Niri 的 `spawn-sh-at-startup` 在登录时拉起

---

## 音频 — Pipewire

路径: `configuration.nix`

快捷键见 [Niri 音量与亮度](#音量与亮度)。音频路由由 Pipewire + WirePlumber 管理。

---

## 截图与录屏脚本

路径: `home/zephyr/hyprland/scripts/capture.sh`

| 快捷键 | 功能 | 依赖 |
|--------|------|------|
| `Mod + G` | 打开截图/录屏功能菜单 (rofi) | grim, slurp, rofi, satty, wl-clipboard, wf-recorder |

功能菜单:
- **全屏截图** → 编辑并保存 (satty) / 仅保存 / 复制到剪贴板 / 取消
- **区域截图** → 同上
- **全屏录屏** → 选音频源 → 选屏幕 → 开始录制
- **区域录屏** → 选音频源 → 选屏幕 → 选区域 → 开始录制

录制中再次按 `Mod + G` 可: 停止录屏 / 全屏截图 / 区域截图

Niri 自带的截图快捷键 (`Print`, `Ctrl+Print`, `Alt+Print`) 不受影响。

---

## 输入法 — Fcitx5

路径: `configuration.nix`

| 快捷键 | 功能 |
|--------|------|
| `Super + Space` | 切换输入法 (中/英) |

- 自动启动: 由 NixOS fcitx5 模块通过 systemd user service 拉起

---

## UWSM — 通用 Wayland 会话管理器

路径: `configuration.nix`

- **无快捷键**。后台服务，接管 niri 和 Hyprland 的会话生命周期管理。

---

## Hyprland — 窗口管理器（备选）

路径: `home/zephyr/hyprland/`，快捷键在 `hypr/keybindings.conf`

GDM 登录时可选择 Niri 或 Hyprland。

| 快捷键 | 功能 |
|--------|------|
| `Super + Return` | 打开终端 |
| `Super + Shift + Return` | 打开浮动终端 |
| `Super + D` | 应用启动器 |
| `Super + B` | 打开默认浏览器 |
| `Super + Q` | 关闭窗口 |
| `Super + Shift + Q` | 关闭当前工作区所有窗口 |
| `Super + L` | 锁屏 (hyprlock) |
| `Super + Shift + R` | 重新加载 Hyprland 配置 |
| `Super + Shift + Escape` | 退出 Hyprland (wlogout) |
| `Alt + Space` | 网络搜索 (ulauncher) |

完整的 Hyprland 快捷键列表见 `hypr/keybindings.conf`。

---

## Waybar — 状态栏

路径: `home/zephyr/hyprland/waybar/waybar.nix`

- **无快捷键**。顶部状态栏显示:
  - 左侧: Logo + 工作区 + cava 频谱
  - 右侧: 时钟 + 录屏状态 + 电源模式 + 音量 + CPU + 蓝牙 + 系统托盘
- 交互: 点击音量 → pavucontrol, 蓝牙 → blueman-manager, 电源模式 → 循环切换
- 主题: Catppuccin Mocha 自定义 CSS

---

## Wlogout — 系统菜单

路径: `home/zephyr/hyprland/wlogout/wlogout.nix`

| 快捷键 | 功能 | 来源 |
|--------|------|------|
| `Super + Shift + Escape` | 打开系统菜单 (Hyprland) | Hyprland keybindings |
| 终端运行 `wlogout` | 打开系统菜单 (Niri) | — |

按钮布局:
| 按键 | 功能 |
|------|------|
| `l` | 锁屏 (hyprlock) |
| `e` | 注销 |
| `r` | 重启 |
| `s` | 关机 |

---

## Hyprlock — 锁屏

路径: `home/zephyr/hyprland/hyprlock/hyprlock.conf`

- 锁屏界面: 中文友好设计
  - 用户头像 + "你好，$USER"
  - 大号时间 + 中文日期
  - 密码输入框 (中文提示)
  - 系统信息 + 键盘布局显示
- 自动锁屏: swayidle 5 分钟无操作 (`home/zephyr/default.nix`)
- 手动锁屏: `Super + L` (Hyprland) 或 `noctalia-shell ipc call lockScreen lock` (Niri)

---

## Rofi — 应用启动器

路径: `home/zephyr/rofi/`

| 用途 | 命令 | 主题 |
|------|------|------|
| 应用启动器 | `rofi -show drun` | app.rasi |
| 截图/录屏菜单 | capture.sh 自动调用 | screenshot.rasi |
| 壁纸选择 | swww-rofi.sh 自动调用 | wallpaper_2_line.rasi |

- Fuzzel 仍是 Niri 的主启动器 (`Mod + D`)
- Rofi 作为截图、录屏、壁纸切换的交互菜单

---

## Tmux — 终端复用器

路径: `home/zephyr/programs/development/tmux.nix`

| 快捷键 | 功能 |
|--------|------|
| `C-a` | 前缀键 (默认 `C-b` 改为 `C-a`) |
| `C-a %` | 垂直分屏 |
| `C-a "` | 水平分屏 |
| `C-a c` | 新建窗口 |
| `C-a ,` | 重命名窗口 |
| `C-a .` | 重编号窗口 |

- vi 模式, 启用鼠标
- 插件: resurrect (会话保存) + continuum (自动恢复, 60 分钟存档)
- 主题: Catppuccin Mocha

---

## Clash — 代理

路径: `modules/clash.nix`

- **无快捷键**。Clash Verge Rev 提供系统托盘图标，右键操作。
- 自启动: 由 Niri config.kdl 在登录时拉起 (`spawn-at-startup "clash-verge"`)

---

## Kitty — 终端

路径: `home/zephyr/terminal/kitty.nix`

- **无自定义快捷键**。Kitty 内置默认快捷键（如 `Ctrl+Shift+C` 复制等）保持不变。

---

## Alacritty — 终端

路径: `home/zephyr/terminal/alacritty.nix`

- 默认终端，`Mod + Return` 启动。
- 字体: FiraCode Nerd Font 14
- 主题: Catppuccin Mocha

---

## Go-Musicfox — 网易云音乐 CLI

路径: `home/zephyr/music/go-musicfox.nix`

- 终端运行 `go-musicfox` 启动。
- 支持: 每日推荐、私人 FM、歌单浏览、歌词显示

---

## Microsoft Edge

路径: `home/zephyr/programs/app.nix`

- **无自定义快捷键**。已设为默认浏览器（`BROWSER` 环境变量 + MIME 类型关联）。

---

## Docker

路径: `configuration.nix`

- **无快捷键**。通过终端管理 (`docker`、`docker-compose`)。
- 用户 `zephyr` 已加入 `docker` 组。

---

## 开发工具

路径: `home/zephyr/programs/development/`

| 工具 | 类型 | 启动方式 |
|------|------|---------|
| **JDK / Maven** | Java | 终端 |
| **gdb / cmake / gnumake / ninja / pkg-config** | C/C++ | 终端 |
| **Node.js 24** | JavaScript/TypeScript | 终端 |
| **Lazygit** | Git TUI | 终端: `lazygit` |
| **Neovide** | Neovim GUI | 应用启动器 |
| **VSCode** | 编辑器 | 应用启动器 |
| **Tmux** | 终端复用器 | 终端: `tmux` |

---

## 命令行工具集

路径: `home/zephyr/programs/tool.nix`

| 工具 | 功能 | 使用方式 |
|------|------|---------|
| **fzf** | 模糊搜索 | `Ctrl+T` / `Ctrl+R` (zsh 集成) |
| **fd** | 文件查找 | 终端: `fd <pattern>` |
| **ripgrep (rg)** | 代码搜索 | 终端: `rg <pattern>` |
| **eza** | 带图标/颜色 ls | 终端: `lta` (alias), `ll`, `la` |
| **bat** | 语法高亮 cat | 终端: `bat <file>` |
| **jq** | JSON 处理 | 终端: `jq <filter>` |
| **yazi** | 文件管理器 TUI | `Mod + E` |
| **zoxide** | 智能 cd | 终端: `z <dir>` |
| **btop** | 系统监控 TUI | 终端: `btop` |
| **cava** | 音频频谱 | 终端: `cava` (waybar 也内嵌) |
| **fastfetch** | 系统信息 | 终端: `ff` (alias) |
| **satty** | 截图编辑 | capture.sh 自动调用 |
| **wl-clipboard** | 命令行剪贴板 | capture.sh 自动调用 |
| **tty-clock** | 终端时钟 | 终端: `tty-clock` |

---

## Steam

路径: `configuration.nix`

- **无快捷键**。通过应用启动器或终端启动。

---

## OBS Studio — 录屏/直播

路径: `home/zephyr/programs/app.nix`

- **无快捷键**。通过应用启动器或终端 (`obs`) 启动。
- wf-recorder 提供轻量命令行录屏替代（见 [截图与录屏脚本](#截图与录屏脚本)）。

---

## Bluetooth

路径: `configuration.nix`

- **无快捷键**。通过 waybar 蓝牙图标或 `blueman-manager` GUI 管理。
- 终端管理: `bluetoothctl`

---

## Flatpak

路径: `configuration.nix`

- **无快捷键**。通过终端 (`flatpak install`) 管理。

---

## Nix GC — 自动清理

路径: `configuration.nix`

- **无快捷键**。每日自动清理 3 天前的旧版本。
- 手动清理: `sudo nix-collect-garbage -d`（已在 zsh alias 中）。

---

## JetBrains IDEA

路径: `home/zephyr/programs/app.nix`

- **无自定义快捷键**。通过应用启动器启动。内置 Vim 模拟器 + IDE 快捷键。

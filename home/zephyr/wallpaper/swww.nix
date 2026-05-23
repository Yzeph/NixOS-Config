{pkgs, ...}: {
  home.packages = with pkgs; [
    swww
  ];

  home.file.".config/wallpaper" = {
    source = ./image;
    recursive = true;
  };

  home.file.".config/wallpaper/swww-rofi.sh" = {
    text = ''
      #!/bin/sh
      # 简单的壁纸切换逻辑示例，具体根据你的脚本内容调整
      # 这里只是确保文件存在且可执行
      swww img $(find ~/.config/wallpaper -type f | shuf -n 1)
    '';
    executable = true;
  };
}

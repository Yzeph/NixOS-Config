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
      if ! pgrep -x "swww-daemon" >/dev/null; then
          swww-daemon &
          while ! swww query >/dev/null 2>&1; do
              sleep 0.1
          done
      fi
      swww img $(find ~/.config/wallpaper -type f | grep -E "\.(jpg|jpeg|png|webp|gif)$" | shuf -n 1)
    '';
    executable = true;
  };
}

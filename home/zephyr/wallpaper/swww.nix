{ pkgs, ... }: {
  home.packages = with pkgs; [
    swww
    rofi
  ];

  home.file.".config/wallpaper" = {
    source = ./image;
    recursive = true;
  };

  home.file.".config/wallpaper/swww-rofi.sh" = {
    source = ./swww-rofi.sh;
    executable = true;
  };
}

{ pkgs, ... }: {
  imports = [
    ./scripts
    ./waybar/waybar.nix
    ./wlogout/wlogout.nix
    ./hyprlock/hyprlock.nix
  ];

  home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  home.file.".config/hypr/animations.conf".source = ./hypr/animations.conf;
  home.file.".config/hypr/autostart.conf".source = ./hypr/autostart.conf;
  home.file.".config/hypr/envVars.conf".source = ./hypr/envVars.conf;
  home.file.".config/hypr/keybindings.conf".source = ./hypr/keybindings.conf;
  home.file.".config/hypr/monitors.conf".source = ./hypr/monitors.conf;
  home.file.".config/hypr/myPrograms.conf".source = ./hypr/myPrograms.conf;
  home.file.".config/hypr/windows.conf".source = ./hypr/windows.conf;
}

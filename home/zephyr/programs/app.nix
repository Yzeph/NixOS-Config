{ pkgs, ... }: {
  home.packages = with pkgs; [
    youtube-music
    microsoft-edge
    qq
    jetbrains.idea
    obs-studio
  ];
}

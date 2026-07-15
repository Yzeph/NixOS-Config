{ config, pkgs, ... }: {
  home-manager.users.zephyr = import ./zephyr.nix;
}

{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    pavucontrol
    networkmanagerapplet
  ];

  catppuccin.waybar.enable = false;

  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;

        modules-left = [ "group/container" ];
        modules-center = [ "cava" ];
        modules-right = [ "clock" "custom/wf-recorder" "group/main" "tray" ];

        "group/container" = {
          orientation = "inherit";
          modules = [ "custom/logo" "hyprland/workspaces" "custom/icon" ];
        };

        "group/main" = {
          orientation = "inherit";
          modules = [ "custom/powerprofile" "pulseaudio" "cpu" "bluetooth" ];
        };

        "cava" = {
          framerate = 30;
          autosens = 1;
          bars = 14;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 10000;
          hide_on_silence = true;
          method = "pulse";
          source = "auto";
          stereo = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = 0.6;
          input_delay = 4;
          sleep_timer = 1;
          format-icons = [ "▁" "▂" "▂▃" "▄" "▅" "▆" "▇█" "█" ];
          actions = {
            on-click-right = "mode";
          };
        };

        "custom/logo" = {
          format = "";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = false;
          show-special = true;
          special-visible-only = false;
          disable-scroll = true;
          warp-on-scroll = false;
          format = "{name}";
          persistent-workspaces = { "*" = 5; };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "custom/icon" = {
          format = "󰋇";
          tooltip = false;
        };

        cpu = {
          format = "{icon} {usage}%";
          interval = 10;
          tooltip = false;
          format-icons = [ "" ];
        };

        tray = {
          icon-size = 20;
          spacing = 10;
        };

        bluetooth = {
          format = "󰂯 {status}";
          format-connected = " {device_alias}";
          on-click = "blueman-manager";
          on-click-right = "rfkill toggle bluetooth";
          tooltip = true;
        };

        clock = {
          timezone = "Asia/Shanghai";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "custom/wf-recorder" = {
          format = "{text}";
          interval = 2;
          exec = "~/.config/waybar/scripts/wf-recorder-status.sh";
          return-type = "json";
          on-click = "~/.config/hypr/scripts/capture.sh";
          hide-empty-text = true;
          tooltip = true;
        };

        "custom/powerprofile" = {
          tooltip = true;
          exec = "~/.config/waybar/scripts/toggle-power-profile.sh get";
          return-type = "json";
          on-click = "~/.config/waybar/scripts/toggle-power-profile.sh toggle";
          interval = 1;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "{format_source}";
          format-source = "󰕿";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
      };
    };
  };

  home.file.".config/waybar/scripts/toggle-power-profile.sh" = {
    source = ./toggle-power-profile.sh;
    executable = true;
  };
}

{ ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
    extraConfig = ''
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      background_opacity 0.92
      background_blur 30
      hide_window_decorations yes
      confirm_os_window_close 0
      tab_bar_edge bottom
      tab_bar_min_tabs 1
      tab_bar_style powerline
      tab_powerline_style slanted
      tab_title_template " {index}: {title}{'  {}'.format(num_windows) if num_windows > 1 else ${"''"}}"
      remember_window_size yes
      force_ltr_rendering yes
      disable_ligature
    '';
  };

  catppuccin.kitty.enable = true;
}

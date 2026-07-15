{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      
      lxgw-wenkai                 
      monaspace                   
      maple-mono."NF-CN"       
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "LXGW WenKai" "Noto Sans CJK SC" ];
        serif = [ "LXGW WenKai" "Noto Serif CJK SC" ];

        monospace = [ 
          "Monaspace Neon" 
          "Maple Mono NF CN" 
          "LXGW WenKai Mono" 
        ];
      };
    };
  };
}
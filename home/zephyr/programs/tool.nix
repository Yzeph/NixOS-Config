{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    tty-clock
    unzip
    zip
    satty
    wl-clipboard
    cliphist
    imv # 不加 programs.imv.enable 以避免 catppuccin.imv 跨平台构建失败
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--preview '[ -d {} ] && eza --tree --level=2 --color=always {} || bat --color=always --style=numbers {}'"
      "--preview-window=right:60%"
    ];
    changeDirWidgetOptions = [
      "--preview '[ -d {} ] && eza --tree --level=2 --color=always {} || eza --color=always {}'"
      "--preview-window=right:40%"
    ];
    historyWidgetOptions = [ "--no-preview" ];
  };
  catppuccin.fzf = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [ "node_modules" "target" ];
  };

  programs.ripgrep.enable = true;
  programs.ripgrep-all.enable = true;

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    colors = "auto";
    git = true;
    icons = "auto";
  };

  programs.bat = {
    enable = true;
    config = {
      number = true;
      paging = "always";
    };
  };
  catppuccin.bat = {
    enable = true;
    flavor = "mocha";
  };

  programs.jq.enable = true;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.btop.enable = true;
  catppuccin.btop = {
    enable = true;
    flavor = "mocha";
  };

  programs.cava.enable = true;
  catppuccin.cava = {
    enable = true;
    flavor = "mocha";
    transparent = true;
  };

  programs.claude-code = {
    enable = true;
    package = pkgs-unstable.claude-code;
  };
}

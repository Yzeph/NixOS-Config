{ pkgs, ... }: {
  home.file.".compile_flags.txt".source = ./compile_flags.txt;

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        llvm-vs-code-extensions.vscode-clangd
        vadimcn.vscode-lldb
        catppuccin.catppuccin-vsc
        ms-vscode.cmake-tools
        twxs.cmake
      ];
      userSettings = {
        "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
        "C_Cpp.intelliSenseEngine" = "disabled";
        "clangd.arguments" = [
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
        ];
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "files.autoSave" = "afterDelay";
        "workbench.startupEditor" = "none";
        "terminal.integrated.defaultProfile.linux" = "zsh";
      };
    };
  };
}
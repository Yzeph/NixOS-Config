{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Java
    jdk
    maven

    # C/C++
    gdb
    cmake
    gnumake
    pkg-config
    ninja

    # Web
    nodejs_24
  ];
}

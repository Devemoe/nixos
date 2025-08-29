{
  environment.systemPackages = with pkgs; [
    # Desktop programs
    alacritty
    firefox
    telegram-desktop
    zathura

    # CLI programs
    btop
    htop
    neofetch
    neovim
    ranger
    unzip
    zip

    # Compilers
    cargo
    clang
    nodejs
    python314
    rustc
    rustup

    # Desktop environment
    brightnessctl
    hypridle
    hyprland
    hyprpaper
    playerctl
  ];
}

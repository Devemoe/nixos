{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Desktop programs
    alacritty
    firefox
    telegram-desktop
    zathura

    # CLI programs
    bat
    btop
    htop
    neofetch
    neovim
    ranger
    tree
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

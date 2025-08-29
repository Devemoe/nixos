{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Desktop programs
    alacritty
    firefox
    imv
    mpv
    telegram-desktop
    zathura

    # CLI programs
    bat
    btop
    git
    htop
    neofetch
    neovim
    ranger
    tree
    unzip
    zip
    wget
    curl

    # Compilers
    clang
    rustup

    # Desktop environment
    brightnessctl
    hypridle
    hyprland
    hyprpaper
    playerctl
    wl-clipboard
    wofi
  ];
}

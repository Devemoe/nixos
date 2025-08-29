{
  nix.setings = {
    cores = 4;
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
}

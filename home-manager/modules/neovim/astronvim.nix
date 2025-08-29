{ inputs, ... }:
{
  home.file.".config/nvim".source = inputs.astronvim;
}

{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  packages = [
    pkgs.ghdl
    pkgs.gtkwave
    pkgs.just
  ];
}

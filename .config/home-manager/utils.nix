{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bash
    wget
    curl
    ripgrep
    fd
    watch
    envsubst
    moreutils
    bat
    jq
  ];
}

{ pkgs, ... }:

{
  home.packages = [
    pkgs.joe
  ];

  home.sessionVariables = {
    EDITOR = "joe";
  };
}

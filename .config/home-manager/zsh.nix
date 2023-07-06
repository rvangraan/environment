{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
#dotDir = ".config/zsh";
    autocd = true;
    enableCompletion = true;
#    setOptions = [
#	"HIST_IGNORE_DUPS" "HIST_FCNTL_LOCK" "EXTENDED_HISTORY"
#    ];
    oh-my-zsh = {
      enable = true;
      theme = "eastwood";
#      theme = "gentoo";	
      plugins = [ "per-directory-history" ];
    };
  };

  programs.zsh.initExtra = ''
    unalias ls
  '';

  programs.zsh.envExtra = ''
    # Install Brew paths.
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Use mac path helper.
    eval "$(/usr/libexec/path_helper)"	
    bindkey '^h' per-directory-history-toggle-history	
    setopt extended_history 	
    setopt hist_ignore_dups
  '';

  home.packages = [
    pkgs.zsh-completions
  ];
}

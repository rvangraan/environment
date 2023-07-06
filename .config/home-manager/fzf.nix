{ pkgs, lib, ... }: {
  home.packages = [
    pkgs.fzf
  ];

  home.sessionVariables = {
    # Configure FZF.
    FZF_DEFAULT_OPTS = lib.concatStringsSep " " [
      "--ansi"
      "--color dark"
      "--reverse"
      "--preview-window='right:80%'"
    ];
  };

  programs.zsh.initExtra = ''
    source "${pkgs.fzf}/share/fzf/completion.zsh"
    ${builtins.readFile ./dotfiles/fzf.zsh}
  '';
}

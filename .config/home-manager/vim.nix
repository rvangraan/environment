{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };

  programs.neovim.plugins = with pkgs.vimPlugins; [
    molokai # Best theme.
    sensible # Sensible defaults for Vim.
    repeat # Improve `.` (repeat) for plugin maps.
    surround # Commands for interacting with characters that surround text.
    commentary # Add operator to comment out lines.
    nerdtree # Tree explorer.
    polyglot # Polyglot adds a bunch of syntax handling for different languages and tools.
    vim-rsi # Emacs/Readline bindings in insert mode.
    vim-lastplace # Maintain cursor position across restarts
    vim-signify # Show git changes in the sign column
    vim-signature # Show marks in sign column.
    editorconfig-vim # Apply indentation from `.editorconfig` files.
    is-vim # Improved incremental search - hides search highlighting after moving cursor.
    vim-visual-star-search # Search using '*' from visual selection.
    fzf-vim # Fuzzy file search.
  ];
}

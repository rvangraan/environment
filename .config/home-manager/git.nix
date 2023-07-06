{ pkgs, ... }:

let
  git-review = pkgs.writeScriptBin "git-review" ''
    #!/usr/bin/env bash
    set -euo pipefail
    git_branch=review/$USER/$(date +%Y%m%d_%H%M%S)
    git_remote_url=$(git remote get-url origin)
    github_repo=''${git_remote_url#*:}
    github_repo=''${github_repo%.git}
    github_query=compare/$(git rev-parse --abbrev-ref HEAD)...$git_branch
    github_compare_url="https://github.com/$github_repo/$github_query"
    echo $github_compare_url | pbcopy
    git commit -a -m "chore: Review requested by $USER"
    git push origin HEAD:$git_branch
    git reset --hard HEAD^
    echo "review:"
    echo "review: See review branch '$git_branch' on GitHub by visiting:"
    echo "review:    $github_compare_url"
    echo "review:"
    echo "review: Copied to clipboard"
  '';
  git-branches = pkgs.writeScriptBin "git-branches" ''
    git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'	
  '';


  in 
{
  home.sessionVariables = {
    # Disable all forgit aliases.
    FORGIT_NO_ALIASES = "true";
    # https://github.com/wfxr/forgit#fzf-options
    FORGIT_FZF_DEFAULT_OPTS = ''
      --cycle
      --reverse
      --border
      --pointer='▶'
      --height '100%'
      --preview-window='right:80%'
    '';
    FORGIT_STASH_FZF_OPTS = ''
      --bind=\"ctrl-d:reload(git stash drop \$(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)\"
      --bind=\"ctrl-y:execute(printf '"%q"' \$(cut -d: -f1 <<<{}) | ''${FORGIT_COPY_CMD:-pbcopy})\"
    '';
  };

  programs.zsh.plugins = [
    {
      # Git fuzzy commands.
      name = "forgit";
      src = builtins.fetchGit {
        url = "https://github.com/wfxr/forgit.git";
        ref = "master";
        rev = "85ccdd3f809d9e9892403a631f980406d4a278c6";
      };
    }
  ];

  # https://github.com/wfxr/forgit#shell
  programs.zsh.shellAliases = {
    gb = "git checkout -b"; # branch
    gd = "git difftool --no-symlinks --dir-diff"; # diff
    gds = "git difftool --no-symlinks --dir-diff --staged"; # diff staged
    gs = "git status -s"; # status
    gc = "git commit -v"; # commit
    gcm = "git commit -v -m"; # commit message
    ga = "forgit::add"; # add interactive
    gai = "git add -p"; # add interactive
    gl = "forgit::log"; # log
    gr = "forgit::reset::head"; # reset
    gu = "forgit::checkout::file"; # undo
    go = "forgit::checkout::branch"; # checkout
    gp = "git push"; # push
    gf = "git pull --rebase --prune"; # fetch
  };

  home.packages = [ 
	git-review
	git-branches
  ];

}

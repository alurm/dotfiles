{
  pkgs,
  lib,
  enquote,
  enpath,
  username,
  full-name,
  email,
  system-dir,
}: {
  # Keep this in case I want to use Neovim.
  nvim."init.lua" = builtins.readFile ./neovim/init.lua;

  yamlfmt.".yamlfmt" = ''
    formatter:
      type: basic
      indentless_arrays: true
      retain_line_breaks: true
  '';

  # Keep this in case I want to use Emacs.
  # emacs."init.el" = builtins.readFile ./emacs/init.el;

  wezterm."wezterm.lua" = builtins.readFile ./wezterm/wezterm.lua;

  fish = import ./fish pkgs;

  direnv.direnvrc = ''
    source ~/.nix-profile/share/nix-direnv/direnvrc
  '';

  git = {
    config = ''
      [init]
      defaultBranch = main

      [user]
      name = ${full-name}
      email = ${email}
    '';
    ignore = ''
      .DS_Store
    '';
  };

  jj."config.toml" = ''
    "$schema" = "https://jj-vcs.github.io/jj/latest/config-schema.json"

    [user]
    name = "${full-name}"
    email = "${email}"

    [ui]
    diff-editor = ":builtin"
    pager = ["less", "-FR"]

    [aliases]
    init = ["git", "init"]
  '';

  helix = {
    "config.toml" = builtins.readFile ./helix/config.toml;
    "languages.toml" = builtins.readFile ./helix/languages.toml;
  };

  # Keep this for now in case I want to use Ghostty again.
  ghostty.config = builtins.readFile ./ghostty/config;
}

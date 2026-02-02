{
  inputs = {
    lsbig.url = "github:alurm/lsbig";
    json2dir.url = "github:alurm/json2dir";
    ki-editor.url = "github:ki-editor/ki-editor";
  };

  outputs = {
    nixpkgs,
    lsbig,
    json2dir,
    ki-editor,
    ...
  }: let
    system = "aarch64-darwin";

    pkgs = import nixpkgs {
      inherit system;

      # Unfree software can be listed here.
      config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [];
    };

    lib = pkgs.lib;

    my = rec {
      enquote = lib.escapeShellArg;
      enpath = x: enquote (builtins.concatStringsSep "/" x);
      system-dir = ["My" "code"];
      full-name = "Alan Urmancheev";
      email = "alan.urman@gmail.com";
      username = "alurm";
    };

    home = import ./home.nix (my // {inherit pkgs lib;});
  in {
    inherit home;

    # https://nixos.org/manual/nixpkgs/stable/#sec-declarative-package-management
    # symlinkJoin can be used instead, but it doesn't fail on duplicate paths.
    packages.${system}.default = pkgs.buildEnv {
      name = "profile";
      paths = with pkgs; [
        # Home

        # A dummy package with all the deps of home.
        
        (import ./packages/home.nix {inherit system pkgs home;})

        # Updates home.

        (import ./packages/update-home.nix {
          inherit json2dir system writeShellApplication my;
        })

        # My software

        lsbig.packages.${system}.default
        json2dir.packages.${system}.default

        # Scripts, wrappers

        (import ./packages/my-acme.nix pkgs)

        # Tools

        jujutsu
        atool
        rlwrap
        git
        ffmpeg
        yt-dlp

        # Text editors

        helix
        ki-editor.packages.${system}.default

        ## Used rarely or niche

        gemini-cli
        bat
        ripgrep
        cloc
        entr
        exiftool
        eyed3
        moreutils
        imagemagick
        fd
        pandoc
        rclone
        tiddlywiki

        # Programming and configuration languages of sorts

        go
        lua5_4
        jq
        gawk
        cue
        ghc
        ghostscript
        nodejs

        # Zig

        zig
        zls

        # Python

        pyright
        (python3.withPackages (_: with _; [ipython requests]))

        # Bash

        bash-language-server
        shfmt
        shellcheck

        # Nix

        direnv
        nix-direnv
        nil
        # Seems to be better to me than nixfmt-rfc-style.
        alejandra

        # JavaScript

        prettier

        # Emacs
        #
        # emacs.pkgs.vterm
        # emacs.pkgs.treesit-grammars.with-all-grammars
        # emacs.pkgs.nix-ts-mode
      ];
    };
  };
}

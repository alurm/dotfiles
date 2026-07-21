pkgs: {
  functions."fish_prompt.fish" = ''
    function fish_prompt
        printf '$ '
    end

    # macOS already does a good enough job.
    function fish_title; end
  '';

  "config.fish" = ''
    if status is-login
        set --export fish_greeting '''

        # Disable echoing of ^D, ^C, and other control characters.
        stty -echoctl

        # # Like Neovim, but reuses the same instance if possible.
        # # Also waits for a buffer to be deleted.
        # set --export EDITOR 'nvr --remote-wait'

        # Needed for a manually installed patched version.
        set --export HELIX_RUNTIME ~/.nix-profile/lib/runtime

        set --export EDITOR hx

        # === Plan 9 ===

        # set --export PLAN9 ''${pkgs.plan9port}/plan9

        # Use the default MacOS monospace font.
        set --export font /mnt/font/Menlo-Regular/13a/font

        set --export prompt \n

        # === Plan 9 ===

        # === Python ===

        ## Allow installation of packages via `nix profile add`.

        set --export PYTHONPATH ~/.nix-profile/lib/python${
          ({ major, minor, ... }: "${major}.${minor}") pkgs.python3.sourceVersion
        }/site-packages

        # === Python ===

        # === PATH ===

        # To allow for local customizations.
        set --export --prepend PATH \
            ~/.cargo/bin \
            # Required for Zed for some reason.
            ~/.nix-profile/bin \
            ()

        set --export --append PATH \
            '/Applications/Visual Studio Code.app/Contents/Resources/app/bin' \
            /Applications/Emacs.app/Contents/MacOS \
            ~/go/bin \
            ${pkgs.tiddlywiki}/bin \
            $PLAN9/bin \
            ()

        # === PATH ===
    end
  '';
}

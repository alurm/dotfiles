pkgs: {
  functions."fish_prompt.fish" = ''
    function fish_prompt
      # `\n\n` is nice, but interacts badly with less.
      # Less shows a `:` prompt.
      # After pressing `q`, a newline is printed which causes text to go up, which is annoying.
      # So let's try using just `$ `.
      printf '$ '
    end

    # MacOS already does a good enough job.
    function fish_title
    end
  '';

  "config.fish" = let
    plan9 = ''
      # Plan 9 configuration

      set --export PLAN9 ${pkgs.plan9port}/plan9

      # Use the default MacOS monospace font.
      set --export font /mnt/font/Menlo-Regular/13a/font

      set --export prompt \n

      # End of Plan 9 configuration
    '';

    # Keep this in case I want to use Ki.
    ki-editor = ''
      # Ki Editor configuration

      set --export KI_EDITOR_THEME 'Mqual Blue'

      # End of Ki Editor configuration
    '';
  in ''
    if status is-login
      # To-do: should this be set somehow differently?
      set --export fish_greeting '''

      # # Like Neovim, but reuses the same instance if possible.
      # # Also waits for a buffer to be deleted.
      # set --export EDITOR 'nvr --remote-wait'

      # Needed for a manually installed patched version.
      set --export HELIX_RUNTIME ~/.nix-profile/lib/runtime

      set --export EDITOR hx

      ${ki-editor}

      direnv hook fish | source

      ${plan9}

      # Usually not needed, but somehow Zed doesn't this one unless set here.
      set --export --prepend PATH ~/.nix-profile/bin

      # To allow for local customizations.
      set --export --prepend PATH \
        ~/.cargo/bin \
      ;

      set --export --append PATH \
        '/Applications/Visual Studio Code.app/Contents/Resources/app/bin' \
        /Applications/Emacs.app/Contents/MacOS \
        ~/go/bin \
        ${pkgs.tiddlywiki}/bin \
        $PLAN9/bin \
      ;
    end
  '';
}

my @ {lib, ...}:
builtins.foldl' lib.recursiveUpdate {} [
  {
    ".config" = import ./config my;
    Library = import ./library my;

    ".codex"."AGENTS.md" = builtins.readFile ./config/codex/AGENTS.md;

    # Suppresses the login message in new terminal sessions.
    ".hushlogin" = "";

    lib.profile = ''
      # Otherwise 9term.app seems to set it to the login shell for some reason.
      SHELL = rc
      cd $home/Desktop
    '';
  }

  (lib.setAttrByPath my.system-dir {
    plan9port.mac."9term.app".Contents.MacOS."9term" = [
      "script"
      ''
        #!/usr/bin/env -S ''${SHELL} -l
        export NO_COLOR=1
        export PAGER=cat

        # I haven't found a saner way to do this without using "open".
        # Without having trouble with permissions, that is.
        exec \
        open \
        -a \
        /Users/${my.enquote my.username}/${my.enpath my.system-dir}/plan9port/bin/9term \
        --args \
        rc \
        -l \
        ;
      ''
    ];
  })
]

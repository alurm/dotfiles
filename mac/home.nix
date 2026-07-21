my @ {lib, ...}:
builtins.foldl' lib.recursiveUpdate {} [
  (
    lib.setAttrByPath (
      my.system-dir ++ ["plan9port" "mac" "9term.app" "Contents" "MacOS" "9term"]
    ) [
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
    ]
  )
  {
    lib.profile = ''
      # Otherwise 9term.app seems to set it to the login shell for some reason.
      SHELL = rc
      cd $home/Desktop
    '';

    Library = {
      LaunchAgents =
        # let
        #   # Seems like these have to be loaded manually once afterwards.
        #   # launchctl load ~/Library/LaunchAgents/...
        #   _make-service = {
        #     name,
        #     script,
        #   }: {
        #     "${name}.plist" = ''
        #       <?xml version="1.0" encoding="utf-8"?>
        #       <plist version="1.0">
        #         <dict>
        #           <key>Label</key>
        #           <string>${lib.escapeXML name}</string>
        #           <key>KeepAlive</key>
        #           <true/>
        #           <key>ProgramArguments</key>
        #           <array>
        #             <string>/usr/local/bin/fish</string>
        #             <string>-l</string>
        #             <string>-c</string>
        #             <string>
        #               ${lib.escapeXML script}
        #             </string>
        #           </array>
        #         </dict>
        #       </plist>
        #     '';
        #   };
        # in
        {}
        # Keep these for now in case I want them back.
        #
        # // make-service {
        #   name = "alurm.webdav";
        #   script = ''
        #     cd ~/Desktop/Syncthing &&
        #     exec rclone serve webdav .
        #   '';
        # }
        # // make-service {
        #   name = "alurm.tiddlywiki.main";
        #   script = ''
        #     cd ~/Desktop/Syncthing/TiddlyWikis/Main &&
        #     exec \
        #     ${pkgs.tiddlywiki}/bin/tiddlywiki \
        #     --listen port=8080 host=127.0.0.1
        #   '';
        # }
        ;
    };

    ".sqliterc" = ''
      .mode box
    '';

    # Suppresses the login message in new terminal sessions.
    ".hushlogin" = "";

    ".codex"."AGENTS.md" = ''
      In a Jujutsu repository, prefer `jj` for version-control operations; Git is also allowed when useful or required by tooling.
      For parallel work in the same repository, consider a separate `jj` workspace per agent, usually in a sibling directory of the primary workspace.
      When Git-dependent tooling is needed, verify that the workspace is colocated with Git.

      When creating a commit, add an `Assisted-by: AGENT_NAME:MODEL_VERSION` trailer, for example `Assisted-by: Codex:gpt-5.6-sol`.
      Aim for commit subjects of 52 characters or fewer when practical, and wrap body text at 72 characters.

      If a repository has no `AGENTS.md` but has a `CLAUDE.md`, read `CLAUDE.md` as repository guidance.

      Do not push commits or create issues or pull requests without explicit approval. Treat tentative language as discussion, not authorization; if unsure, ask first.
    '';

    ".config" = import ./config my;
  }
]

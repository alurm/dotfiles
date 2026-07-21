my: {
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
}

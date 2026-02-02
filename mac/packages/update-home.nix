{ json2dir, system, writeShellApplication, my }: writeShellApplication {
  name = "update-home";
  text = ''
    cd ~

    # --quiet --quiet removes warnings for uncommited changes.
    nix eval ~/${
      my.enpath my.system-dir
    }/nix/mac#home --json --quiet --quiet "$@" |
    ${json2dir.packages.${system}.default}/bin/json2dir
  '';
}

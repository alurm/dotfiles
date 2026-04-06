{ json2dir, system, writeShellApplication, my }: writeShellApplication {
  name = "apply-dotfiles";
  text = ''
    cd ~

    # --quiet --quiet removes warnings for uncommited changes.
    nix eval ~/${my.enpath my.system-dir}/alurm/dotfiles/mac#home --json --quiet --quiet "$@" |
    ${json2dir.packages.${system}.default}/bin/json2dir
  '';
}

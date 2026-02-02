{
  system,
  pkgs,
  home,
}:
derivation {
  inherit system;

  name = "home-dependencies";
  builder = "/bin/bash";
  args = ["-c" "${pkgs.coreutils}/bin/mkdir $out"];
  passAsFile = ["home"];
  dependencies = builtins.toJSON home;
}

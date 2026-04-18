pkgs: (pkgs.writeShellApplication {
  name = "my-acme";
  text = ''
    PAGER=cat \
    SHELL=rc \
    EDITOR=E \
    TERM=dumb \
    NO_COLOR=1 \
    prompt=$'\n' \
    exec \
    acme \
    -f "''${font:?}" \
    -a \
    "$@"
  '';
})

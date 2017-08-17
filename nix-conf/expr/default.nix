# If the `pkgs` variable isn't provided, we use <nixpkgs>.
{ pkgs ? import <nixpkgs> {} }: with pkgs;

# Defines a set of mutually recursive set of attributes (they can reference each
# other without issue).
rec {
    hello = callPackage ./hello {};

    powerlevel9k = callPackage ./powerlevel9k {};
}

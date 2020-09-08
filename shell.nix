{ pkgs ? import <nixpkgs> {} }:

let sources = import ./nix/sources.nix;
    pkgs = import sources.nixpkgs {};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.time
    pkgs.gnumake

    # keep this line if you use bash
    pkgs.bashInteractive
  ];
}

{ pkgs ? import <nixpkgs> {} }:

let sources = import ./nix/sources.nix;
    pkgs = import sources.nixpkgs {};
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    time
    gnumake
    haskellPackages.hp2pretty

    # keep this line if you use bash
    bashInteractive
  ];
}

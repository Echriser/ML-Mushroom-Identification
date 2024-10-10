{ pkgs ? import <nixpkgs> {
  config.allowUnfree = true;
} }:

with pkgs;

mkShell {
  buildInputs = [
    julia
    vscode
    vscode-extensions.julialang.language-julia
    vscode-extensions.ms-vsliveshare.vsliveshare
  ];
}

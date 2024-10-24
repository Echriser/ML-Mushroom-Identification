{ pkgs ? import <nixpkgs> {
  config.allowUnfree = true;
} }:

with pkgs;

mkShell {
  buildInputs = [
    julia
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        julialang.language-julia
        ms-vsliveshare.vsliveshare
        vscode-extensions.ms-toolsai.jupyter
      ];
    })
    gcc
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=$(dirname $(gcc -print-file-name=libquadmath.so)):$LD_LIBRARY_PATH
  '';
}

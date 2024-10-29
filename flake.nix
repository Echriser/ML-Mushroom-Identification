{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      in
      {
        devShell = with pkgs; mkShell {
          buildInputs = [
            julia
            (vscode-with-extensions.override {
              vscodeExtensions = with vscode-extensions; [
                julialang.language-julia
                ms-vsliveshare.vsliveshare
                vscode-extensions.ms-toolsai.jupyter
              ];
            })
            pkgs.gcc.cc.lib
          ];
          shellHook = ''
            export LD_LIBRARY_PATH=$(dirname $(gcc -print-file-name=libquadmath.so)):$LD_LIBRARY_PATH
          '';
        };
      }
    );
}

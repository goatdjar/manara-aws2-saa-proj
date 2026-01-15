# in flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
  };
  outputs = { self, nixpkgs, flake-utils, nixpkgs-terraform }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            terraform = nixpkgs-terraform.packages.${system}."1.8.0";
            inherit system;
          };
        in
        with pkgs;
        {
          devShells.default = mkShell rec {
            name = "Sandbox Development Environment";
            packages = with pkgs; [
              python312
              python312Packages.python-lsp-ruff
              python312Packages.python-lsp-server

              uv

              gh

              opentofu
              tofu-ls

              terraform
              terraform-ls

              awscli2

              docker_29

              # ruff-lsp
              # rust-analyzer
            ];

            buildInputs = [
              # rust-bin.stable.latest.default
            ];

            shellHook = ''
              export PIP_PREFIX="$PWD/_build/pip_packages"
              export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH"
              export PATH="$PIP_PREFIX/bin:$PATH"
            '';

          };
        }
      );
}

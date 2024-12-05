# list recipes
help:
  just --list

# Update the flake lock file
update:
  nix flake update

# Lint all files (similar to GitHub Actions), setup nix-shell
lint:
  nix develop --accept-flake-config .#lint

# format all the files, when in a nix-shell
format:
  nixpkgs-fmt .
  stylua .

# check all files (similar to GitHub Actions), when in a nix-shell
check:
  actionlint
  yamllint .
  selene .
  stylua --check .
  statix check
  nixpkgs-fmt --check .

# Check flake evaluation
test:
  nix flake check --no-build --all-systems

let
  fixedNixpkgs = (import ../lib.nix).fetchNixPkgs;
in { pkgs ? (import fixedNixpkgs {}), supportedSystems ? [ "x86_64-linux" ] }:


let
  iohkpkgs = import ./../default.nix { inherit pkgs; };
in rec {
  inherit (iohkpkgs) cardano-report-server-static cardano-sl-static cardano-sl-explorer-static cardano-sl stack2nix;
  cardano-node-image = (import <nixpkgs/nixos/lib/eval-config.nix> {
    system = "x86_64-linux";
    modules = [
      (import ./../deployments/cardano-nodes.nix).node0
      (import ./../modules/amazon-image.nix)
      # Just build packages
      ({ lib, ...}: { services.cardano-node.enable = lib.mkForce false;})
    ];
  }).config.system.build.amazonImage;
  tests = import ./../tests { inherit pkgs supportedSystems; };
}

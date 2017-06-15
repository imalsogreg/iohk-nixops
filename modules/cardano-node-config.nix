# TODO: get rid of this duplication between config.nix and modules/cardano-node.nix
# XXX: rename this file:  cardano-node-config vs. cardano-nodes-config is CRUEL
with (import ./../lib.nix);

testIndex: region: innerTier:
  { pkgs, ...}: {
    imports = [
      ./common.nix
    ];

    services.cardano-node = {
      enable = true;
      testIndex = testIndex;
      port = cconf.nodePort;
      staticPeers = innerTier == true && cconf.tieringEnabled == true;
      inherit (cconf) enableP2P genesisN slotDuration networkDiameter mpcRelayInterval;
      inherit (cconf) totalMoneyAmount bitcoinOverFlat productionMode systemStart richPoorDistr;
    };
  }

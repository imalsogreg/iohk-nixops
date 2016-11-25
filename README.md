Collection of tools to deploy Serokell infrastructure.

File structure

- `deployments` includes all NixOps deployments controlled via `Cardano*.hs` scripts
- `modules` has NixOS modules
- `lib.nix` warps upstream `<nixpkgs/lib.nix>` with our common functions
- `scripts` has bash scripts not converted to Haskell/Turtle into Cardano.hs yet
- `srk-nixpkgs` is a collection of upstream Serokell packages
- `static` includes files being static, not generated
- `release.nix` is used by Hydra CI


### Getting started

Check out nixpkgs repository to the root (~/nixpkgs) using branch `release-16.09`.

### Compiling localy 

./Cardano.hs build

### Deploying changes

./Cardano.hs deploy

Note this will not remove machines if they no longer exist. 

### Removing machines

If you want to remove a machine simply remove them in the bottom part of the `nixops.nix` file.
Then run `nixops deploy` with `-k`:

./Cardano.hs deploy

### List all deployments

`nixops list`

### Infos about all machines (including public IPs)

`nixops info [-d deployment]`

### Connect to a machine

`nixops ssh -d deployment machine-name`

Replace `machine-name` with the machine you want to connect to (from `info` call).

### Destroy everything

./Cardano.hs destroy

### Building AMIs

To generate the disk image:

    $ GENERATING_AMI=1 nix-build release.nix -A image -o image -I ~/

Note that this will take more than an hour to build.
See https://github.com/NixOS/nixpkgs/issues/20471 for more about the slowness.

To upload and use the new disk image as AMI:

    $ ./scripts/create-amis.sh

This will update `modules/amis.nix` so make sure to commit it.

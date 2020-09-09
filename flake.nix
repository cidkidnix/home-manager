{
  description = "Home Manager for Nix";

  outputs = { self, nixpkgs, config }: rec {
    nixosModules.home-manager = import ./nixos nixpkgs;

    darwinModules.home-manager = import ./nix-darwin nixpkgs;

    lib = {
      homeManagerConfiguration = { configuration, system, homeDirectory
        , username
        , pkgs ? builtins.getAttr system nixpkgs.outputs.legacyPackages
        , check ? true }@args:
        import ./modules {
          inherit pkgs check;
          configuration = { ... }: {
            imports = [ configuration ];
            home = { inherit homeDirectory username; };
          };
        };
    };
  };
}

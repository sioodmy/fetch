{

  description = "Simple fetch script";

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.fetch;

    packages.x86_64-linux.fetch =

      let

        pkgs = import nixpkgs { system = "x86_64-linux"; };

      in pkgs.writeShellScriptBin "fetch" (builtins.readFile ./fetch);
  };

}

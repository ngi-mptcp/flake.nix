{
  description = "A collection of multipath TCP related software";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    mptcpanalyzer.url = "github:ngi-mptcp/mptcpanalyzer";
  };

  outputs = { self, unstable }: let
    nixpkgs = unstable;
  in {

    packages.x86_64-linux = {
      linux_mptcp_95 = nixpkgs.lib.callPackage ./pkgs/linux-mptcp-95.nix {
        kernelPatches = linux_4_19.kernelPatches;
      };

      # ebpfdropper = prev.callPackage ./ebpfdropper.nix {
      #   stdenv=prev.clangStdenv;
      #   llvm=prev.llvm_5;
      # };

      # packetdrill-mptcp = prev.packetdrill.overrideAttrs ( oa: { });
    };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.mptcpplot;

  };
}

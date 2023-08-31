{ lib, ... }:

{
  # ----- Packages -----
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"

    # (retroarch.override {
      # cores = with libretro; [
	# melonds
        # mgba
      # ];
    # })
  ];
 

  # ----- Steam -----
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;  # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false;  # Open ports in the firewall for Source Dedicated Server
  };


  # ----- Add Missing Dependencies -----
  # https://nixos.wiki/wiki/Steam
}

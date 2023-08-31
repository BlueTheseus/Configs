# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # SERVER
        #./server/ssh.nix
        #./server/samba-server.nix
        #./server/freshrss.nix

      # DESKTOP
        # UTILS
          #./desktops/nvidia.nix
          #./desktops/gaming.nix
        # X11
          #./desktops/gnome-x11.nix
          #./desktops/awesomewm.nix
          #./desktops/dwm.nix
          #./desktops/i3wm.nix
        # Wayland
          #./desktops/gnome.nix
          #./desktops/hyperland.nix
          #./desktops/dwl.nix
          #./desktops/sway.nix
    ];


  # ----- BOOT -----
  # SystemD Boot
    boot.loader.systemd-boot.enable = true;
  # GRUB 2 Boot
    # boot.loader.grub.enable = true;
    # boot.loader.grub.efiSupport = true;
    # boot.loader.grub.efiInstallAsRemovable = true;
    boot.loader.grub.device = "/dev/sda"; # Define on which hard drive you want to install Grub, or use "nodev" for efi only
  # EFI
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.loader.efi.efiSysMountPoint = "/boot/efi";


  # ----- NETWORKING -----
  networking.hostName = "nixos";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.


  # ----- LOCALIZATION -----
  # Set your time zone.
  time.timeZone = "";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Fonts
  # IBM's Blex nerd font
  # intel's font

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };


  # ----- USERS -----
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };


  # ----- SYSTEM PACKAGES -----
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Minimum
    micro
    nano
    neovim
    gcc
    cryptsetup
    tomb
    pinentry-curses  # needed by tomb

    # Terminal
    btop
    exiftool  # file metadata
    ffmpeg
    fzf
    lf  # file manager
	nerdfonts
    neofetch
    powertop
    rsync
    tlp
    trash-cli  # don't accidentally rm something important ;)

    # Networking
    curl
    git
    networkmanager
    tailscale
    #wget
    wpa_supplicant
    yt-dlp
  ];


  # ----- SYSTEM CONFIGURATION -----
  # todo: make sure /git/configs exists, clone configs, and link them to where needed


  # ----- SYSTEM OPTIONS -----
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?


  # ----- FIREWALL -----
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];  # Tell the firewall to implicitly trust packets routed over Tailscale
    # Open ports in the firewall.
    # allowedTCPPorts = [ 443 ];  # freshrss?
    # allowedUDPPorts = [ ... ];
  };


  # ----- SYSTEM SECURITY -----
  nix.settings.allowed-users = [ "@wheel" ];


  # ----- SUID WRAPPERS -----
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  # ----- SERVICES -----

  # ~~ Tailscale ~~
  services.tailscale.enable = true;


}


{ config, pkgs, ... }:

{
  # ----- X11 and Gnome -----
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.autoSuspend = false;  # Auto-suspend prevents connecting as a server
    # The following steps may also be required to fully disable auto-suspend:
    # dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-timeout 0
    # dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-timeout 0
    # restart gdm (kill process or reboot)


  # ----- Packages -----
  environment.systemPackages = with pkgs; [
    # anki  # flashcards
    brave  # browser
    discord
    # firefox  # browser
    mpv  # video and music player
    obsidian  # notes
    wezterm  # terminal emulator
    zathura  # pdf/epub viewer

    # Gnome-Specific
	# gnome.gnome-tweaks
    gnomeExtensions.appindicator  # extension for system tray icons
    gnomeExtensions.pop-shell
    gnomeExtensions.tailscale-status
  ];

  # Exclude select default Gnome applications
  environment.gnome.excludePackages = (with pkgs; [
    gnome-connections
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese  # webcam tool
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    # gnome-system-monitor
    gnome-terminal
    gnome-weather
    gedit  # graphical text editor
    epiphany  # web browser
    geary  # email reader
    evince  # document viewer
    totem  # video player
    simple-scan  # document scanner utility
    tali  # poker game
    iagno  # go game
    hitori  # sudoku game
    atomix  # puzzle game
  ]);
    # text editor
    # help
    # disk usage analyzer
    # disks
    # image viewer
    # archive manager
    # passwords and keys
    # logs
    # fonts
    # console

  # Flatpak for Obsidian.md ?
  #services.flatpak.enable = true;


  # ----- Configurations -----
  # brave
  # discord?
  # mpv
  # obsidian
  # wezterm
  # zathura


  # ----- Configure keymap in X11 -----
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:escape";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";


  # ----- Sound -----
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # ----- Automatic Login -----
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "account";
  # Auto-Login workaround as of 2023
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;


  # ----- Touchpad -----
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # ----- Printing -----
  # Enable CUPS to print documents.
  # services.printing.enable = true;


  # ----- Gnome Extensions -----
  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon  # used for system tray icons
  ];
}

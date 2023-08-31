
{ config, pkgs, ... }:

{
  # ----- X11 and AwesomeWM -----
  services.xserver = {
    enable = true;
    displayManager = {
      # startx.enable = true;
      sddm.enable = true;
      defaultSession = "none+awesome";
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks  # package manager for Lua modules
        luadbi-mysql  # database abstraction layer
      ];
    };
    # dpi = 180;
  };

  # environment.variables = {
    # GDK_SCALE = "2";
    # GDK_DPI_SCALE = "0.5";
    # _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  # };

  


  # ----- Packages -----
  environment.systemPackages = with pkgs; [
    brave
    discord
    # firefox
    mpv
    wezterm
    zathura
  ];
 

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
  # Auto-Login workaround as of 2023:
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;


  # ----- Touchpad -----
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # ----- Printing -----
  # Enable CUPS to print documents.
  # services.printing.enable = true;
}

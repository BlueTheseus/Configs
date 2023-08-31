{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openssh
  ];

  # SSH Host
  services.openssh = {
    enable = true;

    # knownHosts = {
      # name = {
        # hostNames = [ ];  # list of strings
        # extraHostNames = [ ];  # list of strings
        # certAuthority = ;  # boolean
        # publicKey = ;  # null or string
        # publicKeyFile = ;  # null or path
      # };
    # };

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true; # Disable once you have exchanged keys
      X11Forwarding = false;
    };

    openFirewall = true;  # Automatically open specified ports in the firewall
    listenAddresses = [
      {addr = "0.0.0.0"; port = 0;}
    ];
    startWhenNeeded = false;  # sshd is socket-activated -- systemd starts an instance for each incoming connection instead of running the daemon

    ports = [ 0 ];
    # banner = "";  # Accepts strings concatenated with '\n'. Displayed to remote user before authentication is allowed
  };
}

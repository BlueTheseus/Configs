{ config, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Samba

  environment.systemPackages = with pkgs; [
    cifs-utils  # makes mounting samba shares from cli easier
    samba
  ];

  # Samba Client
  fileSystems."/mnt/share" = {
	device = "//<IP_OR_HOST>/path/to/share";
	fsType = "cifs";
	options = let
	  # this line prevents hanging on network split
	  automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
	in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };
  # Create /etc/nixos/smb-secrets with the following content (domain can be optional)
  # username=<USERNAME>
  # domain=<DOMAIN>
  # password=<PASSWORD>

  # Firewall
  # networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';

  # Browse Samba Shares with GVFS
  # services.gvfs.enable = true;
  # environment.systemPackages = with pkgs; [ lxqt.lxqt-policykit ]; # provides a default authentification client for policykit
  # If you happen to start your Window Manager directly, you should ensure that you launch dbus at startup in your session and export its environment. See https://nixos.wiki/wiki/Samba
}

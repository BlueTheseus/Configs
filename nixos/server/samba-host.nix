{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #cifs-utils  # makes mounting samba shares from cli easier
    samba
  ];

  # Samba Host
  services.samba = {
    enable = true;
    # openFirewall = true;
    securityType = "user";
    # syncPasswordsByPam = true;  # ?
    extraConfig = ''
      workgroup = WORKGROUP
      server role = standalone server
      dns proxy = no
      vfs objects = fruit streams_xattr catia

      pam password change = yes
      map to guest = bad user
      usershare allow guests = yes
      create mask = 0664
      force create mode = 0664
      directory mask = 0775
      force directory mode = 0775
      follow symlinks = yes
      load printers = no
      printing = bsd
      printcap name = /dev/null
      disable spoolss = yes
      strict locking = no
      aio read size = 0
      aio write size = 0
      vfs objects = acl_xattr catia fruit streams_xattr
      inherit permissions = yes

      # Security
      client ipc max protocol = SMB3
      client ipc min protocol = SMB2_10
      client max protocol = SMB3
      client min protocol = SMB2_10
      server max protocol = SMB3
      server min protocol = SMB2_10

      # Time Machine
      # fruit:delete_empty_adfiles = yes
      # fruit:time machine = yes
      # fruit:veto_appledouble = no
      # fruit:wipe_intentionally_left_blank_rfork = yes
      # fruit:posix_rename = yes
      # fruit:metadata = stream


      # server string = smbnix
      # netbios name = smbnix
      # disable netbios = yes
      # smb encrypt = required  # ?
      # use sendfile = yes
      #interfaces = lo eth0
      # 127.0.0.0/8 eth0
      #bind interfaces only = yes
      # note: localhost is the ipv6 localhost ::1
      # hosts allow = 192.168.0 127.0.0.1 localhost
      # hosts deny = 0.0.0.0/0
      #guest account = nobody

      # This tells Samba to use a separate log file for each machine
      # that connects
        # log file = /var/log/samba/log.%m

      # Cap the size of the individual log files (in KiB).
        # max log size = 1000

      # We want Samba to only log to /var/log/samba/log.{smbd,nmbd}.
      # Append syslog@1 if you want important messages to be sent to syslog too.
        # logging = file

      # Do something sensible when Samba crashes: mail the admin a backtrace
        # panic action = /usr/share/samba/panic-action %d

      # Apple Device Compatability
      # vfs objects = fruit streams_xattr catia
      # fruit:metadata = stream
      # fruit:model = MacSamba
      # fruit:posix_rename = yes
      # fruit:veto_appledouble = no
      # fruit:nfs_aces = no
      # fruit:wipe_intentioanlly_left_blank_rfork = yes
      # fruit:delete_empty_adfiles = yes
    '';
    shares = {
      public = {
        path = "/mnt/Shares/Public";
        browseable = "yes";
        "read only" = "no";

        # Public - Allow Anyone
        "guest ok" = "yes";
        #"force user" = "nobody";
        #"force group" = "users";
        #"create mask" = "0644";
        #"directory mask" = "0755";
        #"force user" = "username";
        #"force group" = "groupname";

        # "veto files" = "";
        # "delete veto files" = "yes";
      };
      private = {
        path = "/mnt/Shares/Private";
        browseable = "yes";
        "read only" = "no";

        # Private - Must provide valid login
        "guest ok" = "no";
        "valid users" = "nico";
        #"create mask" = "0644";
        #"directory mask" = "0755";
        #"force user" = "username";
        #"force group" = "groupname";

        # "veto files" = "";
        # "delete veto files" = "yes";
      };
      Portal = {
        path = "/mnt/local/Portal";
        browseable = "yes";
        "read only" = "no";

        # Private - Must provide valid login
        "guest ok" = "no";
        "valid users" = "nico";
        #"create mask" = "0664";
        #"directory mask" = "0755";
        #"force user" = "username";
        #"force group" = "groupname";

        # "veto files" = "";
        # "delete veto files" = "yes";
      };
      "School" = {
        path = "/mnt/local/School";
        browseable = "yes";
        "read only" = "no";

        # Private - Must provide valid login
        "guest ok" = "no";
        "valid users" = "nico";
        #"create mask" = "0644";
        #"directory mask" = "0755";
        #"force user" = "username";
        #"force group" = "groupname";

        # "veto files" = "";
        # "delete veto files" = "yes";
      };
    };
  };
  # directory /var/lib/samba/private must be accessible by samba (root) for smbpasswd
  #networking.firewall.allowedTCPPorts = [ 445 139 ];
  #networking.firewall.allowedUDPPorts = [ 137 138 ];
  services.avahi = {
    enable = true;
    #nssmdns = true;
    #publish = {
      #enable = true;
      #addresses = true;
      #domain = true;
      #hinfo = true;
      #userServices = true;
      #workstation = true;
    #};
    extraServiceFiles = {
      smb = ''
      <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
      <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
      <service-group>
        <name replace-wildcards="yes">%h</name>
        <service>
          <type>_smb._tcp</type>
          <port>445</port>
        </service>
      </service-group>
      '';
    };
  };
}

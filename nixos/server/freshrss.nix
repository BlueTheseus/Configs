{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freshrss
  ];

  # make sure the directory is created: /srv/freshrss/data

  services.freshrss = {
    enable = true;
    # authType = "form";  # Authentication type for FreshRSS. Choices: "form" (default), "http_auth", "none"
    baseUrl = "http://freshrss";  # Default URL for FreshRSS
    dataDir = "/srv/freshrss/data";  # Default data folder for FreshRSS. Default: "/var/lib/freshrss"
    # defaultUser = "admin";  # Default username for FreshRSS. Default: "admin"
    language = "en";  # Default language for FreshRSS. Default: "en"
    package = pkgs.freshrss;  # Which FreshRSS package to use. Default: pkgs.freshrss
    passwordFile = /srv/freshrss/secret;  # Password for the defaultUser for FreshRSS. Default: null
    # pool = "freshrss"  # Name of the phpfpm pool to use and setup. Default: "freshrss"
    # user = "freshrss"  # User under which FreshRSS runs. Default: "freshrss"
    # virtualHost = "freshrss"  # Name of the nginx virtualhost to use and setup. Default: "freshrss"
  };
}

{ inputs, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      riotbruvxx = import ./home.nix;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Casablanca";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_MA.UTF-8";
    LC_IDENTIFICATION = "ar_MA.UTF-8";
    LC_MEASUREMENT = "ar_MA.UTF-8";
    LC_MONETARY = "ar_MA.UTF-8";
    LC_NAME = "ar_MA.UTF-8";
    LC_NUMERIC = "ar_MA.UTF-8";
    LC_PAPER = "ar_MA.UTF-8";
    LC_TELEPHONE = "ar_MA.UTF-8";
    LC_TIME = "ar_MA.UTF-8";
  };

  services.xserver.enable = true;

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  users.users."riotbruvxx" = {
    isNormalUser = true;
    description = "riotbruvxx";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      gnome-text-editor
    ];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.systemPackages = [
    pkgs.git
    pkgs.cargo
    pkgs.rustc
    pkgs.rust-analyzer
    pkgs.libnotify
    pkgs.wget
    pkgs.home-manager
    pkgs.kitty
    pkgs.vim
    pkgs.zed-editor
    pkgs.proton-vpn
    pkgs.persepolis
    pkgs.floorp-bin
    pkgs.onlyoffice-desktopeditors
    pkgs.gimp
    pkgs.vlc
    pkgs.networkmanagerapplet
    pkgs.obsidian
    pkgs.fastfetch
    pkgs.rustdesk
    pkgs.ollama-rocm
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-41.10.7"
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";
  system.autoUpgrade.allowReboot = true;

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  system.stateVersion = "26.05";

}

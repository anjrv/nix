# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices."luks-fb51bb33-b64e-499d-a768-865155cca044".device = "/dev/disk/by-uuid/fb51bb33-b64e-499d-a768-865155cca044";
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      # extraPackages = with pkgs; [
      #   rocmPackages.clr.icd
      # ];
    };
  };

  # systemd.tmpfiles.rules = [
  #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Atlantic/Reykjavik";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_NUMERIC = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
  };

  # Allow unfree packages
  nixpkgs = {
    config.allowUnfree = true;
    # overlays = [
    #   (import (builtins.fetchTarball {
    #     url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    #     sha256 = "0m9ggk5b06hxzr29zs4g86gr8swjsm8x1n5kgjnywz9nblvy7gsw";
    #   }))
    # ];
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  security.rtkit.enable = true;

  services = {
    fstrim.enable = true;
    printing.enable = true;
    libinput.enable = true;
    displayManager = {
      defaultSession = "plasma";
      autoLogin.enable = true;
      autoLogin.user = "anjrv";
    };
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      xkb.layout = "us";
      xkb.variant = "";
      # Autologin is broken with sddm 
      displayManager.lightdm.enable = true;
      excludePackages = with pkgs; [ xterm ];
    };
    desktopManager.plasma6.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    locate = {
      enable = true;
      package = pkgs.mlocate;
      localuser = null;
    };
    power-profiles-daemon.enable = true;
    # tlp = {
    #   enable = true;
    #   settings = {
    #     CPU_BOOST_ON_AC = 1;
    #     CPU_BOOST_ON_BAT = 0;
    #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    #   };
    # };
    # emacs = {
    #   package = pkgs.emacs-pgtk;
    #   enable = true;
    # };
  };

  # powerManagement.powertop.enable = true;

  # Skip some Plasma packages
  environment.plasma6.excludePackages = with pkgs.libsForQt5; [
    kate
    # elisa
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anjrv = {
    isNormalUser = true;
    extraGroups = [ "realtime" "video" "uucp" "input" "networkmanager" "wheel" "libvirtd" "docker" ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    gamescope
    mangohud
    openblas
    vim
    nano
    neovim
    whois
    curl
    wget
    git
    gcc
    killall
    nh
    nix-output-monitor
    nvd
    wl-clipboard
    xclip
    bubblewrap
    # emacs-pgtk
    # libsForQt5.polonium
  ];

  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.local/cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    PAGER = "moar";
    TERMINAL = "kitty";
    BROWSER = "firefox";
    MOZ_ENABLE_WAYLAND = "1";
    STEAM_FORCE_DESKTOPUI_SCALING = "2";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    #SDL_VIDEODRIVER = "x11";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "KDE";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "KDE";
    # WLR_NO_HARDWARE_CURSORS = "1";
    XCURSOR_SIZE = "48";
    FLAKE = "$HOME/.dotfiles";
  };

  xdg = {
    portal = {
      enable = true;
      # extraPortals = with pkgs; [
      #   xdg-desktop-portal-kde
      #   xdg-desktop-portal-gtk
      # ];
    };
  };

  programs = {
    zsh.enable = true;
    dconf.enable = true;
    xwayland.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      # gamescopeSession.enable = true;
    };
    # gamemode.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-sans-pro
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
    waydroid.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}

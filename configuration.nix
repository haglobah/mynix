# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./configuration/docker.nix
      ./configuration/secrets.nix
    ];

  config = {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # networking.hostName = "numenor"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable bluetooth
    hardware.bluetooth.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Set battery percentage warning to 30%
    services.upower.percentageLow = 30;
    services.upower.percentageCritical = 15;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us,de";
      variant = "";
    };

    programs.hyprland.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable ydotool for working with 'alles'
    systemd.services = {
      ydotoold = {
        path = [ pkgs.ydotool ];
        script = ''
          ydotoold --socket-path=/tmp/.ydotool_socket --socket-own=1000:100
        '';
        wantedBy = [ "default.target" ];
      };
      config-updater = {
        path = [
          pkgs.git
          pkgs.openssh
        ];
        script = ''
          cd /home/beat/mynix
          git pull
          cd /home/beat/nix-home
          git pull
        '';
        serviceConfig = {
          User = config.users.users.beat.name;
        };
        startAt = "*-*-* 12:00:00";
      };
    };

    # Enable sound with pipewire.
    # sound.enable = true;
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    programs.fish.enable = true;
    users.users.beat = {
      isNormalUser = true;
      description = "Beat Hagenlocher";
      extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "tty" ];
      shell = pkgs.fish;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate = (_: true);

    # Use lix instead of nix
    nixpkgs.overlays = [ (final: prev: {
      inherit (final.lixPackageSets.stable)
        nixpkgs-review
        nix-direnv
        nix-eval-jobs
        nix-fast-build
        colmena;
    }) ];

    nix = {
      package = pkgs.lixPackageSets.stable.lix;

      settings = {
        # https://github.com/NixOS/nix/issues/11728
        # download-buffer-size = 524288000;
        experimental-features = [ "nix-command" "flakes" ];
        extra-deprecated-features = [ "url-literals" ];
        trusted-users = ["root" "beat"];

        extra-substituters = [
          "https://cache.lix.systems"
        ];
        trusted-public-keys = [
          "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        ];
      };

      gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 90d";
      };
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment = {
      systemPackages = with pkgs; [
        home-manager
        bitwarden-cli

        # Samba for Storage Box
        cifs-utils
      ];

      gnome.excludePackages = with pkgs; [
        gnome-tour
        gedit
        cheese # webcam tool
        gnome-music
        epiphany # web browser
        geary # email reader
        gnome-characters
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # Help view
        gnome-contacts
        gnome-initial-setup
      ];
    };
    programs.dconf.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];

    # Mount for storage box
    fileSystems."/mnt/share" = {
      device = "//u366465.your-storagebox.de/backup";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in ["${automount_opts},credentials=${config.age.secrets.storage-box-secret.path},uid=1000,gid=100"];
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

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
  };
}

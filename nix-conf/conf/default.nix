{ config, pkgs, expr, ... }:

with builtins; with pkgs.lib; {

    imports = [
        ./desktop.nix
        ./pulseaudio.nix
    ];

    networking = {
        hostName = "mew";
        networkmanager.enable = true;
    };

    # Locale
    i18n = {
        consoleFont = "Lat2-Terminus16";
        consoleKeyMap = "us";
        defaultLocale = "en_US.UTF-8";
    };
    time.timeZone = "America/New_York";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Create an actual user.
    users.defaultUserShell = pkgs.zsh;
    users.extraUsers.slabity = {
        isNormalUser = true;
        home = "/home/slabity";
        description = "slabity";
        extraGroups = [
            "wheel"
            "networkmanager"
            "docker"
            "libvirtd"
        ];
        uid = 1000;
    };

  system.stateVersion = "17.09";
  system.nixosLabel = "mew";
  zramSwap.enable = true;

    boot = {
        # kexec into rescue mode on kernel crash.
        crashDump.enable = false;

        loader = {
            efi.efiSysMountPoint = "/boot";
            efi.canTouchEfiVariables = true;
            grub = {
                enable = true;
                device = "nodev";
                enableCryptodisk = true;
                efiSupport = true;
                useOSProber = true;
                configurationName = "Raichu";
            };
            timeout = 3;
        };

        #plymouth = {
        #    enable = true;
        #    theme = "spinner";
        #};
    };

    hardware.opengl = {
        driSupport = true;
        driSupport32Bit = true;

        # Hardware acceleration packages go here.
        #extraPackages = with pkgs; [
        #    vaapiIntel      # Video Accel API by Intel
        #    libvdpau-va-gl  # VDPAU driver using VAAPI
        #    beignet         # OpenCL for Intel
        #];
    };

    # Visual improvements
    #services.compton = {
    #    enable = true;
    #    fade = true;
    #    inactiveOpacity = "0.8";
    #    shadow = true;
    #    fadeDelta = 3;
    #    vSync = "drm";
    #};

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
        # Development
        git
        gdb
        pkgconfig
        gcc6
        valgrind
        go
        ghc                 # Haskell compiler
        python36Full
        #rustChannels.nightly.rust
        #rustChannels.nightly.rust-src
        rustracer

        # Libraries I use a lot
        libdrm

        # Utilities
        gptfdisk
        pciutils
        usbutils
        atop
        linuxPackages.netatop   # Adds networking to `atop`

        # Custom packages
        texlive.combined.scheme-full
    ];

    services.emacs.enable = true;
    services.mpd.enable = true;
    services.tlp.enable = true;
    virtualisation.docker.enable = true;
    virtualisation.libvirtd.enable = true;

    programs.tmux.enable = true;
    programs.tmux.keyMode = "vi";

    nixpkgs.config.firefox.enableAdobeFlash = true;

    programs.zsh = {
        enable = true;
        ohMyZsh = {
            enable = true;
            plugins = [
                "common-aliases"
                "compleat"
                "git"
                "git-extras"
                "sudo"
                "systemd"
                "tmux"
                "vi-mode"
                "wd"
            ];
            theme = "../../../../../..${expr.powerlevel9k}/powerlevel9k/powerlevel9k";
        };
    };

    fonts = {
        fonts = with pkgs; [
            dejavu_fonts
            source-code-pro
            source-sans-pro
            source-serif-pro
            font-awesome-ttf
            powerline-fonts
        ];
    };

    nix = {
        autoOptimiseStore = true;
        daemonNiceLevel = 1;
        daemonIONiceLevel = 1;
    };
}

{ config, pkgs, expr, ... }:

{
    services.xserver = {
        enable = true;

        # Input
        layout = "us";
        libinput.enable = true;
        libinput.tapping = false;
        libinput.tappingDragLock = false;

        # Display Manager
        displayManager.logToJournal = true;
        displayManager.lightdm.enable = true;
        displayManager.lightdm.autoLogin = {
            enable = true;
            user = "slabity";
        };
        displayManager.lightdm.greeter.enable = false;

        # Desktop Environment
        desktopManager.xterm.enable = false;
        windowManager.i3.enable = true;
        windowManager.i3.package = pkgs.i3-gaps;
        windowManager.default = "i3";

        # Drivers
        videoDrivers = [ "ati" "modesetting" ];
        useGlamor = true;
    };

    services.urxvtd.enable = true;

    environment.systemPackages = with pkgs; [
        firefox
        krita
        gimp
        steam
        patchage
        ardour
        powerline-fonts
        font-awesome-ttf
        polybar
        rofi
        dunst
        arc-theme
        paper-icon-theme
        xorg.xbacklight
    ];
}

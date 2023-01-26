# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
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

  services.flatpak.enable = true;

  # Enable the tailscale service
  services.tailscale.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zack = {
    isNormalUser = true;
    description = "Zack Lalanne";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      kate
      vlc
    ];
  };

  home-manager.users.zack = { pkgs, ... }: {

    home.stateVersion = "22.11";

    home.packages = [
      # Command line utilities
      pkgs.htop
      pkgs.nixfmt
      pkgs.rsync
      pkgs.ripgrep
      pkgs.gnumake

      # Development
      pkgs.esphome
      pkgs.yamllint

      # DevOps Tools
      pkgs.ansible

      # Media Management
      pkgs.calibre
    ];

    services.syncthing = { enable = true; };

    programs.kitty = {
      enable = true;
      theme = "Solarized Dark - Patched";
      font = {
        name = "Hack";
        package = pkgs.hack-font;
      };
      extraConfig = "enable_audio_bell no";
    };

    programs.bat = {
      enable = true;
      config = { theme = "Solarized (dark)"; };
    };

    programs.exa = {
      enable = true;
      enableAliases = true;
    };

    programs.fzf = { enable = true; };

    programs.git = {
      enable = true;
      userName = "Zack Lalanne";
      userEmail = "zack.lalanne@gmail.com";
      extraConfig = {
        color.ui = true;
        core.pager =
          "${pkgs.diff-so-fancy}/bin/diff-so-fancy | ${pkgs.less}/bin/less --tabs=4 -RFX";
        interactive.diffFilter =
          "${pkgs.diff-so-fancy}/bin/diff-so-fancy --patch";
      };
    };

    programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile ./dotfiles/nvim/treesitter.lua;
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile ./dotfiles/nvim/telescope.lua;
        }
        {
          plugin = undotree;
          type = "lua";
          config = ''
            vim.keymap.set("n", "<leader>au", ":UndotreeToggle<CR>")
          '';
        }
        {
          plugin = which-key-nvim;
          type = "lua";
          config = builtins.readFile ./dotfiles/nvim/which-key.lua;
        }
#        {
#          plugin = nvim-solarized-lua;
#          type = "lua";
#          config = ''
#            vim.cmd('colorscheme solarized')
#          '';
#        }

        # Syntax / Language Support
        nvim-lspconfig
        vim-nix

        # UI
#        vim-colors-solarized
#        vim-gitgutter
#        vim-airline
#        vim-airline-themes
      ];
      extraPackages = [
        # Make telescope / fuzzy finding better
        pkgs.ripgrep
        pkgs.fd
        # LSP related
        pkgs.rnix-lsp 
      ];
      extraConfig = ''
      let mapleader = " "
      '';
#      extraConfig = ''
#        if executable('rnix-lsp')
#          au User lsp_setup call lsp#register_server({
#          \ 'name': 'rnix-lsp',
#          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'rnix-lsp']},
#          \ 'whitelist': ['nix'],
#          \ })
#        endif
#        """"""""""""""""""""""
#        " Keybindings
#        """"""""""""""""""""""
#        let mapleader = " "
#        """"""""""""""""""""""
#        " UI
#        """"""""""""""""""""""
#        " set background=dark
#        " Set to transparent background to work better with kitty theme
#        let g:solarized_termtrans=1
#        " colorscheme solarized
#        " let g:airline_theme='solarized'
#        " let g:airline_powerline_fonts = 1
#        " Set background color of git gutter correctly
#        "highlight! link SignColumn LineNr
#      '';
    };

    programs.zsh = {
      enable = true;
      enableCompletion = false;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "rsync" "extract" "ripgrep" "docker" ];
        theme = "ys";
        extraConfig = ''
          COMPLETION_WAITING_DOTS="true"
        '';
      };
      shellAliases = {
        hme = "home-manager edit";
        hms = "home-manager switch";
        hmn = "home-manager news";
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
    vim
    google-chrome
    tailscale
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # For tailscale. Discussion: https://github.com/tailscale/tailscale/issues/4432
  networking.firewall.checkReversePath = "loose";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

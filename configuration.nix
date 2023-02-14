# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
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

  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  # Enable the tailscale service
  services.tailscale.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zack = {
    isNormalUser = true;
    description = "Zack Lalanne";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Basic tools
      file
      unzip

      # Networking Tools
      dig
      nmap
      traceroute

      # DE
      firefox
      kate
      vlc

      # One-off
      etcher
      screen
    ];
  };

  home-manager.users.zack = { pkgs, ... }:
    let
      vim-be-good = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "vim-be-good";
        src = pkgs.fetchFromGitHub {
          owner = "ThePrimeagen";
          repo = "vim-be-good";
          rev = "c290810728a4f75e334b07dc0f3a4cdea908d351";
          hash = "sha256-lJNY/5dONZLkxSEegrwtZ6PHYsgMD3nZkbxm6fFq3vY=";
        };
      };
    in
    {

      home.stateVersion = "22.11";

      home.packages = [
        # Command line utilities
        pkgs.htop
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

      programs.tmux = {
        enable = true;
        prefix = "C-a";
      };

      programs.kitty = {
        enable = true;
        theme = "Tokyo Night";
        font = {
          name = "Hack Nerd Font";
          package = pkgs.nerdfonts;
          size = 12;
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

      programs.fzf = {
        enable = true;
        defaultOptions = [
          "--color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75"
          "--color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07"
          "--color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07"
        ];
      };

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

          nvim-treesitter.withAllGrammars
          telescope-nvim
          which-key-nvim

          tokyonight-nvim
          lualine-nvim
          gitsigns-nvim

          vim-fugitive

          nvim-lspconfig
          cmp-buffer
          cmp-path
          cmp-nvim-lsp
          luasnip
          cmp_luasnip
          friendly-snippets
          nvim-cmp

          undotree
          vim-be-good

        ];
        extraPackages = [
          # Make telescope / fuzzy finding better
          pkgs.ripgrep
          pkgs.fd

          # LSP related
          pkgs.sumneko-lua-language-server
          pkgs.nil
          pkgs.nixpkgs-fmt
          pkgs.nodePackages.yaml-language-server
          pkgs.marksman
        ];
        extraConfig = ''
          lua <<EOF
            require("config.theme")
            require("config.treesitter")
            require("config.telescope")
            require("config.which-key")
            require("config.fugitive")
            require("config.lsp")
            require("config.lualine")
            require("config.gitsigns")
            require("config.general")
            require("config.keymaps")
          EOF'';
      };

      home.file = {
        ".config/nvim" = {
          recursive = true;
          source = ./dotfiles/nvim;
        };
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
  environment.systemPackages = with pkgs; [ vim google-chrome tailscale ];

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

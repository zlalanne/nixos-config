# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ ];

  services.mealie.enable = true;

  # Disable Network Manager service
  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable sound with pipewire.
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

  nix.settings.auto-optimise-store = true;

  services.flatpak.enable = true;

  # Enable the tailscale service
  services.tailscale.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zack = {
    isNormalUser = true;
    description = "Zack Lalanne";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Basic tools
      file
      unzip
      unrar-wrapper
      killall
      ncdu

      # Networking Tools
      dig
      nmap
      traceroute

      # DE
      firefox
      kate
      vlc

      # One-off
      screen

      # Proprietary apps
      zoom-us
    ];
  };

  home-manager.users.zack =
    { pkgs, ... }:
    {

      home.stateVersion = "24.05";

      home.packages = [
        # Command line utilities
        pkgs.rsync
        pkgs.ripgrep
        pkgs.gnumake
        pkgs.tig

        # Development
        pkgs.esphome
        pkgs.yamllint
        pkgs.kotlin

        # 3D Printing
        pkgs.prusa-slicer
        pkgs.openscad

        pkgs.tuxpaint

        # DevOps Tools
        pkgs.ansible

        # Media Management
        pkgs.calibre
        pkgs.libation

        pkgs.inkscape
        pkgs.audacity
        pkgs.element-desktop
      ];

      services.syncthing = {
        enable = true;
      };

      services.kdeconnect = {
        enable = true;
        indicator = true;
      };

      programs.helix = {
        enable = true;
        extraPackages = [
          pkgs.nil
          pkgs.nixfmt-rfc-style
        ];
        settings = {
          theme = "tokyonight_storm";
          editor = {
            line-number = "relative";
          };
        };
        languages = {
          language = [
            {
              name = "nix";
              formatter = {
                command = "nixfmt";
              };
              auto-format = true;
            }
          ];
        };
      };

      programs.tmux = {
        enable = true;
        prefix = "C-a";
      };

      programs.kitty = {
        enable = true;
        theme = "Tokyo Night Storm";
        font = {
          name = "Hack Nerd Font";
          package = pkgs.nerdfonts;
          size = 12;
        };
        extraConfig = ''
          enable_audio_bell no 

          # Tab management
          map ctrl+shift+enter new_tab
          map ctrl+shift+l next_tab
          map ctrl+shift+h previous_tab
          map ctrl+shift+q close_tab

          tab_bar_style powerline

          allow_remote_control yes
        '';
      };

      programs.zellij = {
        enable = true;
        settings = {
          theme = "tokyo-night";
        };
      };

      programs.bat = {
        enable = true;
        config = {
          theme = "Solarized (dark)";
        };
      };

      programs.eza = {
        enable = true;
      };

      programs.fzf = {
        enable = true;
        defaultOptions = [
          "--color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75"
          "--color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07"
          "--color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07"
        ];
      };

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      programs.git = {
        enable = true;
        userName = "Zack Lalanne";
        userEmail = "zack.lalanne@gmail.com";
        extraConfig = {
          color.ui = true;
          core.pager = "${pkgs.diff-so-fancy}/bin/diff-so-fancy | ${pkgs.less}/bin/less --tabs=4 -RFX";
          interactive.diffFilter = "${pkgs.diff-so-fancy}/bin/diff-so-fancy --patch";
        };
      };

      programs.htop = {
        enable = true;
        settings.show_program_path = true;
      };

      programs.zoxide = {
        enable = true;
      };

      programs.neovim = {
        enable = true;
        vimAlias = true;
        package = pkgs.unstable.neovim-unwrapped;
        plugins = with pkgs.unstable.vimPlugins; [
          # Common dependencies
          plenary-nvim

          # LSP
          nvim-lspconfig
          cmp-buffer
          cmp-path
          cmp-nvim-lsp
          luasnip
          cmp_luasnip
          friendly-snippets
          nvim-cmp
          null-ls-nvim
          fidget-nvim

          # Applications
          undotree
          vim-be-good

          # Editor
          trouble-nvim
          flash-nvim
          todo-comments-nvim
          which-key-nvim
          telescope-nvim
          harpoon2

          # Coding
          mini-nvim
          rainbow-delimiters-nvim

          # Treesitter
          nvim-treesitter.withAllGrammars
          playground

          # Git
          neogit

          # Sessions
          persistence-nvim

          # UI
          tokyonight-nvim
          lualine-nvim
          gitsigns-nvim
          nvim-web-devicons
          dressing-nvim
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
          pkgs.stylua
        ];
        extraConfig = ''
          lua <<EOF
            require("config.options")
            require("config.autocmd")
            require("config.which-key")
            require("config.keymaps")

            require("config.colorscheme")
            require("config.treesitter")
            require("config.ui")
            require("config.coding")
            require("config.git")
            require("config.editor")
            require("config.telescope")
            require("config.lsp")
            require("config.sessions")
          EOF'';
      };

      home.file = {
        ".config/nvim" = {
          recursive = true;
          source = ./dotfiles/nvim;
        };
        ".config/helix/themes" = {
          recursive = true;
          source = ./dotfiles/helix/themes;
        };
      };

      programs.zsh = {
        enable = true;
        enableCompletion = false;
        autosuggestion.enable = true;
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "rsync"
            "extract"
            "docker"
          ];
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

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.unstable-packages
    ];

    config = {
      # Allow unfree packages
      allowUnfree = true;
      permittedInsecurePackages = [ "electron-19.1.9" ];
    };
  };

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

  # Enable zsh at system level
  programs.zsh.enable = true;
  # Enable parition manager for KDE
  programs.partition-manager.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall.enable = true;
  # Ports 1714-1764 used for KDE Connect
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];

  # Enable avanhi for chromecast
  services.avahi.enable = true;

  # For tailscale. Discussion: https://github.com/tailscale/tailscale/issues/4432
  networking.firewall.checkReversePath = "loose";

  system.autoUpgrade = {
    enable = true;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "03:15";
    options = "-d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

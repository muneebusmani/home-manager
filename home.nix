{ config, pkgs, ... }:
{

  home.packages = with pkgs ; [
    # coding
    dotnet-sdk_8
    android-studio
    stylua
    dart
    docker
    docker-compose
    github-desktop
    go
    nodejs-18_x
    tmux
    #php83Packages.composer
    tmuxPlugins.catppuccin
    tmuxPlugins.yank
    tmuxPlugins.vim-tmux-navigator
    tmuxPlugins.resurrect
    tmuxPlugins.continuum
    neovim
    vim
    kitty
    vscode
    jetbrains.rider
    mono
    libreoffice


    # Build tools
    gh
    python3
    ruby
    rustc
    cargo
    luarocks
  ];
  programs = {
    home-manager.enable = true;
    kitty = {
      enable = true;
      shellIntegration.mode = "enabled";
      shellIntegration.enableZshIntegration = true;
      shellIntegration.enableBashIntegration = true;
      shellIntegration.enableFishIntegration = true;
      font.name = "ComicShannsMono Nerd Font";
      font.package = pkgs.nerdfonts;
      font.size = 16;
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        confirm_os_window_close = 0;
        window_padding_width = 5;
        background_opacity = "1";
        background_blur = 1;
      };
      theme = "Catppuccin-Mocha";
    };
    starship = {
      enable = false;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
    tmux = {
      enable = true;
      plugins = with pkgs; [
        tmuxPlugins.catppuccin
        tmuxPlugins.yank
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.resurrect
        tmuxPlugins.continuum
      ];
      keyMode = "vi";
      baseIndex = 1;
      shortcut = "space";
      mouse = true;
      newSession = true;
      escapeTime = 10;
      customPaneNavigationAndResize = true;
      terminal = "tmux-256color";
      extraConfig = ''
        set-option -sa terminal-features "xterm-kitty:RGB"
        set-option -g focus-events on
        set -g mouse on
        set-option -g history-limit 10000
        set -g renumber-windows on
        bind \` switch-client -t'{marked}'
        bind-key "|" split-window -h -c "#{pane_current_path}"
        bind-key "-" split-window -v -c "#{pane_current_path}"
        bind-key "\\" split-window -fh -c "#{pane_current_path}"
        bind-key "_" split-window -fv -c "#{pane_current_path}"
        bind -r "<" swap-window -d -t -1
        bind -r ">" swap-window -d -t +1
        bind -n M-n new-window -c "#{pane_current_path}"
        bind -n M-q killp
        bind Space last-window
        bind-key C-Space switch-client -l
        set -g @yank_selection primary # or 'secondary' or 'clipboard'
        set -g @continuum-restore 'on'
      '';
    };
    zsh = {
      package = pkgs.zsh;
      enable = true;
      autocd = true;
      initExtra = ''
        setopt nomatch
        setopt notify
        setopt extendedglob
        unsetopt beep
        ~/.config/home-manager/neofetch
      '';
      shellAliases = {
        update-sys = "sudo nixos-rebuild switch";
        update-home = "home-manager switch";
        op = "nvim ~/.config/home-manager/home.nix";
        dg = "dotnet aspnet-codegenerator";
        cls = "clear";
        q = "exit";
        tarnow = "tar - acf ";
        untar = "tar - zxvf ";
        wget = "wget - c ";
        dir = "dir - -color=auto";
        vdir = "vdir - -color=auto";
        hw = "hwinfo - -short"; # Hardware Info
        ip = "ip - color";
        please = "sudo";
        jctl = "journalctl -p 3 -xb";
        ngc = "ng g c";
        open = "xdg-open";
        ngs = "ng serve";
        ndir = "cd ~/.config/nvim/";
        cdir = "cd ~/coding/";
        edge = "microsoft-edge-stable";
        ts = "tmux";
        tad = "tmux attach";
        sc-restart = "sudo systemctl restart";
        sc-stop = "sudo systemctl stop";
        sc-start = "sudo systemctl start";
        sc-status = "sudo systemctl status";
        sc-hiber = "sudo systemctl hibernate";
        sc-sleep = "sudo systemctl hybrid-sleep";
        sc-poff = "sudo systemctl poweroff";
        sc-rbt = "sudo systemctl reboot";
        sc-srbt = "sudo systemctl soft-reboot";
        sc-spd = "sudo systemctl suspend";
        sc-shiber = "sudo systemctl suspend-then-hibernate";
        ".." = "cd ../";
        "..." = "cd .../";
        "...." = "cd ..../";
        "....." = "cd ...../";
        "......" = "cd ....../";
        ls = "exa -@lagbh --no-git --no-permissions --no-filesize --no-user  --changed";
      };
      enableAutosuggestions = true;
      sessionVariables = {
        #DOTNET_ROOT = "$(dirname $(which dotnet))";
        PATH = "$PATH:/home/muneeb/.dotnet/tools";
        ZSH_TMUX_AUTOSTART = true;
        ZSH_TMUX_AUTOQUIT = false;
        VI_MODE_RESET_PROMPT_ON_MODE_CHANGE = true;
        VI_MODE_SET_CURSOR = true;
        VISUAL = "nvim";
        EDITOR = "nvim";
        SUDO_EDITOR = "nvim";
      };
      syntaxHighlighting = {
        enable = true;
        package = pkgs.zsh-syntax-highlighting;
      };
      oh-my-zsh = {
        enable = true;
        package = pkgs.oh-my-zsh;
        theme = "gozilla";
        plugins = [
          "git"
          "node"
          "npm"
          "ng"
          "web-search"
          "aliases"
          "dotnet"
          "tmux"
          "vi-mode"
          "dotnet"
        ];
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
  home.username = "muneeb";
  home.stateVersion = "23.11";
  home.homeDirectory = "/home/muneeb";
  home.file.ideavimrc = {
    text = ''
      set clipboard+=unnamedplus
      nnoremap d "_d
      vnoremap d "_d
      nnoremap D "_D
      vnoremap D "_D
      nnoremap c "_c
      vnoremap c "_c
      nnoremap C "_C
      vnoremap C "_C
    '';
    enable = true;
    target = ".ideavimrc";
  };
  home.file.kbswitcher = {
    source = ./kbswitcher;
    target = ".kbswitcher";
    enable = true;
  };
  home.file.neofetch = {
    source = ./neofetch;
    target = ".neofetch";
    enable = true;
  };

  home.file.nvidia-offload = {
    source = ./nvidia-offload;
    target = ".nvidia-offload";
    enable = true;
  };
}

{ config, pkgs, ... }:

{
  home = {
    username = "anjrv";
    homeDirectory = "/home/anjrv";
    packages =
      with pkgs;
      let
        RStudio-with-packages = rstudioWrapper.override
          {
            packages = with rPackages; [
              tidyverse
              dplyr
              zoo
              ggplot2
              ggthemes
              ggpubr
              ggh4x
              reshape2
              scales
              stringi
              lubridate
              rmdformats
              markdown
              commonmark
            ];
          };
      in
      [
        RStudio-with-packages
        pandoc
        texliveFull
        jq
        tldr
        ncdu
        moar
        xclip
        wl-clipboard
        shellcheck
        yaml-language-server
        tree
        bat
        btop
        lsd
        ripgrep
        lazygit
        unzip
        unrar
        p7zip
        yazi
        zellij
        ffmpeg
        direnv
        nix-direnv
        neofetch
        libclang
        cmake
        cmake-language-server
        ninja
        lua
        lua-language-server
        luarocks
        stylua
        go
        php
        nodejs
        typescript
        nodePackages.prettier
        nodePackages.ts-node
        nodePackages.typescript-language-server
        rustup
        scala
        sbt
        bloop
        coursier
        nil
        nixpkgs-fmt
        gamemode
        mpv
        mupdf
        neovide
        firefox
        stremio
        google-chrome
        onlyoffice-bin
        (wrapOBS {
          plugins = with obs-studio-plugins; [
            obs-vkcapture
          ];
        })
        heroic
        lutris
        v4l-utils
        virt-manager
      ];
    stateVersion = "23.11";
  };
  programs = {
    zsh = {
      enable = true;
      autocd = false;
      dotDir = ".config/zsh";
      history = {
        size = 20000;
        save = 10000;
        ignoreAllDups = true;
      };
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch = {
        enable = true;
        searchUpKey = [
          "^[[A"
          "^[OA"
        ];
        searchDownKey = [
          "^[[B"
          "^[OB"
        ];
      };
      initExtra = ''
        setopt inc_append_history
        setopt extendedglob nomatch menucomplete
        setopt interactive_comments
          
        unsetopt beep
          
        autoload -Uz compinit
        zstyle ":completion:*" menu select
        zmodload zsh/complist
        _comp_options+=(globdots)
          
        autoload -Uz colors && colors

        function ex() {
            if [ -f $1 ] ; then
                case $1 in
                    *.tar.bz2)   tar xjf $1   ;;
                    *.tar.gz)    tar xzf $1   ;;
                    *.bz2)       bunzip2 $1   ;;
                    *.rar)       unrar x $1   ;;
                    *.gz)        gunzip $1    ;;
                    *.tar)       tar xf $1    ;;
                    *.tbz2)      tar xjf $1   ;;
                    *.tgz)       tar xzf $1   ;;
                    *.zip)       unzip $1     ;;
                    *.Z)         uncompress $1;;
                    *.7z)        7z x $1      ;;
                    *.deb)       ar x $1      ;;
                    *.tar.xz)    tar xf $1    ;;
                    *.tar.zst)   unzstd $1    ;;
                    *)           echo "'$1' cannot be extracted via ex()" ;;
                esac
            else
                echo "'$1' is not a valid file"
            fi
        }

        eval "$(direnv hook zsh)"
      '';
      shellAliases = {
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
        df = "df -h";
        free = "free -m";
        sd = "shutdown -h now";
        ".." = "cd ..";
        "..." = "cd ../..";
        ls = "lsd -lh --group-dirs first";
        la = "lsd -lhA --group-dirs first";
        cat = "bat --theme=Dracula";
        top = "btop";
        grep = "rg --color=auto";
        t2 = "tree -L 2";
        t3 = "tree -L 3";
        v = "nvim";
        firmware = "sudo systemctl reboot --firmware-setup";
        g = "lazygit";
        gd = "git diff --color | diff-so-fancy";
        gps = "git push";
        gpl = "git pull";
        gcm = "git commit -m";
        jctl = "journalctl -p 3 -xb";
        psmem = "ps auxf | sort -nr -k 4 | head -5";
        pscpu = "ps auxf | sort -nr -k 3 | head -5";
        ssh = "kitty +kitten ssh";
      };
    };
    starship.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    kitty = {
      enable = true;
      theme = "Dracula";
      font = {
        name = "JetBrains Mono";
        size = 14;
      };
      shellIntegration = {
        enableZshIntegration = true;
        enableBashIntegration = true;
      };
      settings = {
        enable_audio_bell = false;
        confirm_os_window_close = 0;
      };
    };
    java.enable = true;
    home-manager.enable = true;
  };
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}

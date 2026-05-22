## Overview Dotfiles

Personal dotfiles and provisioning scripts for Linux (Debian/Ubuntu) and Windows development environments, plus Docker infrastructure containers.

## Structure

```
dotfiles/
├── install.sh                    # Main entry — sources core.sh & menu.sh, launches FZF menu
├── scripts/
│   ├── core.sh                   # Shared lib: colors, spinners, OS detection, print helpers
│   ├── menu.sh                   # FZF-based interactive action menu
│   └── linux_init.sh             # Placeholder for future modular init
├── linux/
│   ├── install.sh                # Full Linux provisioning (apt, languages, Docker, Ollama)
│   ├── .bashrc                   # Bash config: Conda, pyenv, OpenCode, Bun, .NET, Go, Nim
│   ├── i3/
│   │   ├── config                # i3 WM: $mod=Alt, Iosevka font, pactl volume, polybar/picom
│   │   ├── startup.sh            # i3 startup: rofi, polybar, picom, nitrogen, flameshot
│   │   └── utils.sh              # pavucontrol binding
│   ├── polybar/
│   │   ├── config.ini            # Status bar: workspaces, wifi, volume, date/time
│   │   ├── volume.sh             # pamixer volume control (up/down/toggle)
│   │   └── wifi.sh               # nmcli WiFi manager + rofi network picker
│   ├── kitty/
│   │   ├── kitty.conf            # Terminal: Iosevka 15pt, opacity 0.5, includes theme
│   │   └── mycolor.conf          # Adwaita dark color scheme
│   ├── picom/
│   │   └── picom.conf            # Compositor: GLX backend, fade, dual_kawase blur
│   ├── rofi/
│   │   └── config.rasi           # Dark launcher theme with blue accents
│   ├── nitrogen/
│   │   ├── nitrogen.cfg          # Wallpaper dir: ~/Pictures
│   │   └── bg-saved.cfg          # Current: osage.png (zoom mode)
│   ├── fish/
│   │   ├── config.fish           # Suppress fish greeting
│   │   └── fish_variables        # Universal color variables
│   ├── dconf/
│   │   └── user                  # GNOME/dconf settings (binary GVariant DB)
│   ├── autostart/
│   │   ├── jetbrains-toolbox.desktop
│   │   └── mimeinfo.cache
│   └── gtk-2.0/
│       └── gtkfilechooser.ini    # GTK2 file chooser settings
├── win/
│   └── scoop.ps1                 # Windows: Scoop buckets + packages + EXE downloads
├── docker/
│   ├── .env                      # Secrets: Neo4j & Redis passwords
│   ├── docker-compose.yml        # Services: Label Studio, Neo4j, Redis Stack
│   └── script.sh                 # docker compose up -d
└── specs/
    └── specs.md                  # This file
```

## Linux Provisioning (`linux/install.sh`)

Firmware, WM (i3 + xorg + lightdm), audio (pulseaudio), browsers (LibreWolf, Edge), editors (VS Code, Windsurf), terminal (kitty, fish), bar/compositor (polybar, picom), launcher (rofi), wallpaper (nitrogen), languages (.NET 9, Java 21, Nim, Go, Bun), Ollama, Docker engine, Mesa dev libs, containers (Portainer, Redis Stack, Neo4j).

## Windows Provisioning (`win/scoop.ps1`)

Scoop buckets: extras, versions, java, nerd-fonts. Packages: git, bun, nodejs-lts, python312, dotnet9-sdk, tesseract, winrar, sqlite, zig, uv, composer, yq, vcredist2022, miniconda3. Downloads: ServBay, Roblox, Windsurf.

## Docker Infrastructure (`docker/docker-compose.yml`)

| Service       | Image                          | Ports                 |
|---------------|--------------------------------|-----------------------|
| Label Studio  | heartexlabs/label-studio       | 8508:8080             |
| Neo4j         | neo4j:community                | 7474:7474, 7687:7687  |
| Redis Stack   | redis/redis-stack              | 6379:6379, 8001:8001  |

## Key Configs

- **Shell**: Bash (.bashrc), Fish (config.fish) — both configured with dev tool paths
- **WM**: i3 with Alt mod, Iosevka font, no gaps, polybar status bar, picom compositor
- **Terminal**: Kitty with Adwaita dark theme, 50% opacity
- **Launcher**: Rofi with custom dark/blue theme
- **Polybar**: Translucent black bar, workspaces, wifi (nmcli), volume (pamixer), date

## Scripts System

- `install.sh` → sources `core.sh` + `menu.sh` → launches FZF menu
- `core.sh`: spinner animation, colored output, OS detection, Conda check
- `menu.sh`: FZF picker reading `menu_options` array (currently TBD population)

# #Module
debian_install_firmware() {
  sudo apt update && sudo apt install firmware-linux-nonfree alsa-utils -y
}

debian_install_wm() {
  sudo apt update && sudo apt install i3 xorg lightdm thunar -y
}

debian_install_audio() {
  sudo apt update && sudo apt install pavucontrol pulseaudio -y
}

debian_install_browser() {
  sudo apt update && sudo apt install extrepo -y
  sudo extrepo enable librewolf
  sudo apt update && sudo apt install librewolf -y

  curl -O mes.deb "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_138.0.3351.55-1_amd64.deb"
  sudo dpkg -i microsoft-edge-stable_138.0.3351.55-1_amd64.deb
}

debian_install_code() {
  curl -L -o code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  sudo dpkg -i code.deb
}

debian_install_windsurf() {
  sudo apt-get install wget gpg
  wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg
  sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
  rm -f windsurf-stable.gpg
  sudo apt install apt-transport-https
  sudo apt update
  sudo apt install windsurf -y
}

debian_install_network() {
  sudo apt install network-manager -y
}

debian_install_terminal() {
  sudo apt install kitty fish -y
}

debian_install_bar() {
  sudo apt install polybar picom -y
}

debian_install_search() {
  sudo apt install rofi -y
}

debian_install_image() {
  sudo apt install nitrogen -y
}

debian_install_ollama() {
  curl -fsSL https://ollama.com/install.sh | sh
}

debian_install_docker() {
  sudo apt update
  sudo apt install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
  sudo apt update
  sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

debian_install_deps() {
  sudo apt update
  sudo apt install libgl1-mesa-dev libglu1-mesa-dev libx11-dev libxcursor-dev libxinerama-dev libxrandr-dev libxi-dev
}

#Lang
debian_install_dotnet() {
    curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
    chmod +x dotnet-install.sh

    ./dotnet-install.sh --channel 9.0 --install-dir "$HOME/.dotnet"

    sudo ln -sf "$HOME/.dotnet/dotnet" /usr/local/bin/dotnet

    dotnet --version
}

debian_remove_dotnet() {
    sudo rm -f /usr/local/bin/dotnet
    rm -rf ~/.dotnet
    rm -f dotnet-install.sh
}

debian_install_java() {
  sudo apt install -y wget apt-transport-https gpg
  wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
  echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
  sudo apt install -y temurin-21-jdk
}

debian_install_nim() {
  curl https://nim-lang.org/choosenim/init.sh -sSf | sh
}

debian_install_go() {
  mkdir -p ~/.go
  wget https://go.dev/dl/$(curl -s https://go.dev/VERSION?m=text | head -1).linux-amd64.tar.gz -O ~/.go/go.tar.gz
  rm -rf ~/.go/go
  tar -C ~/.go -xzf ~/.go/go.tar.gz
  echo 'export PATH=$PATH:$HOME/.go/go/bin' >> ~/.bashrc
  source ~/.bashrc
}

debian_install_bun() {
  curl -fsSL https://bun.sh/install | bash
}

debian_install_php() {
    curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb
    sudo dpkg -i /tmp/debsuryorg-archive-keyring.deb

    echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list >/dev/null

    sudo apt update
    sudo apt install -y php8.3-cli

    php -v
}

debian_remove_php() {
    sudo apt purge 'php*' -y
    sudo apt autoremove --purge -y
    sudo rm -rf /etc/php
    sudo rm -f /etc/apt/sources.list.d/php.list
    sudo apt update
}

debian_pipeline() {
  debian_install_firmware
  debian_install_wm
  debian_install_audio
  debian_install_browser
  debian_install_code
  debian_install_windsurf
  debian_install_network
  debian_install_terminal
  debian_install_bar
  debian_install_search
  debian_install_image
  debian_install_dotnet
  debian_install_java
  debian_install_nim
  debian_install_go
  debian_install_bun
  debian_install_ollama
  debian_install_docker
  debian_install_deps
}

# #Module
debian_install_firmware() {
  logger_info "Installing firmware and audio utilities..."
  sudo apt update && sudo apt install firmware-linux-nonfree alsa-utils -y
  logger_success "\nFirmware and audio utilities installed"
}

debian_install_wm() {
  logger_info "\nInstalling window manager (i3, lightdm, thunar)..."
  sudo apt update && sudo apt install i3 xorg lightdm thunar -y
  logger_success "\nWindow manager installed"
}

debian_install_audio() {
  logger_info "Installing audio utilities..."
  sudo apt update && sudo apt install pavucontrol pulseaudio -y
  logger_success "Audio utilities installed"
}

debian_install_browser() {
  logger_info "\nInstalling browsers"
  # sudo apt update && sudo apt install extrepo -y
  # sudo extrepo enable librewolf
  # sudo apt update && sudo apt install librewolf -y

  curl -O mes.deb "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_138.0.3351.55-1_amd64.deb"
  sudo dpkg -i microsoft-edge-stable_138.0.3351.55-1_amd64.deb
  logger_success "\nBrowsers installed"
}

debian_install_code() {
  logger_info "Installing VS Code..."
  curl -L -o code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  sudo dpkg -i code.deb
  logger_success "VS Code installed"
}

debian_install_windsurf() {
  logger_info "Installing Windsurf..."
  sudo apt-get install wget gpg
  wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg
  sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
  rm -f windsurf-stable.gpg
  sudo apt install apt-transport-https
  sudo apt update
  sudo apt install windsurf -y
  logger_success "Windsurf installed"
}

debian_install_network() {
  logger_info "Installing network manager..."
  sudo apt install network-manager -y
  logger_success "Network manager installed"
}

debian_install_terminal() {
  logger_info "Installing terminal ..."
  sudo apt install kitty fish -y
  logger_success "Terminal installed"
}

debian_install_bar() {
  logger_info "Installing bar/compositor (polybar, picom)..."
  sudo apt install polybar picom -y
  logger_success "Bar/compositor installed"
}

debian_install_search() {
  logger_info "Installing search (rofi)..."
  sudo apt install rofi -y
  logger_success "Search installed"
}

debian_install_image() {
  logger_info "Installing image utility (nitrogen)..."
  sudo apt install nitrogen -y
  logger_success "Image utility installed"
}

debian_install_ollama() {
  logger_info "Installing Ollama..."
  curl -fsSL https://ollama.com/install.sh | sh
  logger_success "Ollama installed"
}

debian_install_docker() {
  logger_info "Installing Docker..."
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
  logger_success "Docker installed"
}

debian_install_deps() {
  logger_info "Installing build dependencies..."
  sudo apt update
  sudo apt install libgl1-mesa-dev libglu1-mesa-dev libx11-dev libxcursor-dev libxinerama-dev libxrandr-dev libxi-dev
  logger_success "Build dependencies installed"
}

#Lang
debian_install_dotnet() {
    logger_info "Installing .NET 9.0..."
    source /etc/os-release

    wget https://packages.microsoft.com/config/$ID/$VERSION_ID/packages-microsoft-prod.deb \
        -O packages-microsoft-prod.deb

    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    sudo apt update
    sudo apt install -y dotnet-sdk-9.0
    logger_success ".NET installed"
}

debian_remove_dotnet() {
  logger_info "Removing .NET..."

  sudo apt remove -y \
      dotnet-sdk-9.0 \
      dotnet-runtime-9.0 \
      aspnetcore-runtime-9.0

  sudo apt autoremove -y

  # Remove Microsoft repository (optional)
  sudo rm -f /etc/apt/sources.list.d/microsoft-prod.list
  sudo rm -f /usr/share/keyrings/microsoft-prod.gpg

  logger_success ".NET removed"
}

debian_install_java() {
  logger_info "Installing Java (Temurin 21)..."
  sudo apt install -y wget apt-transport-https gpg
  wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
  echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
  sudo apt install -y temurin-21-jdk
  logger_success "Java installed"
}

debian_install_nim() {
  logger_info "Installing Nim..."
  curl https://nim-lang.org/choosenim/init.sh -sSf | sh
  logger_success "Nim installed"
}

debian_install_go() {
  logger_info "Installing Go ..."
  
  GO_VERSION=$(curl -fsSL https://go.dev/VERSION?m=text | head -n1)
  curl -fsSL \
    "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz" \
    -o /tmp/go.tar.gz

  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf /tmp/go.tar.gz
  
  if ! grep -q '/usr/local/go/bin' ~/.bashrc; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
  fi

  export PATH=$PATH:/usr/local/go/bin

  go version

  logger_success "Go installed"
}

debian_remove_go() {
  logger_info "Removing go..."
  
  sudo rm -rf /usr/local/go
  rm -f /tmp/go.tar.gz
  
  logger_sucess "Go remove"
}

debian_install_bun() {
  logger_info "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  logger_success "Bun installed"
}

debian_install_php() {
    logger_info "Installing PHP 8.3..."
    curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb
    sudo dpkg -i /tmp/debsuryorg-archive-keyring.deb

    echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list >/dev/null

    sudo apt update
    sudo apt install -y php8.3-cli

    php -v
    logger_success "PHP installed"
}

debian_remove_php() {
    logger_info "Removing PHP..."
    sudo apt purge 'php*' -y
    sudo apt autoremove --purge -y
    sudo rm -rf /etc/php
    sudo rm -f /etc/apt/sources.list.d/php.list
    sudo apt update
    logger_success "PHP removed"
}

debian_pipeline() {
  logger_info "Starting Debian provisioning pipeline..."
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
  logger_success "Debian provisioning complete!"
}

# dpkg -l | grep <name>


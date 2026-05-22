# Set execution policy to RemoteSigned for the current user scope
<<<<<<< HEAD
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install Scoop
Invoke-RestMethod -Uri "https://get.scoop.sh" | Invoke-Expression

# Repo
scoop bucket add extras 
=======
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install Scoop
# Invoke-RestMethod -Uri "https://get.scoop.sh" | Invoke-Expression

# Repo
# scoop bucket add extras

# Add buckets
scoop bucket add extras
scoop bucket add versions
scoop bucket add java
scoop bucket add nerd-fonts

# Update scoop 
scoop update 

# Update packages
scoop install git
scoop install main/bun
scoop install main/nodejs-lts
scoop install main/tesseract
scoop install extras/winrar
scoop install main/sqlite
scoop install main/zig
scoop install extras/vcredist2022
scoop install main/uv
scoop install versions/python312
scoop install main/composer
scoop install versions/dotnet9-sdk
scoop install main/yq
scoop install main/
scoop install extras/miniconda3

curl.exe -L -O --output-dir "$HOME\Downloads" https://dl.servbay.com/windows-release/ServBay_Setup_full_1.15.1.exe
curl.exe -L -O --output-dir "$HOME\Downloads" "https://setup.rbxcdn.com/version-acc4b74f79e743b9-RobloxPlayerInstaller.exe"
curl.exe -L -O --output-dir "$HOME\Downloads" "https://windsurf-stable.codeiumdata.com/win32-x64-user/stable/63e54ba26dd2a1b975c172966dff80bad8ae74c7/WindsurfUserSetup-x64-2.1.32.exe"
>>>>>>> 821f753 (update)

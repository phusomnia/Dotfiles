# Set execution policy to RemoteSigned for the current user scope
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install Scoop
Invoke-RestMethod -Uri "https://get.scoop.sh" | Invoke-Expression

# Repo
scoop bucket add extras 

menu_options=(
    "── Dotfiles ──"
    "install_bashrc"
)

menu() {
    local choice cmd

    choice=$(
        printf '%s\n' "${menu_options[@]}" | \
        fzf --height 40% \
            --layout=reverse \
            --border \
            --prompt="⚡ Action: " \
            --info=inline \
            --no-sort \
            --header="Choose action, ── is header" \
            --color="border:#5f5fff,header:#af87ff,prompt:#5fff87,pointer:#ff5f87"
    )

    [[ -z "$choice" ]] && return
    [[ "$choice" == ──* ]] && return

    cmd="$(echo "$choice" | xargs)"
    "$cmd"
}

# Scripts

## Folder structure

```
scripts/
├── core.sh              # Colors, logger, spinner, platform, terminal utils
├── Scripts.md           # This file
├── tui/
│   ├── ui.sh            # fzf menu UI
│   ├── tui_manager.sh   # Single-run TUI (no loop)
│   └── router.sh        # Route commands to plugins
└── plugins/
    ├── system.sh        # system_info
    ├── git.sh           # git_status, git_add, git_commit, git_push, git_rename_main
    ├── nodejs.sh        # nodejs_info
    ├── bun.sh           # bun_info
    ├── python.sh        # python_info
    ├── go.sh            # go_info, run_server
    ├── dotnet.sh        # dotnet_info
    ├── nim.sh           # nim_info
    └── docker.sh        # docker_info
```

## Usage

```bash
./script.sh
```

Opens a fzf menu. Select a command to run. Exits after execution.

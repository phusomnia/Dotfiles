go_info() {
  echo "Go: $(go version 2>/dev/null || echo 'not installed')"
}

go_init_module() {
  local dir="${1:-.}"
  local module_name="${2:-}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  (
    cd "$dir" || exit 1

    local default_module
    default_module="$(basename "$(pwd)")"

    if [ -z "$module_name" ]; then
      read -p "Enter module name [$default_module]: " module_name
      module_name="${module_name:-$default_module}"
    fi

    if [ -z "$module_name" ]; then
      logger_error "Module name cannot be empty"
      return 1
    fi

    if [ "$module_name" = "go" ]; then
      logger_error "Module path 'go' is reserved by Go toolchain"
      return 1
    fi

    go mod init "$module_name"
  )
}

go_install_deps() {
  local dir="${1:-.}"
  local deps_file="${2:-dependencies}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  (
    cd "$dir" || exit 1

    logger_info "Installing Go dependencies..."

    go mod tidy
    if [ $? -eq 0 ]; then
      logger_success "Dependencies installed"
    else
      logger_error "Failed to install dependencies"
    fi

    if [ -f "$deps_file" ]; then
      logger_info "Installing Go tools from $deps_file..."

      while IFS= read -r pkg || [ -n "$pkg" ]; do
        pkg="$(echo "$pkg" | xargs)"

        [ -z "$pkg" ] && continue
        [[ "${pkg#\#}" != "$pkg" ]] && continue

        logger_info "  Installing $pkg..."

        if [[ "$pkg" == */cmd/* ]]; then
          go install "$pkg"
        else
          go get "$pkg"
        fi

        if [ $? -eq 0 ]; then
          logger_success "  $pkg installed"
        else
          logger_error "  Failed to install $pkg"
        fi
      done < "$deps_file"
    fi
  )
}

clear_deps() {
  local dir="${1:-.}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  (
    cd "$dir" || exit 1

    go clean -modcache
    logger_success "Module cache cleared"
  )
}

create_api_spec() {
  apispec -d . -o specs/openapi.yaml
}

go_build() {
  local dir="${1:-.}"
  local output="${2:-bin/voxel-engine}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  (
    cd "$dir" || exit 1

    if platform_is_windows; then
      output="${output}.exe"
    fi

    mkdir -p "$(dirname "$output")"

    logger_info "Building Go binary to $output..."

    go build -o "$output" ./src
    local rc=$?

    if [ $rc -eq 0 ]; then
      logger_success "Binary built: $dir/$output"
    else
      logger_error "Build failed (exit $rc)"
      return 1
    fi
  )
}

go_run_src() {
  local dir="${1:-.}"
  local src_path="${2:-./src}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  (
    cd "$dir" || exit 1

    logger_info "Running $src_path directly (dev mode)..."
    go run "$src_path"
  )
}

go_run_binary() {
  local dir="${1:-.}"
  local binary="${2:-bin/voxel-engine}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  (
    cd "$dir" || exit 1

    if platform_is_windows; then
      binary="${binary}.exe"
    fi

    if [ ! -f "$binary" ]; then
      logger_error "Binary not found: $dir/$binary"
      logger_info "Run 'voxel_engine_build' first"
      return 1
    fi

    logger_info "Running $binary..."
    "./$binary"
  )
}

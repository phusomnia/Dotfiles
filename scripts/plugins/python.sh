is_conda_base() {
  [[ "$CONDA_DEFAULT_ENV" = "base" ]]
}

python_info() {
  echo "Python: $(python --version 2>/dev/null || python3 --version 2>/dev/null || echo 'not installed')"
  echo "Pip:    $(pip --version 2>/dev/null || pip3 --version 2>/dev/null || echo 'not installed')"
  echo "uv:     $(uv --version 2>/dev/null || echo 'not installed')"
  echo "Conda:  $(conda --version 2>/dev/null || echo 'not installed')"
}

python_init_venv() {
  local dir="${1:-python}"
  local venv_path="${2:-.venv}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  if ! command -v uv >/dev/null 2>&1; then
    logger_error "uv is not installed"
    return 1
  fi

  (
    cd "$dir" || exit 1

    if [ -d "$venv_path" ]; then
      logger_info "venv already exists: $dir/$venv_path"
      return 0
    fi

    spinner_start "Creating venv via uv..."
    uv venv "$venv_path"
    local rc=$?
    spinner_stop

    if [ $rc -eq 0 ]; then
      logger_success "venv created: $dir/$venv_path"
    else
      logger_error "uv venv failed (exit $rc)"
      return 1
    fi
  )
}

python_install_deps() {
  local dir="${1:-python}"
  local venv_path="${2:-.venv}"
  local requirements="${3:-src/requirements.txt}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  if [ ! -f "$dir/$requirements" ]; then
    logger_error "Missing requirements file: $dir/$requirements"
    return 1
  fi

  if ! command -v uv >/dev/null 2>&1; then
    logger_error "uv is not installed"
    return 1
  fi

  (
    cd "$dir" || exit 1

    if [ ! -d "$venv_path" ]; then
      logger_info "venv missing, creating: $venv_path"
      uv venv "$venv_path" || { logger_error "Failed to create venv"; return 1; }
    fi

    spinner_start "Installing deps from $requirements..."
    uv pip install -r "$requirements" --python "$venv_path"
    local rc=$?
    spinner_stop

    if [ $rc -eq 0 ]; then
      logger_success "Dependencies installed into $dir/$venv_path"
    else
      logger_error "uv pip install failed (exit $rc)"
      return 1
    fi
  )
}

python_run_server() {
  local dir="${1:-python}"
  local venv_path="${2:-.venv}"
  local app="${3:-lain:app}"
  local host="${4:-127.0.0.1}"
  local port="${5:-8000}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  if [ ! -d "$dir/$venv_path" ]; then
    logger_error "venv not found: $dir/$venv_path. Run python_init_venv first"
    return 1
  fi

  (
    cd "$dir/src" || exit 1

    logger_info "Launching granian $app on $host:$port"
    uv run --python "../$venv_path" --with granian granian --interface asgi "$app" --host "$host" --port "$port"
  )
}

python_clear_venv() {
  local dir="${1:-python}"
  local venv_path="${2:-.venv}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  (
    cd "$dir" || exit 1

    if [ ! -d "$venv_path" ]; then
      logger_info "No venv to clear: $dir/$venv_path"
      return 0
    fi

    rm -rf "$venv_path"
    logger_success "Removed venv: $dir/$venv_path"
  )
}

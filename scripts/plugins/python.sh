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
  local env_path="${1:-.venv}"

  if ! command -v conda >/dev/null 2>&1; then
    logger_error "conda is not installed"
    return 1
  fi

  if [ -d "$env_path" ]; then
    logger_info "conda env already exists: $env_path"
    return 0
  fi

  spinner_start "Creating conda env: $env_path..."
  conda create -y -p "$env_path" python
  local rc=$?
  spinner_stop

  if [ $rc -eq 0 ]; then
    logger_success "conda env created: $env_path"
  else
    logger_error "conda create failed (exit $rc)"
    return 1
  fi
}

python_install_requirements() {
  local env_path="${1:-.venv}"
  local requirements="${2:-requirements.txt}"

  if [ ! -f "$requirements" ]; then
    logger_error "Missing requirements file: $requirements"
    return 1
  fi

  if ! command -v conda >/dev/null 2>&1; then
    logger_error "conda is not installed"
    return 1
  fi

  if [ ! -d "$env_path" ]; then
    logger_info "conda env missing, creating: $env_path"
    conda create -y -p "$env_path" python || {
      logger_error "Failed to create conda env"
      return 1
    }
  fi

  spinner_start "Installing deps from $requirements..."
  "$env_path/bin/pip" install -r "$requirements"
  local rc=$?
  spinner_stop

  if [ $rc -eq 0 ]; then
    logger_success "Dependencies installed into $env_path"
  else
    logger_error "pip install failed (exit $rc)"
    return 1
  fi
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

python_demo_pipeline() {
  local dir="${1:-demo/python}"

  if [ ! -d "$dir" ]; then
    logger_error "Directory does not exist: $dir"
    return 1
  fi

  dir="$(realpath "$dir")"
  local env_path="${2:-$dir/.venv}"
  local req="${3:-$dir/requirements.txt}"
  local demo_file="${4:-$dir/src/lain.py}"

  logger_info "Pipeline: $dir — 4 stages"

  # Stage 1: init
  logger_info "Stage 1/4: init — $env_path"
  python_init_venv "$env_path" || return 1

  # Stage 2: install
  logger_info "Stage 2/4: install — $req"
  python_install_requirements "$env_path" "$req" || return 1

  # Stage 3: build
  logger_info "Stage 3/4: build — compile check"
  (
    cd "$dir" || exit 1
    "$env_path/bin/python" -m compileall . -q
  )
  local rc=$?
  if [ $rc -ne 0 ]; then
    logger_error "Build (compile) failed (exit $rc)"
    return 1
  fi
  logger_success "Build passed"

  # Stage 4: run
  logger_info "Stage 4/4: run — $demo_file"
  if [ ! -f "$demo_file" ]; then
    logger_error "Demo file not found: $demo_file"
    return 1
  fi
  "$env_path/bin/python" "$demo_file"
  local rc=$?
  if [ $rc -eq 0 ]; then
    logger_success "Demo passed"
  else
    logger_error "Demo failed (exit $rc)"
    return 1
  fi

  logger_success "Pipeline complete: $dir"
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

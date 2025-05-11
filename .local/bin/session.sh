#!/usr/bin/env bash

CONFIG_FILE="${HOME}/.config/tmux_projects.yaml"

[ -n "$BASH_VERSION" ] || exec bash "$0" "$@"

start_session() {
  local name="$1"
  local restart="$2"

  # Load project_root from config
  local project_root=$(yq e '.project_root' "$CONFIG_FILE")
  project_root="${project_root/#\~/$HOME}"

  # Fuzzy-finder if no project name is given
  if [[ -z "$name" ]]; then
    if [[ ! -d "$project_root" ]]; then
      echo "❌ project_root '$project_root' does not exist"
      return 1
    fi

    echo "📂 Select a project from $project_root:"
    name=$(find "$project_root" -mindepth 1 -maxdepth 1 -type d ! -name ".*" -exec basename {} \; | fzf)
    if [[ -z "$name" ]]; then
      echo "⚠️ No project selected"
      return 1
    fi
  fi

  # Flags
  if [[ "$name" == "--help" || "$name" == "-h" ]]; then
    cat <<EOF
Usage: repo [--restart|-r] <project-name>

Starts or attaches to a tmux session for the given project.

Options:
  --restart, -r           Kill and recreate the tmux session
  --help, -h              Show this help message
  --list                  List available project names
  install-autocomplete    Set up shell autocomplete for repo

Config:
  Project configs live at: $CONFIG_FILE
  The default block and project_root are used when no config is defined.

Example:
  project_root: ~/src

  default:
    dir: "{{project_root}}/{{project}}"
    windows:
      - name: editor
        command: "nvim {{project}}.md"
EOF
    exit 0
  fi

  if [[ "$name" == "--list" ]]; then
    echo "📦 Available projects:"
    yq e 'keys | .[]' "$CONFIG_FILE" | grep -v '^default$' | grep -v '^project_root$'
    exit 0
  fi

  if [[ "$name" == "install-autocomplete" ]]; then
    local autocomplete_file="$HOME/.local/bin/repo-completion.sh"
    cat <<'EOF' >"$autocomplete_file"
_repo_autocomplete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local config_file="${HOME}/.config/tmux_projects.yaml"
  local projects=$(yq e 'keys | .[]' "$config_file" 2>/dev/null | grep -v '^default$' | grep -v '^project_root$')
  COMPREPLY=($(compgen -W "$projects" -- "$cur"))
}
complete -F _repo_autocomplete repo
EOF
    echo "✅ Autocomplete installed. Restart your shell or run:"
    echo "   source ~/.local/bin/repo-completion.sh"
    exit 0
  fi

  local dir_raw=""
  local dir=""
  local windows=()

  if yq e "has(\"$name\")" "$CONFIG_FILE" | grep -q true; then
    echo "✅ Using config for '$name'"

    dir_raw=$(yq e ".\"$name\".dir" "$CONFIG_FILE")
    [[ "$dir_raw" == "null" || -z "$dir_raw" ]] && echo "❌ 'dir' is missing for '$name'" && return 1

    windows_json=$(yq e -o=json ".\"$name\".windows" "$CONFIG_FILE")
    [[ "$windows_json" == "null" || -z "$windows_json" ]] && echo "❌ 'windows' block is missing for '$name'" && return 1

    while IFS= read -r line; do
      windows+=("$line")
    done < <(echo "$windows_json" | jq -c '.[]')

  elif yq e 'has("default")' "$CONFIG_FILE" | grep -q true; then
    echo "⚠️ Using default config for '$name'"

    dir_raw=$(yq e '.default.dir' "$CONFIG_FILE")
    [[ "$dir_raw" == "null" || -z "$dir_raw" ]] && echo "❌ 'dir' is missing in default config" && return 1

    # Replace {{project}} and {{project_root}}
    dir_raw="${dir_raw//\{\{project\}\}/$name}"
    dir_raw="${dir_raw//\{\{project_root\}\}/$project_root}"

    windows_json=$(yq e -o=json '.default.windows' "$CONFIG_FILE")
    [[ "$windows_json" == "null" || -z "$windows_json" ]] && echo "❌ 'windows' block is missing in default config" && return 1

    while IFS= read -r line; do
      line=$(echo "$line" | sed "s/{{project}}/$name/g; s|{{project_root}}|$project_root|g")
      windows+=("$line")
    done < <(echo "$windows_json" | jq -c '.[]')

  else
    echo "❌ No config block found for '$name' and no default fallback"
    return 1
  fi

  dir="${dir_raw/#\~/$HOME}"
  [[ ! -d "$dir" ]] && echo "❌ Directory '$dir' does not exist." && return 1

  if $restart && tmux has-session -t "$name" 2>/dev/null; then
    tmux kill-session -t "$name"
    echo "🔁 Restarted session: $name"
  fi

  if ! tmux has-session -t "$name" 2>/dev/null; then
    tmux new-session -ds "$name" -c "$dir"

    for i in "${!windows[@]}"; do
      window_json="${windows[$i]}"
      win_name=$(jq -r '.name // empty' <<<"$window_json")
      cmd=$(jq -r '.command // ""' <<<"$window_json")

      if [[ $i -eq 0 ]]; then
        tmux send-keys -t "$name:0" "$cmd" C-m
        [[ -n "$win_name" ]] && tmux rename-window -t "$name:0" "$win_name"
      else
        tmux new-window -t "$name" -c "$dir" ${win_name:+-n "$win_name"}
        tmux send-keys -t "$name:$i" "$cmd" C-m
      fi
    done

    tmux select-window -t "$name:0"
  fi

  [[ -z $TMUX ]] && tmux attach-session -t "$name" || tmux switch-client -t "$name"
}

#!/usr/bin/env bash

# Archivo temporal para registrar el estado
STATE_FILE="/tmp/workspace_toggle_state"

# Define tus monitores (ajusta los nombres según tu hyprctl monitors)
monitor_primary="DP-1"
monitor_secondary="HDMI-A-1"

# Obtiene el workspace actual
current_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

# Si no existe el archivo de estado, asume que está en el primario
if [ ! -f "$STATE_FILE" ]; then
  echo "$monitor_primary" > "$STATE_FILE"
fi

# Lee el monitor anterior del archivo
last_monitor=$(cat "$STATE_FILE")

# Determina a dónde mover en toggle
if [[ "$last_monitor" == "$monitor_primary" ]]; then
  target_monitor="$monitor_secondary"
else
  target_monitor="$monitor_primary"
fi

# Ejecuta el movimiento
hyprctl dispatch moveworkspacetomonitor "$current_workspace" "$target_monitor"

# Actualiza el archivo con el nuevo estado
echo "$target_monitor" > "$STATE_FILE"


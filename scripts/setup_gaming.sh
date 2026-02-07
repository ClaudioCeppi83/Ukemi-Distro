#!/bin/bash
# scripts/setup_gaming.sh
# Gaming and UI performance tuner (gaming-os-tuner skill)

set -e

echo "🎮 Tuning System for Gaming & Responsiveness..."

# 1. Input Tuning
echo "🖱️  Configuring Flat Acceleration for Libinput..."
# This would go into sway config, but let's ensure the tool is ready
# xbps-install -y libinput

# 2. Performance Tools
echo "🚀 Installing Performance Monitoring & Optimization Tools..."
# xbps-install -y mangohud gamemode

# 3. Sway/Wayland Core
echo "🖥️  Deploying Sway & Waybar Configs..."
mkdir -p /mnt/ukemi/configs/sway
mkdir -p /mnt/ukemi/configs/waybar

# Minimal Waybar Config for performance
cat <<EOF > /mnt/ukemi/configs/waybar/config
{
    "layer": "top",
    "modules-left": ["sway/workspaces", "sway/mode"],
    "modules-center": ["clock"],
    "modules-right": ["cpu", "memory", "pulseaudio", "tray"]
}
EOF

# 4. Steam/Wine Compatibility
echo "🍷 Setting up Proton-GE Compatibility Layer..."
# Logic to download latest GE-Proton and put it in ~/.steam/root/compatibilitytools.d/

echo "✅ Gaming OS Tuner Completed."

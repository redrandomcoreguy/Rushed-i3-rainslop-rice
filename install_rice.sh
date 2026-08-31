#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Starting...${NC}"

if command -v pacman &> /dev/null; then
    PKG_MGR="pacman"
elif command -v apt-get &> /dev/null; then
    PKG_MGR="apt"
elif command -v dnf &> /dev/null; then
    PKG_MGR="dnf"
elif command -v zypper &> /dev/null; then
    PKG_MGR="zypper"
elif command -v xbps-install &> /dev/null; then
    PKG_MGR="xbps"
else
    PKG_MGR="unknown"
fi

echo -e "${GREEN}Detected Package Manager: $PKG_MGR${NC}"

install_autotiling() {
    echo -e "${BLUE}Installing Autotiling...${NC}"
    if ! command -v autotiling &> /dev/null; then
        TMP_DIR=$(mktemp -d)
        git clone https://github.com/nwg-piotr/autotiling "$TMP_DIR/autotiling"
        mkdir -p "$HOME/.local/bin"
        cp "$TMP_DIR/autotiling/autotiling/main.py" "$HOME/.local/bin/autotiling"
        chmod +x "$HOME/.local/bin/autotiling"
        rm -rf "$TMP_DIR"
    fi
}

case "$PKG_MGR" in
    pacman)
        echo -e "${BLUE}Installing packages via pacman...${NC}"
        sudo pacman -Syu --noconfirm
        sudo pacman -S --needed --noconfirm i3-wm picom polybar rofi kitty pipewire pipewire-pulse brightnessctl feh python-pip python-i3ipc git ttf-jetbrains-mono-nerd
        if command -v paru &> /dev/null; then
            paru -S --needed --noconfirm autotiling
        elif command -v yay &> /dev/null; then
            yay -S --needed --noconfirm autotiling
        else
            install_autotiling
        fi
        ;;
    apt)
        echo -e "${BLUE}Installing packages via apt...${NC}"
        sudo apt-get update
        sudo apt-get install -y i3 picom polybar rofi kitty pipewire pipewire-pulse brightnessctl feh python3-pip python3-i3ipc git fonts-jetbrains-mono
        install_autotiling
        ;;
    dnf)
        echo -e "${BLUE}Installing packages via dnf...${NC}"
        sudo dnf install -y i3 picom polybar rofi kitty pipewire pipewire-pulseaudio brightnessctl feh python3-pip python3-i3ipc git jetbrains-mono-fonts-all
        install_autotiling
        ;;
    zypper)
        echo -e "${BLUE}Installing packages via zypper...${NC}"
        sudo zypper refresh
        sudo zypper install -y i3 picom polybar rofi kitty pipewire pipewire-pulseaudio brightnessctl feh python3-pip python3-i3ipc git jetbrains-mono-fonts
        install_autotiling
        ;;
    xbps)
        echo -e "${BLUE}Installing packages via xbps...${NC}"
        sudo xbps-install -S i3 picom polybar rofi kitty pipewire pipewire-pulse brightnessctl feh python3-pip python3-i3ipc git nerd-fonts
        install_autotiling
        ;;
    *)
        echo -e "${RED}Unsupported package manager. Please install dependencies manually:${NC}"
        echo "i3, picom, polybar, rofi, kitty, pipewire, brightnessctl, feh, autotiling, JetBrains Mono font"
        install_autotiling
        ;;
esac

echo -e "${BLUE}Copying configuration files...${NC}"

RICE_DIR=$(dirname "$(realpath "$0")")
CONFIG_DIR="$HOME/.config"
APP_DIR="$HOME/.local/share/applications"

mkdir -p "$CONFIG_DIR" "$APP_DIR" "$HOME/.local/bin"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

for dir in i3 kitty picom polybar rofi; do
    if [ -d "$RICE_DIR/$dir" ]; then
        if [ -d "$CONFIG_DIR/$dir" ] && [ ! -w "$CONFIG_DIR/$dir" ]; then
            sudo chown -R $USER:$USER "$CONFIG_DIR/$dir" 2>/dev/null || true
        fi
        cp -r "$RICE_DIR/$dir" "$CONFIG_DIR/"
    fi
done

if [ -f "$RICE_DIR/wallpaper-picker.desktop" ]; then
    cp "$RICE_DIR/wallpaper-picker.desktop" "$APP_DIR/"
fi

chmod +x "$CONFIG_DIR/polybar/launch.sh" 2>/dev/null || true
chmod +x "$CONFIG_DIR/i3/Wallpaperconfig/rofi-wallpaper.sh" 2>/dev/null || true

if command -v feh &> /dev/null && [ -f "$CONFIG_DIR/i3/Wallpaperconfig/Wallpapers/Cut_Rainy_Grass.jpg" ]; then
    feh --bg-fill "$CONFIG_DIR/i3/Wallpaperconfig/Wallpapers/Cut_Rainy_Grass.jpg" 2>/dev/null || true
fi

echo -e "${GREEN}Installation completed!${NC}"
echo -e "${BLUE}Please restart your session and select i3 as your window manager.${NC}"

#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting the Rushed-i3-rainslop-rice Installation Script...${NC}"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    LIKE=$ID_LIKE
else
    echo "Cannot detect OS. Exiting."
    exit 1
fi

echo -e "${GREEN}Detected OS: $OS${NC}"

APT_DEPS="i3 picom polybar rofi kitty pipewire pipewire-pulse brightnessctl feh python3-pip git fonts-jetbrains-mono"
PACMAN_DEPS="i3-wm picom polybar rofi kitty pipewire pipewire-pulse brightnessctl feh python-pip git ttf-jetbrains-mono-nerd"
DNF_DEPS="i3 picom polybar rofi kitty pipewire pipewire-pulseaudio brightnessctl feh python3-pip git jetbrains-mono-fonts-all"

install_autotiling() {
    echo -e "${BLUE}Installing Autotiling...${NC}"
    if ! command -v autotiling &> /dev/null; then
        echo -e "${BLUE}Cloning Autotiling...${NC}"
        TMP_DIR=$(mktemp -d)
        git clone https://github.com/nwg-piotr/autotiling $TMP_DIR/autotiling
        
        mkdir -p ~/.local/bin
        cp $TMP_DIR/autotiling/autotiling/main.py ~/.local/bin/autotiling
        chmod +x ~/.local/bin/autotiling
        rm -rf $TMP_DIR
    else
        echo "Autotiling is already installed."
    fi
}

install_i3ipc() {
    echo -e "${BLUE}Installing python-i3ipc...${NC}"
    if [[ "$OS" == "arch" || "$LIKE" == *"arch"* ]]; then
        sudo pacman -S --needed --noconfirm python-i3ipc
    elif [[ "$OS" == "debian" || "$OS" == "ubuntu" || "$LIKE" == *"debian"* ]]; then
        sudo apt-get install -y python3-i3ipc
    elif [[ "$OS" == "fedora" || "$LIKE" == *"fedora"* ]]; then
        sudo dnf install -y python3-i3ipc
    else
        echo -e "Could not find package for python-i3ipc. Install manually via pip3."
    fi
}

if [[ "$OS" == "arch" || "$LIKE" == *"arch"* ]]; then
    echo -e "${BLUE}Installing packages using pacman...${NC}"
    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed --noconfirm $PACMAN_DEPS
    
    install_i3ipc
    
    if command -v paru &> /dev/null; then
        paru -S --needed --noconfirm autotiling
    elif command -v yay &> /dev/null; then
        yay -S --needed --noconfirm autotiling
    else
        install_autotiling
    fi

elif [[ "$OS" == "debian" || "$OS" == "ubuntu" || "$LIKE" == *"debian"* ]]; then
    echo -e "${BLUE}Installing packages using apt...${NC}"
    sudo apt-get update
    sudo apt-get install -y $APT_DEPS
    install_i3ipc
    install_autotiling

elif [[ "$OS" == "fedora" || "$LIKE" == *"fedora"* ]]; then
    echo -e "${BLUE}Installing packages using dnf...${NC}"
    sudo dnf install -y $DNF_DEPS
    install_i3ipc
    install_autotiling
else
    echo "Unsupported distribution. Please install dependencies manually."
fi

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

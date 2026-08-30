# I3 RainSlop rice test

A clean, customizable i3 window manager setup ("rice") with automated multi-distro installation and update scripts.

---

## eEvery i used 

* **Window Manager:** i3-wm
* **Bar:** Polybar
* **Compositor:** Picom
* **App Launcher:** Rofi
* **Terminal:** Kitty
* **Tiling Helper:** [Autotiling](https://github.com/nwg-piotr/autotiling) (automatic horizontal/vertical split alternation)
* **Audio:** PipeWire & PipeWire-Pulse
* **Utilities:** `brightnessctl`, `feh`

---

## Install

### 1. Clone the repo
```bash
git clone https://github.com/<YOUR-USERNAME>/I3_RainSlop.git
cd I3_RainSlop
```

### 2. Run the installer
```bash
./install_rice.sh
```

The script automatically detects your distribution (like arch, debian/ubuntu, fedora) and:
1. Installs all required packages and dependencies.
2. Sets up `autotiling`.
3. Copies configuration files to `~/.config/`.
4. Installs desktop shortcuts to `~/.local/share/applications/`.

---

## 🔄 Updating Dotfiles (For Maintainers)

If you modify your configs and want to update this repository:
```bash
./update_rice.sh
```
This syncs your active configuration from `~/.config/` into this directory so you can commit and push your changes.

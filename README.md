# I3 rainSlop 

A clean, customizable i3 window manager setup ("rice") with automated multi-distro installation scripts.

---

## Everything in here

* **Window Manager:** i3-wm
* **Bar:** Polybar (with CPU, RAM, Battery, Audio, Network, and Date modules)
* **Compositor:** Picom (compositor)
* **App Launcher:** Rofi (custom translucent theme with mouse hover support)
* **Terminal:** Kitty
* **Tiling :** [Autotiling](https://github.com/nwg-piotr/autotiling) (automatic tiling)
* **Audio:** PipeWire and WirePlumber
* **Other:** `brightnessctl`, `feh` (wallpaper manager), `wallpaper-picker` shortcut

---

## Install

### 1. Clone the repo
```bash
git clone https://github.com/<YOUR-USERNAME>/I3_RainSlop.git
cd I3_RainSlop
```

### 2. Make executable and run the installer
```bash
chmod +x install_rice.sh
./install_rice.sh
```
*(Or simply run: `bash install_rice.sh`)*

The script automatically detects your distribution (Arch, Debian/Ubuntu, Fedora) and:
1. Installs all required packages and dependencies via your system package manager.
2. Clones and sets up `autotiling`.
3. Copies configuration files to `~/.config/`.
4. Installs desktop shortcuts to `~/.local/share/applications/`.

---

> **Mod Key:** The default `$mod` key is `Super` (Windows Key).

### Applications
| Keybinding | Action |
| :--- | :--- |
| `$mod + z` | Launch Kitty Terminal |
| `$mod + Tab` | Open Rofi App Launcher |
| `$mod + x` | Close / Kill focused window |
| `$mod + o` | Reload i3 configuration |
| `$mod + Shift + o` | Restart i3 in-place |
| `$mod + p` | Exit / Logout of i3 session |

### Audio/brightness
| Keybinding | Action |
| :--- | :--- |
| `$mod + F1` | Toggle Mute / Unmute audio |
| `$mod + F2` | Lower volume (-5%) |
| `$mod + F3` | Raise volume (+5%, capped at 150%) |
| `$mod + F6` | Lower screen brightness (-5%) |
| `$mod + F7` | Raise screen brightness (+5%) |

### Windows
| Keybinding | Action |
| :--- | :--- |
| `$mod + Left / Down / Up / Right` | Focus window in direction |
| `$mod + Shift + Left / Down / Up / Right` | Move window in direction |
| `$mod + Left Click (drag)` | Move floating/tiling window |
| `$mod + f` | Toggle Fullscreen |
| `$mod + v` | Toggle Floating / Tiling |
| `$mod + e` | Toggle Split direction |

### Workspaces
| Keybinding | Action |
| :--- | :--- |
| `$mod + 1` ... `$mod + 9` | Switch to Workspace 1 – 9 |
| `$mod + Shift + 1` ... `$mod + Shift + 9` | Move focused window to Workspace 1 – 9 |

### Kitty Terminal Shortcuts
| Keybinding | Action |
| :--- | :--- |
| `Ctrl + Shift + a` | Open new Kitty window / split |
| `Ctrl + Shift + s` | Close current Kitty window |

### 📊 Polybar Actions
* **Volume Icon / Label:** Right-click opens `pavucontrol` (audio control panel).

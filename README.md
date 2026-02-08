# RomFetch - ROM Downloader for RetroPie

A user-friendly ROM downloading tool for RetroPie with a beautiful text-based UI. Browse and download ROMs from your GitHub repository directly to your RetroPie system.

![RomFetch](https://img.shields.io/badge/RetroPie-Compatible-red)
![License](https://img.shields.io/badge/license-MIT-blue)

## Features

- 🎮 **Browse by System** - Navigate through organized console/system categories
- 🔍 **Search Functionality** - Search across all systems for specific ROMs
- 📦 **Auto-Download** - Download ROMs directly to RetroPie's ROM directories
- 🎨 **Beautiful UI** - Color-coded dialog-based interface
- 🔄 **Auto-Updates** - Dynamically fetches the latest ROM list from GitHub
- 💾 **Smart Caching** - Caches system lists for faster browsing

## Installation

### Quick Install

Run this one-liner on your RetroPie system:

```bash
curl -L https://raw.githubusercontent.com/Cyborg-Taco/romfetch/main/install.sh | bash
```

### Manual Installation

1. Clone the repository:
```bash
cd ~
git clone https://github.com/Cyborg-Taco/romfetch.git
cd romfetch
```

2. Make the script executable:
```bash
chmod +x romfetch.sh install.sh
```

3. Run the installer:
```bash
bash install.sh
```

## Usage

### From Command Line

Simply run:
```bash
./romfetch
```

Or if you created the shortcut during installation:
```bash
~/romfetch
```

### From RetroPie Menu

If installed correctly, you'll find "RomFetch" in your RetroPie menu.

### Navigation

- Use **Arrow Keys** to navigate menus
- Press **Enter** to select
- Press **Esc** or select "Exit" to go back

## Menu Options

### 1. Browse ROMs by System
Browse ROMs organized by gaming system (NES, SNES, Genesis, etc.)

### 2. Search All ROMs
Search across all systems for a specific game

### 3. Refresh System List
Force refresh the system cache from GitHub

### 4. About
View information about RomFetch

## Requirements

- RetroPie (or any Linux system)
- Internet connection
- The following packages (auto-installed):
  - `dialog`
  - `curl`
  - `wget`

## Configuration

The script uses these default paths:
- **ROM Repository**: `https://github.com/Cyborg-Taco/Rom-Collection`
- **RetroPie ROMs**: `/home/pi/RetroPie/roms/`
- **Temp Directory**: `/tmp/romfetch/`

To change the repository, edit these lines in `romfetch.sh`:
```bash
REPO_OWNER="Cyborg-Taco"
REPO_NAME="Rom-Collection"
```

## Supported File Formats

- `.zip` - Compressed ROM files
- `.7z` - 7-Zip compressed files
- `.nes` - NES ROMs
- `.snes`, `.sfc` - SNES ROMs
- `.smd`, `.gen` - Genesis/Mega Drive ROMs
- `.gb`, `.gbc` - Game Boy ROMs
- `.gba` - Game Boy Advance ROMs
- `.n64`, `.z64`, `.v64` - Nintendo 64 ROMs
- `.nds` - Nintendo DS ROMs
- `.psx`, `.cue`, `.bin` - PlayStation ROMs
- `.iso`, `.img` - Disc images

## Troubleshooting

### "dialog not installed" Error
Run: `sudo apt-get install dialog`

### ROMs not appearing
1. Check your internet connection
2. Verify the Rom-Collection repository is accessible
3. Try "Refresh System List" from the main menu

### Downloads failing
1. Ensure you have write permissions to `/home/pi/RetroPie/roms/`
2. Check available disk space: `df -h`
3. Verify the ROM files exist in the repository

### Permission denied
Make sure the script is executable:
```bash
chmod +x romfetch.sh
```

## Repository Structure

This tool expects your ROM collection repository to follow this structure:
```
Rom-Collection/
├── README.md
├── nes/
│   ├── game1.nes
│   ├── game2.zip
│   └── game3.nes
├── snes/
│   ├── game1.sfc
│   └── game2.zip
├── genesis/
│   ├── game1.gen
│   └── game2.smd
├── n64/
│   ├── game1.z64
│   └── game2.n64
└── ... (more systems)
```

See the [Rom-Collection Folder Structure](#rom-collection-folder-structure) section below.

## Updating

To update RomFetch to the latest version:

```bash
cd ~/romfetch
git pull
bash install.sh
```

Or run the installer again:
```bash
curl -L https://raw.githubusercontent.com/Cyborg-Taco/romfetch/main/install.sh | bash
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Disclaimer

This tool is for downloading ROMs that you legally own. The developer is not responsible for any copyright infringement. Please ensure you have the legal right to download and use any ROMs.

## Credits

Created by Cyborg-Taco

## Support

If you encounter any issues or have questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Open an issue on GitHub
3. Check existing issues for solutions

---

**Enjoy your retro gaming! 🎮**

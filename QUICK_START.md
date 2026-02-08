# RomFetch - Quick Start Guide

## Repository Setup

### 1. Create Your Repositories

You need TWO repositories:

#### Repository 1: romfetch (the script)
```
https://github.com/Cyborg-Taco/romfetch
```

**Files to upload:**
- `romfetch.sh` (main script)
- `install.sh` (installer)
- `README.md` (documentation)

#### Repository 2: Rom-Collection (your ROMs)
```
https://github.com/Cyborg-Taco/Rom-Collection
```

**Folder structure:**
```
Rom-Collection/
├── README.md
├── nes/
│   ├── game1.nes
│   └── game2.nes
├── snes/
│   ├── game1.sfc
│   └── game2.sfc
├── genesis/
│   └── game1.gen
└── (more systems...)
```

### 2. Upload Files to GitHub

#### For romfetch repository:

**Via Web:**
1. Go to https://github.com/Cyborg-Taco/romfetch
2. Click "Add file" → "Upload files"
3. Upload: `romfetch.sh`, `install.sh`, `README.md`
4. Commit changes

**Via Command Line:**
```bash
git clone https://github.com/Cyborg-Taco/romfetch.git
cd romfetch
# Copy the files here
cp /path/to/romfetch.sh .
cp /path/to/install.sh .
cp /path/to/README.md .
chmod +x romfetch.sh install.sh
git add .
git commit -m "Initial commit"
git push
```

#### For Rom-Collection repository:

**Via Web:**
1. Go to https://github.com/Cyborg-Taco/Rom-Collection
2. Click "Add file" → "Create new file"
3. Type `nes/README.md` to create the nes folder
4. Add your ROMs using "Upload files"

**Via Command Line:**
```bash
git clone https://github.com/Cyborg-Taco/Rom-Collection.git
cd Rom-Collection

# Create system folders
mkdir -p nes snes genesis gb gbc gba n64 psx arcade

# Copy your ROMs to the appropriate folders
cp ~/my-roms/SuperMario.nes nes/
cp ~/my-roms/Zelda.sfc snes/

# Commit and push
git add .
git commit -m "Add initial ROM collection"
git push
```

## Installation on RetroPie

### Quick Install (Recommended)

On your RetroPie system, run:

```bash
curl -L https://raw.githubusercontent.com/Cyborg-Taco/romfetch/main/install.sh | bash
```

### Manual Install

```bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y dialog curl wget

# Download the script
mkdir -p ~/romfetch
cd ~/romfetch
curl -L https://raw.githubusercontent.com/Cyborg-Taco/romfetch/main/romfetch.sh -o romfetch.sh
chmod +x romfetch.sh

# Run it
./romfetch.sh
```

## Using RomFetch

### Launch the Program

From command line:
```bash
~/romfetch/romfetch.sh
```

Or if you created the shortcut:
```bash
~/romfetch
```

### Navigate the Menu

1. **Browse ROMs by System**
   - Shows all available systems
   - Select a system to see available ROMs
   - Choose a ROM to download

2. **Search All ROMs**
   - Search across all systems
   - Enter game name
   - Select from search results

3. **Refresh System List**
   - Updates the cached system list
   - Use after adding new systems to your Rom-Collection

4. **About**
   - Shows version and repository info

### Keyboard Controls

- **Arrow Keys**: Navigate menus
- **Enter**: Select/confirm
- **Esc**: Go back/cancel
- **Tab**: Switch between buttons

## Folder Structure for Rom-Collection

### Example Structure

```
Rom-Collection/
│
├── README.md
│
├── nes/
│   ├── Super Mario Bros.nes
│   ├── The Legend of Zelda.nes
│   └── Metroid.zip
│
├── snes/
│   ├── Super Mario World.sfc
│   └── The Legend of Zelda - A Link to the Past.sfc
│
├── genesis/
│   ├── Sonic The Hedgehog.gen
│   └── Streets of Rage 2.smd
│
├── gb/
│   ├── Pokemon Red.gb
│   └── Tetris.gb
│
├── gba/
│   ├── Pokemon Emerald.gba
│   └── The Legend of Zelda - The Minish Cap.gba
│
└── n64/
    ├── Super Mario 64.z64
    └── The Legend of Zelda - Ocarina of Time.n64
```

### Important Notes

✅ **DO:**
- Use lowercase folder names (`nes`, not `NES`)
- Use descriptive ROM file names
- Compress large files as `.zip`
- Keep folder structure flat (ROMs directly in system folders)

❌ **DON'T:**
- Use special characters in folder names
- Create subfolders inside system folders
- Upload files larger than 100MB without Git LFS
- Use uppercase folder names

## System Folder Names Reference

| Folder Name | System |
|------------|--------|
| `nes` | Nintendo Entertainment System |
| `snes` | Super Nintendo |
| `n64` | Nintendo 64 |
| `gb` | Game Boy |
| `gbc` | Game Boy Color |
| `gba` | Game Boy Advance |
| `nds` | Nintendo DS |
| `genesis` | Sega Genesis/Mega Drive |
| `mastersystem` | Sega Master System |
| `gamegear` | Sega Game Gear |
| `psx` | PlayStation 1 |
| `ps2` | PlayStation 2 |
| `psp` | PlayStation Portable |
| `arcade` | MAME Arcade |
| `neogeo` | Neo Geo |
| `atari2600` | Atari 2600 |
| `atari7800` | Atari 7800 |

## Troubleshooting

### "Failed to fetch systems from GitHub"
- Check internet connection
- Verify repository exists and is public
- Check repository URL in script

### "No ROMs found for [system]"
- Ensure ROMs are in the correct folder
- Verify file extensions are supported
- Check folder name is lowercase

### Downloads are slow
- Normal for large files
- Consider compressing ROMs as `.zip`
- Check your internet connection

### Permission errors
- Run: `chmod +x ~/romfetch/romfetch.sh`
- Check write permissions: `ls -la ~/RetroPie/roms`

## Updating RomFetch

```bash
cd ~/romfetch
curl -L https://raw.githubusercontent.com/Cyborg-Taco/romfetch/main/romfetch.sh -o romfetch.sh
chmod +x romfetch.sh
```

## Adding New ROMs

After adding ROMs to your Rom-Collection repository:

1. Push changes to GitHub
2. In RomFetch, select "Refresh System List"
3. Browse or search for your new ROMs

## Tips

💡 **Compress large ROMs**: Use `.zip` format to reduce file sizes

💡 **Private repository**: Consider making Rom-Collection private for legal reasons

💡 **Backup**: Always keep local backups of your ROM collection

💡 **Test**: Download a test ROM first to verify everything works

💡 **Organize**: Use clear, descriptive names for your ROM files

## Support

- **RomFetch Issues**: https://github.com/Cyborg-Taco/romfetch/issues
- **RetroPie Forum**: https://retropie.org.uk/forum/
- **Check README**: Full documentation in the README.md

---

**Happy gaming! 🎮**

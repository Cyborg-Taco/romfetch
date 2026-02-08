# Rom-Collection Repository Folder Structure

This document explains how to organize your ROM files in the Rom-Collection repository for use with RomFetch.

## Directory Structure

```
Rom-Collection/
├── README.md
├── LICENSE
│
├── nes/                    # Nintendo Entertainment System
│   ├── Super Mario Bros.nes
│   ├── The Legend of Zelda.nes
│   └── Metroid.zip
│
├── snes/                   # Super Nintendo Entertainment System
│   ├── Super Mario World.sfc
│   ├── The Legend of Zelda - A Link to the Past.sfc
│   └── Super Metroid.zip
│
├── genesis/                # Sega Genesis / Mega Drive
│   ├── Sonic The Hedgehog.gen
│   ├── Streets of Rage 2.smd
│   └── Phantasy Star IV.zip
│
├── mastersystem/           # Sega Master System
│   ├── Alex Kidd in Miracle World.sms
│   └── Phantasy Star.zip
│
├── gb/                     # Game Boy
│   ├── Pokemon Red.gb
│   ├── Tetris.gb
│   └── The Legend of Zelda - Links Awakening.zip
│
├── gbc/                    # Game Boy Color
│   ├── Pokemon Crystal.gbc
│   ├── The Legend of Zelda - Oracle of Seasons.gbc
│   └── Pokemon Gold.zip
│
├── gba/                    # Game Boy Advance
│   ├── Pokemon Emerald.gba
│   ├── The Legend of Zelda - The Minish Cap.gba
│   └── Metroid Fusion.zip
│
├── n64/                    # Nintendo 64
│   ├── Super Mario 64.z64
│   ├── The Legend of Zelda - Ocarina of Time.n64
│   └── Mario Kart 64.v64
│
├── nds/                    # Nintendo DS
│   ├── Pokemon Diamond.nds
│   ├── New Super Mario Bros.nds
│   └── The Legend of Zelda - Phantom Hourglass.zip
│
├── psx/                    # PlayStation 1
│   ├── Final Fantasy VII/
│   │   ├── Final Fantasy VII (Disc 1).bin
│   │   ├── Final Fantasy VII (Disc 1).cue
│   │   ├── Final Fantasy VII (Disc 2).bin
│   │   ├── Final Fantasy VII (Disc 2).cue
│   │   ├── Final Fantasy VII (Disc 3).bin
│   │   └── Final Fantasy VII (Disc 3).cue
│   └── Crash Bandicoot.zip
│
├── ps2/                    # PlayStation 2
│   ├── Grand Theft Auto - San Andreas.iso
│   └── God of War.iso
│
├── psp/                    # PlayStation Portable
│   ├── God of War - Chains of Olympus.iso
│   └── Grand Theft Auto - Liberty City Stories.cso
│
├── dreamcast/              # Sega Dreamcast
│   ├── Sonic Adventure.cdi
│   └── Crazy Taxi.gdi
│
├── saturn/                 # Sega Saturn
│   ├── Nights into Dreams.cue
│   └── Panzer Dragoon.iso
│
├── gamecube/               # Nintendo GameCube
│   ├── Super Smash Bros Melee.iso
│   └── The Legend of Zelda - The Wind Waker.gcm
│
├── wii/                    # Nintendo Wii
│   ├── Super Mario Galaxy.wbfs
│   └── The Legend of Zelda - Twilight Princess.iso
│
├── wiiu/                   # Nintendo Wii U
│   └── The Legend of Zelda - Breath of the Wild/
│
├── 3ds/                    # Nintendo 3DS
│   ├── Pokemon X.3ds
│   └── The Legend of Zelda - A Link Between Worlds.cia
│
├── switch/                 # Nintendo Switch
│   └── (Note: Be cautious with modern systems)
│
├── atari2600/              # Atari 2600
│   ├── Pitfall.a26
│   └── Space Invaders.bin
│
├── atari5200/              # Atari 5200
│   └── Pac-Man.a52
│
├── atari7800/              # Atari 7800
│   └── Asteroids.a78
│
├── atarilynx/              # Atari Lynx
│   └── California Games.lnx
│
├── atarijaguar/            # Atari Jaguar
│   └── Tempest 2000.j64
│
├── colecovision/           # ColecoVision
│   └── Donkey Kong.col
│
├── intellivision/          # Intellivision
│   └── Astrosmash.int
│
├── vectrex/                # Vectrex
│   └── Mine Storm.vec
│
├── neogeo/                 # Neo Geo
│   ├── Metal Slug.zip
│   └── King of Fighters 98.zip
│
├── arcade/                 # MAME / Arcade
│   ├── pacman.zip
│   ├── mslug.zip
│   └── sf2.zip
│
├── fba/                    # Final Burn Alpha
│   └── various arcade ROMs
│
├── mame-libretro/          # MAME (Libretro)
│   └── various arcade ROMs
│
├── pcengine/               # PC Engine / TurboGrafx-16
│   └── Bonks Adventure.pce
│
├── pcenginecd/             # PC Engine CD / TurboGrafx-CD
│   └── Castlevania - Rondo of Blood.cue
│
├── sega32x/                # Sega 32X
│   └── Doom.32x
│
├── segacd/                 # Sega CD / Mega CD
│   ├── Sonic CD.cue
│   └── Sonic CD.bin
│
├── sg-1000/                # Sega SG-1000
│   └── Congo Bongo.sg
│
├── amiga/                  # Commodore Amiga
│   └── Lemmings.adf
│
├── amstradcpc/             # Amstrad CPC
│   └── Prince of Persia.cdt
│
├── apple2/                 # Apple II
│   └── Oregon Trail.dsk
│
├── c64/                    # Commodore 64
│   ├── Impossible Mission.d64
│   └── The Last Ninja.tap
│
├── msx/                    # MSX
│   └── Metal Gear.rom
│
├── zxspectrum/             # ZX Spectrum
│   └── Manic Miner.z80
│
├── dos/                    # MS-DOS
│   └── DOOM/
│       └── DOOM.zip
│
├── scummvm/                # ScummVM
│   └── Monkey Island/
│
└── ports/                  # Game Ports
    └── doom/
        └── doom.wad
```

## Naming Conventions

### Best Practices

1. **Use descriptive names**: `Super Mario Bros.nes` not `smb.nes`
2. **Include version/region if relevant**: `Pokemon Red (USA).gb`
3. **Use proper capitalization**: Follow the official game title
4. **Avoid special characters**: Stick to letters, numbers, spaces, hyphens, and underscores
5. **Multi-disc games**: Use folders or clear naming like `Game Name (Disc 1).bin`

### Examples

✅ **Good**:
- `The Legend of Zelda - Ocarina of Time.z64`
- `Final Fantasy VII (USA) (Disc 1).bin`
- `Pokemon - Crystal Version.gbc`
- `Super Smash Bros Melee (USA).iso`

❌ **Avoid**:
- `zelda_oot.z64`
- `ff7d1.bin`
- `pokemon_crystal.gbc`
- `ssbm.iso`

## System Directory Names

Use these exact directory names (lowercase) to ensure compatibility with RetroPie:

| Directory | System | File Extensions |
|-----------|--------|-----------------|
| `nes` | Nintendo Entertainment System | .nes, .unf, .unif |
| `snes` | Super Nintendo | .smc, .sfc, .swc, .fig |
| `n64` | Nintendo 64 | .z64, .n64, .v64 |
| `gb` | Game Boy | .gb |
| `gbc` | Game Boy Color | .gbc |
| `gba` | Game Boy Advance | .gba |
| `nds` | Nintendo DS | .nds |
| `genesis` | Sega Genesis/Mega Drive | .smd, .bin, .gen, .md |
| `mastersystem` | Sega Master System | .sms |
| `gamegear` | Sega Game Gear | .gg |
| `sega32x` | Sega 32X | .32x, .smd, .bin, .md |
| `segacd` | Sega CD | .cue, .chd, .iso |
| `saturn` | Sega Saturn | .cue, .chd, .iso |
| `dreamcast` | Sega Dreamcast | .cdi, .gdi, .chd |
| `psx` | PlayStation 1 | .cue, .bin, .chd, .iso, .img |
| `ps2` | PlayStation 2 | .iso, .chd |
| `psp` | PlayStation Portable | .iso, .cso |
| `pcengine` | PC Engine/TurboGrafx-16 | .pce |
| `atari2600` | Atari 2600 | .bin, .a26 |
| `atari7800` | Atari 7800 | .a78 |
| `atarilynx` | Atari Lynx | .lnx |
| `atarijaguar` | Atari Jaguar | .j64, .jag |
| `neogeo` | Neo Geo | .zip |
| `arcade` | MAME Arcade | .zip |
| `fba` | Final Burn Alpha | .zip |

## File Size Considerations

GitHub has file size limits:
- **Individual file limit**: 100 MB
- **Repository limit**: 1 GB (soft limit)
- **Recommended**: Use compression (.zip, .7z) for larger ROMs

### Tips for Large Files

1. **Compress ROMs**: Use `.zip` or `.7z` format
2. **Use Git LFS**: For files over 100 MB
3. **Split into parts**: For very large games
4. **Alternative hosting**: Consider using releases for large files

## Adding ROMs to Your Repository

### Using Git

```bash
# Clone your Rom-Collection repository
git clone https://github.com/Cyborg-Taco/Rom-Collection.git
cd Rom-Collection

# Create a system directory if it doesn't exist
mkdir -p nes

# Add ROM files
cp ~/Downloads/SuperMarioBros.nes nes/

# Commit and push
git add nes/SuperMarioBros.nes
git commit -m "Add Super Mario Bros for NES"
git push
```

### Using GitHub Web Interface

1. Navigate to your Rom-Collection repository on GitHub
2. Click on a system folder (e.g., `nes/`)
3. Click "Add file" → "Upload files"
4. Drag and drop ROM files
5. Commit the changes

## Important Notes

### Legal Disclaimer

⚠️ **Only upload ROMs that you legally own or have the right to distribute.**

- Dumping your own cartridges/discs is generally legal for personal use
- Distributing copyrighted games without permission is illegal
- Public repositories are visible to everyone

### Recommended: Private Repository

Consider making your Rom-Collection repository **private** to avoid potential legal issues:

1. Go to repository Settings
2. Scroll to "Danger Zone"
3. Click "Change repository visibility"
4. Select "Make private"

RomFetch works with both public and private repositories (you may need to add authentication for private repos).

## Multi-Disc Games

For games with multiple discs (common on PlayStation):

### Option 1: Use Folders
```
psx/
└── Final Fantasy VII/
    ├── Final Fantasy VII (Disc 1).bin
    ├── Final Fantasy VII (Disc 1).cue
    ├── Final Fantasy VII (Disc 2).bin
    ├── Final Fantasy VII (Disc 2).cue
    ├── Final Fantasy VII (Disc 3).bin
    └── Final Fantasy VII (Disc 3).cue
```

### Option 2: Use Clear Naming
```
psx/
├── Final Fantasy VII (Disc 1).bin
├── Final Fantasy VII (Disc 1).cue
├── Final Fantasy VII (Disc 2).bin
├── Final Fantasy VII (Disc 2).cue
├── Final Fantasy VII (Disc 3).bin
└── Final Fantasy VII (Disc 3).cue
```

## Testing Your Structure

After setting up your Rom-Collection repository:

1. Run RomFetch
2. Select "Browse ROMs by System"
3. Verify all systems appear
4. Check that ROMs are listed correctly
5. Test downloading a ROM

## Maintenance

### Regular Tasks

- Remove duplicate ROMs
- Verify file integrity
- Update game names for clarity
- Organize into subfolders if needed (e.g., by region)
- Clean up test files

### Backup

Always keep local backups of your ROM collection outside of GitHub!

## Getting Help

If you encounter issues with your repository structure:

1. Check the RomFetch repository for updates
2. Verify folder names match RetroPie's expectations
3. Ensure file extensions are correct
4. Check GitHub's file size limits

---

Happy organizing! 🎮

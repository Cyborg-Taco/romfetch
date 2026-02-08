#!/bin/bash

# RomFetch Installation Script

echo "========================================="
echo "  RomFetch Installer for RetroPie"
echo "========================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
    echo "Please do not run as root (don't use sudo)"
    exit 1
fi

# Check if dialog is installed
echo "Checking dependencies..."
if ! command -v dialog &> /dev/null; then
    echo "Installing dialog package..."
    sudo apt-get update
    sudo apt-get install -y dialog
fi

if ! command -v curl &> /dev/null; then
    echo "Installing curl package..."
    sudo apt-get install -y curl
fi

if ! command -v wget &> /dev/null; then
    echo "Installing wget package..."
    sudo apt-get install -y wget
fi

echo ""
echo "Creating installation directory..."
INSTALL_DIR="$HOME/romfetch"
mkdir -p "$INSTALL_DIR"

echo "Downloading RomFetch..."
curl -L "https://raw.githubusercontent.com/Cyborg-Taco/romfetch/main/romfetch.sh" -o "$INSTALL_DIR/romfetch.sh"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download RomFetch"
    exit 1
fi

chmod +x "$INSTALL_DIR/romfetch.sh"

# Create a shortcut in the home directory
ln -sf "$INSTALL_DIR/romfetch.sh" "$HOME/romfetch"

# Add to RetroPie menu if possible
if [ -d "$HOME/RetroPie/retropiemenu" ]; then
    echo "Creating RetroPie menu entry..."
    cat > "$HOME/RetroPie/retropiemenu/romfetch.sh" << 'EOF'
#!/bin/bash
bash "$HOME/romfetch/romfetch.sh"
EOF
    chmod +x "$HOME/RetroPie/retropiemenu/romfetch.sh"
fi

echo ""
echo "========================================="
echo "  Installation Complete!"
echo "========================================="
echo ""
echo "You can run RomFetch by typing:"
echo "  ./romfetch"
echo ""
echo "Or from the RetroPie menu"
echo ""
echo "To update RomFetch in the future, run:"
echo "  bash install.sh"
echo ""
read -p "Press Enter to start RomFetch now, or Ctrl+C to exit..."

bash "$INSTALL_DIR/romfetch.sh"

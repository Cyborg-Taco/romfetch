#!/bin/bash

# RomFetch - ROM Downloader for RetroPie
# Downloads ROMs from GitHub repository with a user-friendly interface

# Configuration
REPO_OWNER="Cyborg-Taco"
REPO_NAME="Rom-Collection"
REPO_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"
RAW_URL="https://raw.githubusercontent.com/${REPO_OWNER}/${REPO_NAME}/main"
API_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/contents"
RETROPIE_ROMS="/home/pi/RetroPie/roms"
TEMP_DIR="/tmp/romfetch"
CACHE_FILE="${TEMP_DIR}/systems_cache.txt"
CACHE_EXPIRY=3600 # 1 hour in seconds

# Colors for dialog
export DIALOGRC="/tmp/romfetch_dialogrc"

# Create dialog configuration for better appearance
cat > "$DIALOGRC" << 'EOF'
use_shadow = ON
use_colors = ON
screen_color = (CYAN,BLACK,ON)
shadow_color = (BLACK,BLACK,ON)
dialog_color = (BLACK,WHITE,OFF)
title_color = (BLUE,WHITE,ON)
border_color = (WHITE,WHITE,ON)
button_active_color = (WHITE,BLUE,ON)
button_inactive_color = (BLACK,WHITE,OFF)
button_key_active_color = (WHITE,BLUE,ON)
button_key_inactive_color = (RED,WHITE,OFF)
button_label_active_color = (YELLOW,BLUE,ON)
button_label_inactive_color = (BLACK,WHITE,ON)
inputbox_color = (BLACK,WHITE,OFF)
inputbox_border_color = (BLACK,WHITE,OFF)
searchbox_color = (BLACK,WHITE,OFF)
searchbox_title_color = (BLUE,WHITE,ON)
searchbox_border_color = (WHITE,WHITE,ON)
position_indicator_color = (BLUE,WHITE,ON)
menubox_color = (BLACK,WHITE,OFF)
menubox_border_color = (WHITE,WHITE,ON)
item_color = (BLACK,WHITE,OFF)
item_selected_color = (WHITE,BLUE,ON)
tag_color = (BLUE,WHITE,ON)
tag_selected_color = (YELLOW,BLUE,ON)
tag_key_color = (RED,WHITE,OFF)
tag_key_selected_color = (RED,BLUE,ON)
check_color = (BLACK,WHITE,OFF)
check_selected_color = (WHITE,BLUE,ON)
uarrow_color = (GREEN,WHITE,ON)
darrow_color = (GREEN,WHITE,ON)
EOF

# Initialize
mkdir -p "$TEMP_DIR"

# Function to show error dialog
show_error() {
    dialog --title "Error" --msgbox "$1" 10 50
}

# Function to show info dialog
show_info() {
    dialog --title "Info" --msgbox "$1" 10 50
}

# Function to show progress
show_progress() {
    local percent=$1
    local message=$2
    echo "$percent" | dialog --title "Please Wait" --gauge "$message" 10 70 0
}

# Function to fetch available systems from GitHub
fetch_systems() {
    local use_cache=0
    
    # Check if cache exists and is valid
    if [ -f "$CACHE_FILE" ]; then
        local cache_age=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0)))
        if [ $cache_age -lt $CACHE_EXPIRY ]; then
            use_cache=1
        fi
    fi
    
    if [ $use_cache -eq 0 ]; then
        # Fetch from GitHub API
        (
            echo "10"
            echo "# Connecting to GitHub..."
            sleep 1
            
            echo "50"
            echo "# Fetching system list..."
            
            # Get list of directories from the repo
            curl -s "${API_URL}" | grep -o '"name": "[^"]*"' | grep -o '"[^"]*"$' | tr -d '"' | grep -v "README\|LICENSE\|\.md\|\.txt" > "$CACHE_FILE" 2>&1
            
            echo "100"
            echo "# Done!"
            sleep 1
        ) | dialog --title "Updating System List" --gauge "Fetching data from GitHub..." 10 70 0
        
        if [ ! -s "$CACHE_FILE" ]; then
            show_error "Failed to fetch systems from GitHub.\nPlease check your internet connection."
            return 1
        fi
    fi
    
    return 0
}

# Function to fetch ROMs for a specific system
fetch_roms_for_system() {
    local system=$1
    local roms_file="${TEMP_DIR}/${system}_roms.txt"
    
    (
        echo "10"
        echo "# Fetching ROM list for ${system}..."
        
        # Get files from the system directory
        curl -s "${API_URL}/${system}" | grep -o '"name": "[^"]*"' | grep -o '"[^"]*"$' | tr -d '"' | grep -E "\.(zip|7z|nes|snes|sfc|smd|gen|gb|gbc|gba|n64|z64|v64|nds|psx|cue|bin|iso|img)$" > "$roms_file" 2>&1
        
        echo "100"
        echo "# Done!"
    ) | dialog --title "Loading ROMs" --gauge "Please wait..." 10 70 0
    
    if [ ! -s "$roms_file" ]; then
        show_error "No ROMs found for ${system}."
        return 1
    fi
    
    echo "$roms_file"
}

# Function to download a ROM
download_rom() {
    local system=$1
    local rom_name=$2
    local dest_dir="${RETROPIE_ROMS}/${system}"
    
    # Create destination directory if it doesn't exist
    mkdir -p "$dest_dir"
    
    # Download the ROM
    (
        echo "0"
        echo "# Downloading ${rom_name}..."
        
        wget --progress=dot "${RAW_URL}/${system}/${rom_name}" -O "${dest_dir}/${rom_name}" 2>&1 | \
        grep --line-buffered "%" | \
        sed -u -e "s,\.,,g" | \
        awk '{print substr($2, 1, length($2)-1); print "# Downloading: " substr($2, 1, length($2)-1) "%"; fflush()}'
        
        echo "100"
        echo "# Download complete!"
    ) | dialog --title "Downloading ROM" --gauge "Please wait..." 10 70 0
    
    if [ $? -eq 0 ]; then
        show_info "Successfully downloaded:\n${rom_name}\n\nSaved to:\n${dest_dir}/"
        return 0
    else
        show_error "Failed to download ${rom_name}"
        return 1
    fi
}

# Function to search ROMs across all systems
search_roms() {
    local search_term
    
    search_term=$(dialog --title "Search ROMs" --inputbox "Enter search term:" 10 50 3>&1 1>&2 2>&3)
    
    if [ -z "$search_term" ]; then
        return
    fi
    
    local results_file="${TEMP_DIR}/search_results.txt"
    > "$results_file"
    
    (
        echo "10"
        echo "# Searching all systems..."
        
        local count=0
        while IFS= read -r system; do
            # Fetch ROMs for this system
            curl -s "${API_URL}/${system}" | grep -o '"name": "[^"]*"' | grep -o '"[^"]*"$' | tr -d '"' | grep -iE "${search_term}" | while read -r rom; do
                echo "${system}|${rom}" >> "$results_file"
                ((count++))
            done
        done < "$CACHE_FILE"
        
        echo "100"
        echo "# Search complete! Found ${count} results."
        sleep 1
    ) | dialog --title "Searching" --gauge "Searching all systems for '${search_term}'..." 10 70 0
    
    if [ ! -s "$results_file" ]; then
        show_info "No ROMs found matching '${search_term}'"
        return
    fi
    
    # Build menu from results
    local menu_items=()
    local index=1
    while IFS='|' read -r system rom; do
        menu_items+=("$index" "[${system}] ${rom}")
        ((index++))
    done < "$results_file"
    
    local choice
    choice=$(dialog --title "Search Results for '${search_term}'" \
        --menu "Select a ROM to download:" 20 80 15 \
        "${menu_items[@]}" \
        3>&1 1>&2 2>&3)
    
    if [ -n "$choice" ]; then
        local selected_line=$(sed -n "${choice}p" "$results_file")
        local selected_system=$(echo "$selected_line" | cut -d'|' -f1)
        local selected_rom=$(echo "$selected_line" | cut -d'|' -f2)
        
        download_rom "$selected_system" "$selected_rom"
    fi
}

# Function to browse ROMs by system
browse_by_system() {
    local system=$1
    local roms_file
    
    roms_file=$(fetch_roms_for_system "$system")
    if [ $? -ne 0 ]; then
        return
    fi
    
    while true; do
        # Build menu from ROMs
        local menu_items=()
        local index=1
        while IFS= read -r rom; do
            menu_items+=("$index" "$rom")
            ((index++))
        done < "$roms_file"
        
        if [ ${#menu_items[@]} -eq 0 ]; then
            show_info "No ROMs found for ${system}"
            return
        fi
        
        local choice
        choice=$(dialog --title "${system} ROMs" \
            --menu "Select a ROM to download (${#menu_items[@]} total):" 20 80 15 \
            "${menu_items[@]}" \
            3>&1 1>&2 2>&3)
        
        if [ -z "$choice" ]; then
            return
        fi
        
        local selected_rom=$(sed -n "${choice}p" "$roms_file")
        download_rom "$system" "$selected_rom"
    done
}

# Function to show system selection menu
show_system_menu() {
    if ! fetch_systems; then
        return 1
    fi
    
    while true; do
        # Build menu from systems
        local menu_items=()
        local index=1
        while IFS= read -r system; do
            menu_items+=("$index" "$system")
            ((index++))
        done < "$CACHE_FILE"
        
        if [ ${#menu_items[@]} -eq 0 ]; then
            show_error "No systems found in repository."
            return 1
        fi
        
        local choice
        choice=$(dialog --title "Browse by System" \
            --menu "Select a system (${#menu_items[@]} available):" 20 60 15 \
            "${menu_items[@]}" \
            3>&1 1>&2 2>&3)
        
        if [ -z "$choice" ]; then
            return
        fi
        
        local selected_system=$(sed -n "${choice}p" "$CACHE_FILE")
        browse_by_system "$selected_system"
    done
}

# Function to show about dialog
show_about() {
    dialog --title "About RomFetch" --msgbox \
"RomFetch v1.0
ROM Downloader for RetroPie

Repository: ${REPO_URL}
Developer: Cyborg-Taco

This tool downloads ROMs from your
GitHub repository and organizes them
by system in RetroPie.

Press OK to continue." 15 50
}

# Main menu
main_menu() {
    while true; do
        local choice
        choice=$(dialog --title "RomFetch - ROM Downloader" \
            --menu "Choose an option:" 15 60 6 \
            1 "Browse ROMs by System" \
            2 "Search All ROMs" \
            3 "Refresh System List" \
            4 "About" \
            5 "Exit" \
            3>&1 1>&2 2>&3)
        
        case $choice in
            1) show_system_menu ;;
            2) search_roms ;;
            3) rm -f "$CACHE_FILE"; fetch_systems ;;
            4) show_about ;;
            5|"") break ;;
        esac
    done
}

# Cleanup function
cleanup() {
    clear
    rm -f "$DIALOGRC"
}

trap cleanup EXIT

# Check if dialog is installed
if ! command -v dialog &> /dev/null; then
    echo "Error: 'dialog' is not installed."
    echo "Please install it with: sudo apt-get install dialog"
    exit 1
fi

# Check if we're on RetroPie
if [ ! -d "$RETROPIE_ROMS" ]; then
    dialog --title "Warning" --yesno \
"RetroPie ROMs directory not found at:
${RETROPIE_ROMS}

ROMs will be downloaded to this location anyway.
Do you want to continue?" 12 60
    
    if [ $? -ne 0 ]; then
        exit 0
    fi
fi

# Show welcome screen
dialog --title "Welcome to RomFetch!" --msgbox \
"This tool will help you download ROMs
from your GitHub repository.

Repository: ${REPO_URL}

Press OK to continue." 12 50

# Start main menu
main_menu

clear
echo "Thank you for using RomFetch!"

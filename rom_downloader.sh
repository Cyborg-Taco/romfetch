#!/bin/bash
#
# RetroPie ROM Downloader
# A dialog-based UI for downloading ROMs from the Rom-Collection repository
#

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JSON_FILE="${SCRIPT_DIR}/roms.json"
JSON_URL="https://raw.githubusercontent.com/Cyborg-Taco/Rom-Collection/main/roms.json"
TEMP_DIR="/tmp/rom-downloader-$$"
SELECTION_FILE="${TEMP_DIR}/selected_roms.txt"
BASE_ROM_DIR="${HOME}/RetroPie/roms"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Cleanup on exit
cleanup() {
    rm -rf "${TEMP_DIR}"
}
trap cleanup EXIT

# Initialize
init() {
    mkdir -p "${TEMP_DIR}"
    touch "${SELECTION_FILE}"
    
    # Check if dialog is installed
    if ! command -v dialog &> /dev/null; then
        echo -e "${RED}Error: 'dialog' is not installed.${NC}"
        echo "Please install it with: sudo apt-get install dialog"
        exit 1
    fi
    
    # Check if jq is installed
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}Error: 'jq' is not installed.${NC}"
        echo "Please install it with: sudo apt-get install jq"
        exit 1
    fi
    
    # Check if wget is installed
    if ! command -v wget &> /dev/null; then
        echo -e "${RED}Error: 'wget' is not installed.${NC}"
        echo "Please install it with: sudo apt-get install wget"
        exit 1
    fi
    
    # Check if JSON file exists, if not offer to download
    check_json_update
}

# Download or update the JSON file
download_json() {
    local temp_json="${TEMP_DIR}/roms.json.tmp"
    
    echo "Downloading ROM database from repository..."
    
    if wget -q -O "${temp_json}" "${JSON_URL}"; then
        # Verify it's valid JSON
        if jq empty "${temp_json}" 2>/dev/null; then
            mv "${temp_json}" "${JSON_FILE}"
            echo "Successfully downloaded ROM database"
            return 0
        else
            echo "Error: Downloaded file is not valid JSON"
            rm -f "${temp_json}"
            return 1
        fi
    else
        echo "Error: Failed to download JSON file"
        rm -f "${temp_json}"
        return 1
    fi
}

# Check if JSON needs updating
check_json_update() {
    if [ ! -f "${JSON_FILE}" ]; then
        if dialog --yesno "ROM database not found. Download it now?" 10 50; then
            download_json
            if [ $? -ne 0 ]; then
                dialog --msgbox "Failed to download ROM database. Please check your internet connection and try again." 10 50
                exit 1
            fi
        else
            dialog --msgbox "ROM database is required to continue." 8 40
            exit 1
        fi
    fi
}

# Get list of systems from JSON
get_systems() {
    jq -r '.systems | keys[]' "${JSON_FILE}" | sort
}

# Get system display info
get_system_info() {
    local system="$1"
    jq -r ".systems[\"${system}\"]" "${JSON_FILE}"
}

# Get games for a system
get_games() {
    local system="$1"
    jq -r ".systems[\"${system}\"].games[] | .name" "${JSON_FILE}"
}

# Get game info
get_game_info() {
    local system="$1"
    local game_name="$2"
    jq -r ".systems[\"${system}\"].games[] | select(.name == \"${game_name}\")" "${JSON_FILE}"
}

# Check if ROM is selected
is_selected() {
    local system="$1"
    local game="$2"
    grep -q "^${system}|${game}$" "${SELECTION_FILE}" 2>/dev/null
}

# Toggle ROM selection
toggle_selection() {
    local system="$1"
    local game="$2"
    local key="${system}|${game}"
    
    if is_selected "${system}" "${game}"; then
        # Remove from selection
        grep -v "^${key}$" "${SELECTION_FILE}" > "${SELECTION_FILE}.tmp" || true
        mv "${SELECTION_FILE}.tmp" "${SELECTION_FILE}"
    else
        # Add to selection
        echo "${key}" >> "${SELECTION_FILE}"
    fi
}

# Get selection count
get_selection_count() {
    if [ -f "${SELECTION_FILE}" ]; then
        wc -l < "${SELECTION_FILE}" | tr -d ' '
    else
        echo "0"
    fi
}

# Search for games
search_games() {
    local search_term
    search_term=$(dialog --stdout --inputbox "Enter search term:" 10 60)
    
    if [ -z "${search_term}" ]; then
        return
    fi
    
    # Search across all systems
    local results=()
    local options=()
    
    while IFS= read -r system; do
        local games
        games=$(get_games "${system}")
        
        while IFS= read -r game; do
            if echo "${game}" | grep -qi "${search_term}"; then
                local status="[ ]"
                if is_selected "${system}" "${game}"; then
                    status="[X]"
                fi
                
                results+=("${system}|${game}")
                options+=("${system}|${game}" "${status} ${game} (${system})")
            fi
        done <<< "${games}"
    done < <(get_systems)
    
    if [ ${#results[@]} -eq 0 ]; then
        dialog --msgbox "No games found matching '${search_term}'" 8 50
        return
    fi
    
    while true; do
        local choice
        choice=$(dialog --stdout --title "Search Results (${#results[@]} found)" \
            --menu "Select a game to toggle selection (ESC to go back):" 20 70 12 \
            "${options[@]}")
        
        if [ -z "${choice}" ]; then
            break
        fi
        
        IFS='|' read -r sel_system sel_game <<< "${choice}"
        toggle_selection "${sel_system}" "${sel_game}"
        
        # Update the options array with new selection status
        options=()
        for item in "${results[@]}"; do
            IFS='|' read -r sys gam <<< "${item}"
            local status="[ ]"
            if is_selected "${sys}" "${gam}"; then
                status="[X]"
            fi
            options+=("${item}" "${status} ${gam} (${sys})")
        done
    done
}

# Browse games for a specific system
browse_system() {
    local system="$1"
    local system_info
    system_info=$(get_system_info "${system}")
    
    local rom_count
    rom_count=$(echo "${system_info}" | jq -r '.rom_count')
    
    while true; do
        local games
        games=$(get_games "${system}")
        
        local options=()
        while IFS= read -r game; do
            local status="[ ]"
            if is_selected "${system}" "${game}"; then
                status="[X]"
            fi
            options+=("${game}" "${status}")
        done <<< "${games}"
        
        local sel_count
        sel_count=$(get_selection_count)
        
        local choice
        choice=$(dialog --stdout --title "${system} - ${rom_count} ROMs (${sel_count} selected)" \
            --menu "Select a ROM to toggle selection (ESC to go back):" 20 70 12 \
            "${options[@]}")
        
        if [ -z "${choice}" ]; then
            break
        fi
        
        toggle_selection "${system}" "${choice}"
    done
}

# Download selected ROMs
download_selected() {
    local sel_count
    sel_count=$(get_selection_count)
    
    if [ "${sel_count}" -eq 0 ]; then
        dialog --msgbox "No ROMs selected for download." 8 40
        return
    fi
    
    if ! dialog --yesno "Download ${sel_count} selected ROM(s)?" 8 40; then
        return
    fi
    
    # Create progress file
    local progress_file="${TEMP_DIR}/progress.txt"
    echo "0" > "${progress_file}"
    
    # Download in background and show progress
    {
        local current=0
        while IFS='|' read -r system game; do
            current=$((current + 1))
            local percent=$((current * 100 / sel_count))
            
            echo "XXX"
            echo "${percent}"
            echo "Downloading ${game}..."
            echo "XXX"
            
            # Get game info
            local game_info
            game_info=$(get_game_info "${system}" "${game}")
            
            local download_url
            download_url=$(echo "${game_info}" | jq -r '.download_url')
            
            local retropie_dir
            retropie_dir=$(echo "${game_info}" | jq -r ".display_name // \"${system}\"" <<< "$(get_system_info "${system}")" | head -1)
            retropie_dir=$(jq -r ".systems[\"${system}\"].retropie_directory" "${JSON_FILE}")
            
            local target_dir="${BASE_ROM_DIR}/${retropie_dir}"
            mkdir -p "${target_dir}"
            
            # Download the file
            wget -q -O "${target_dir}/${game}" "${download_url}" 2>&1 || {
                echo "Failed to download ${game}" >> "${TEMP_DIR}/errors.log"
            }
            
        done < "${SELECTION_FILE}"
        
        echo "100"
    } | dialog --gauge "Downloading ROMs..." 10 60 0
    
    # Clear selections after successful download
    > "${SELECTION_FILE}"
    
    # Show errors if any
    if [ -f "${TEMP_DIR}/errors.log" ]; then
        dialog --title "Download Errors" --textbox "${TEMP_DIR}/errors.log" 20 70
    else
        dialog --msgbox "Successfully downloaded ${sel_count} ROM(s)!" 8 40
    fi
}

# View selected ROMs
view_selected() {
    local sel_count
    sel_count=$(get_selection_count)
    
    if [ "${sel_count}" -eq 0 ]; then
        dialog --msgbox "No ROMs currently selected." 8 40
        return
    fi
    
    local temp_list="${TEMP_DIR}/selected_list.txt"
    > "${temp_list}"
    
    echo "Currently Selected ROMs (${sel_count}):" >> "${temp_list}"
    echo "======================================" >> "${temp_list}"
    echo "" >> "${temp_list}"
    
    while IFS='|' read -r system game; do
        echo "[${system}] ${game}" >> "${temp_list}"
    done < "${SELECTION_FILE}"
    
    dialog --title "Selected ROMs" --textbox "${temp_list}" 20 70
}

# Main menu
main_menu() {
    while true; do
        local sel_count
        sel_count=$(get_selection_count)
        
        local choice
        choice=$(dialog --stdout --title "RetroPie ROM Downloader" \
            --menu "Main Menu (${sel_count} ROMs selected):" 17 60 8 \
            1 "Browse by System" \
            2 "Search for Games" \
            3 "View Selected ROMs" \
            4 "Download Selected ROMs" \
            5 "Clear All Selections" \
            6 "Update ROM Database" \
            7 "Exit")
        
        case "${choice}" in
            1) system_menu ;;
            2) search_games ;;
            3) view_selected ;;
            4) download_selected ;;
            5) 
                if dialog --yesno "Clear all selections?" 8 40; then
                    > "${SELECTION_FILE}"
                fi
                ;;
            6)
                if dialog --yesno "Download latest ROM database from repository?" 8 50; then
                    download_json
                    if [ $? -eq 0 ]; then
                        dialog --msgbox "ROM database updated successfully!" 8 40
                    else
                        dialog --msgbox "Failed to update ROM database." 8 40
                    fi
                fi
                ;;
            7|"") exit 0 ;;
        esac
    done
}

# System selection menu
system_menu() {
    while true; do
        local systems
        systems=$(get_systems)
        
        local options=()
        while IFS= read -r system; do
            local system_info
            system_info=$(get_system_info "${system}")
            local rom_count
            rom_count=$(echo "${system_info}" | jq -r '.rom_count')
            options+=("${system}" "${rom_count} ROMs")
        done <<< "${systems}"
        
        local choice
        choice=$(dialog --stdout --title "Select System" \
            --menu "Choose a system to browse:" 20 60 12 \
            "${options[@]}")
        
        if [ -z "${choice}" ]; then
            break
        fi
        
        browse_system "${choice}"
    done
}

# Main execution
init
main_menu

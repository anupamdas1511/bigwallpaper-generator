#!/bin/bash

LOG_FILE="./curl_logs.log"
BASE_URL="https://api.unsplash.com/photos/random?orientation=landscape"
URL="$BASE_URL"
ACCESS_KEY="..." # Your Unsplash Own Access Key

# Create a wallpaper directory if not exists
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALLPAPER_DIR"

# Default query and mode
QUERY="nature-black"

# function to set wallpaper based on desktop environment
set_wallpaper() {
    local wallpaper_path=$1
    # GNOME
    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"

    # XFCE (uncomment if using XFCE)
    # xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set "$wallpaper_path"

    # KDE Plasma (uncomment if using KDE Plasma)
    # qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "var allDesktops = desktops(); for (i=0; i<allDesktops.length; i++) { d = allDesktops[i]; d.wallpaperPlugin = 'org.kde.image'; d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General'); d.writeConfig('Image', 'file://$wallpaper_path'); }"

    # feh (for lightweight window managers, uncomment if using feh)
    # feh --bg-scale "$wallpaper_path"
}

# Check for required commands
for cmd in curl jq gsettings; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -q|--query) QUERY="$2"; shift ;;
        -h|--help) 
            echo "Usage: bwall [options]"
            echo "Options:"
            echo "  -q, --query   Search for a specific query (e.g., 'nature', 'city')"
            exit 0 ;;
        *) 
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information."
            exit 1 ;;
    esac
    shift
done

# Replace spaces with hyphens in the query
QUERY="${QUERY// /-}"

# Modify the Unsplash URL based on query or mode
URL="$BASE_URL&query=$QUERY"

# Wallpaper file path
WALLPAPER_PATH="$WALLPAPER_DIR/unsplash_wallpaper.jpg"

# Download the wallpaper
RESPONSE=$(curl --location --request GET "$URL" --header "Authorization: Client-ID $ACCESS_KEY" 2> "$LOG_FILE")
# curl -H "Authorization: Client-ID $ACCESS_KEY" "$URL" -o "$WALLPAPER_PATH"
# echo "$RESPONSE"

# Extract the image URL using jq
IMAGE_URL=$(echo "$RESPONSE" | jq -r ".urls.raw")
# echo "$IMAGE_URL"

# Check if IMAGE_URL is valid
if [[ -z "$IMAGE_URL" ]]; then
    echo "Failed to extract the image URL from the response. Check the logs."
    exit 1
fi

# Download the wallpaper
curl -L "$IMAGE_URL" -o "$WALLPAPER_PATH" 2> "$LOG_FILE"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Wallpaper downloaded successfully to $WALLPAPER_PATH"
    set_wallpaper "$WALLPAPER_PATH"
    echo "Wallpaper has been set successfully."
else
    echo "Failed to download the wallpaper"
    exit 1
fi
#!/bin/sh

echo "Navidrome Sketchybar Plugin Setup"
echo "================================="
echo ""
echo "Choose how to store your Navidrome credentials:"
echo "1) Environment file (~/.navidrome.env) - Simple"
echo "2) macOS Keychain - Most secure"
echo ""
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo ""
        echo "Setting up environment file..."
        read -p "Enter your Navidrome server URL (e.g., http://localhost:4533): " url
        read -p "Enter your Navidrome username: " username
        read -sp "Enter your Navidrome password: " password
        echo ""

        cat > "$HOME/.navidrome.env" << EOF
# Navidrome credentials for Sketchybar plugin
NAVIDROME_URL="$url"
NAVIDROME_USER="$username"
NAVIDROME_PASSWORD="$password"
EOF
        chmod 600 "$HOME/.navidrome.env"
        echo "✓ Created ~/.navidrome.env with restrictive permissions (600)"
        echo ""
        echo "To use this, the plugin will automatically load from ~/.navidrome.env"
        ;;

    2)
        echo ""
        echo "Setting up macOS Keychain..."
        read -p "Enter your Navidrome server URL (e.g., http://localhost:4533): " url
        read -p "Enter your Navidrome username: " username
        read -sp "Enter your Navidrome password: " password
        echo ""

        # Store in Keychain
        security add-generic-password -a "$USER" -s "navidrome-url" -w "$url" 2>/dev/null || \
            security add-generic-password -U -a "$USER" -s "navidrome-url" -w "$url"

        security add-generic-password -a "$USER" -s "navidrome-user" -w "$username" 2>/dev/null || \
            security add-generic-password -U -a "$USER" -s "navidrome-user" -w "$username"

        security add-generic-password -a "$USER" -s "navidrome-password" -w "$password" 2>/dev/null || \
            security add-generic-password -U -a "$USER" -s "navidrome-password" -w "$password"

        echo "✓ Stored credentials in macOS Keychain"
        echo ""
        echo "To use this, uncomment the Keychain lines in navidrome.sh and comment out the .env file lines"
        ;;

    *)
        echo "Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo "Next steps:"
echo "1. Make the plugin executable: chmod +x navidrome.sh"
echo "2. Update your sketchybarrc to use 'navidrome' instead of 'spotify'"
echo "3. Restart sketchybar or reload the configuration"
echo ""
echo "The plugin will show tracks that are currently playing (played within last 3 minutes)"
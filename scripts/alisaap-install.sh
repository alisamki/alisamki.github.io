#!/bin/bash

# Define repository URL and file locations
REPO_URL="https://alisamki.github.io/alisaap"
REPO_FILE="/etc/pacman.d/alisaap.repo"
PACMAN_CONF="/etc/pacman.conf"
REPO_NAME="alisaap"

setup_repo() {
    echo "Downloading and setting up Alisaap repository..."

    # Download the .repo file from the URL
    curl -fsSL $REPO_URL/alisaap.repo -o $REPO_FILE

    if [ $? -eq 0 ]; then
        echo "Repository file downloaded successfully!"
    else
        echo "Failed to download the repository file!"
        exit 1
    fi
}

add_repo_to_pacman_conf() {
    # Check if the repository is already in pacman.conf
    if ! grep -q "^\[$REPO_NAME\]" "$PACMAN_CONF"; then
        echo "Adding $REPO_NAME repository to $PACMAN_CONF"
        
        # Add the repository to pacman.conf
        echo -e "\n[$REPO_NAME]\nInclude = $REPO_FILE" | sudo tee -a "$PACMAN_CONF" > /dev/null
    else
        echo "$REPO_NAME repository is already in $PACMAN_CONF"
    fi
}

update_pacman_db() {
    # Update the pacman database
    echo "Updating pacman database..."
    sudo pacman -Sy
}

main() {
    setup_repo
    add_repo_to_pacman_conf
    update_pacman_db
}

main

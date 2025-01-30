#!/bin/bash

REPO_URL="https://alisamki.github.io/alisaap"
REPO_FILE="/etc/pacman.d/alisaap.repo"

setup_repo() {
    echo "Downloading and setting up Alisaap repository..."
    curl -fsSL $REPO_URL/alisaap.repo -o $REPO_FILE

    if [ $? -eq 0 ]; then
        echo "Repository setup successfully!"
    else
        echo "Failed to setup repository!"
        exit 1
    fi
}

main() {
    setup_repo
}

main
#!/bin/bash
set -e

REPO="Lunarr199/BinCLI"
BINARY="bincli"
INSTALL_DIR="/usr/local/bin"

URL=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" \
  | grep "browser_download_url" \
  | grep "$BINARY-linux-x86_64" \
  | cut -d '"' -f 4)

echo "Downloading $BINARY from $URL"
curl -L "$URL" -o "$BINARY"

chmod +x "$BINARY"
sudo mv "$BINARY" "$INSTALL_DIR"

echo "Installed $BINARY to $INSTALL_DIR"
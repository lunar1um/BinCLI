#!/bin/bash
set -e

BINARY="bincli"
INSTALL_DIR="/usr/local/bin"
TARGET="$INSTALL_DIR/$BINARY"

echo "Checking for old $BINARY installation..."

if [ -f "$TARGET" ]; then
  echo "🗑️  Removing existing $TARGET"
  sudo rm -f "$TARGET"
fi

echo "🔍 Fetching latest release info..."
URL=$(curl -s "https://api.github.com/repos/Lunarr199/BinCLI/releases/latest" \
  | grep "browser_download_url" \
  | grep "$BINARY" \
  | cut -d '"' -f 4)

if [ -z "$URL" ]; then
  echo "❌ Could not find a release asset for '$BINARY'"
  exit 1
fi

echo "⬇️  Downloading from $URL"
curl -L "$URL" -o "$BINARY"

chmod +x "$BINARY"
sudo mv "$BINARY" "$INSTALL_DIR"

echo "✅ Installed $BINARY to $INSTALL_DIR"
#!/usr/bin/env bash
set -e

REPO="Lunarr199/BinCLI"
BINARY="bincli"
ARCH="linux-$(uname -m)"
INSTALL_DIR="/usr/local/bin"

echo "Fetching latest release for $REPO..."

url=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" \
      | grep "browser_download_url" \
      | grep "$ARCH" \
      | cut -d '"' -f 4)

[[ -z "$url" ]] && {
  echo "❌ No download URL found for arch '$ARCH'"
  exit 1
}

echo "⬇️ Downloading from $url"
curl -L "$url" -o "$BINARY"
chmod +x "$BINARY"
sudo mv "$BINARY" "$INSTALL_DIR"

echo "✅ Installed to $INSTALL_DIR/$BINARY"

#!/bin/bash
set -e

BINARY="bincli"
INSTALL_DIR="/usr/local/bin"
TARGET="$INSTALL_DIR/$BINARY"

if [ -f "$TARGET" ]; then
  echo "🗑️  Uninstalling $BINARY from $INSTALL_DIR"
  sudo rm -f "$TARGET"
  echo "✅ $BINARY removed."
else
  echo "ℹ️  $BINARY is not installed in $INSTALL_DIR"
fi
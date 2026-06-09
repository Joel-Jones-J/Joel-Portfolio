#!/usr/bin/env bash
set -e

echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git --depth 1 -b stable _flutter
export PATH="$PATH:$(pwd)/_flutter/bin"

flutter config --enable-web --no-analytics
flutter pub get
flutter build web --release

#!/usr/bin/env bash
# Strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Find the build directory
TARGET_BUILD_DIR="$(xcodebuild -scheme "AppleWatchUIKit WatchKit App" -configuration Debug -showBuildSettings | sed -E -n 's/ *TARGET_BUILD_DIR = //p' | head -n1)"

# Run the build
BUILD_OUTPUT="$(xcodebuild -scheme "AppleWatchUIKit WatchKit App" clean build | tee /dev/stderr)"

# Find the codesign command
CODESIGN_CMD="$(echo $BUILD_OUTPUT | egrep --only-matching '/usr/bin/codesign --force --sign .{40} --entitlements .*?timestamp=none' | head -n1)"

# Copy the framework dylib to the WatchKit app
mkdir "$TARGET_BUILD_DIR/AppleWatchUIKit WatchKit App.app/Frameworks"
cp \
  "$TARGET_BUILD_DIR/AppleWatchUIKitFramework.framework/AppleWatchUIKitFramework" \
  "$TARGET_BUILD_DIR/AppleWatchUIKit WatchKit App.app/Frameworks/AppleWatchUIKitFramework.dylib"

# Point the app to our dylib instead of SockPuppetGizmo
install_name_tool -change \
  "/System/Library/PrivateFrameworks/SockPuppetGizmo.framework/SockPuppetGizmo" \
  "@rpath/AppleWatchUIKitFramework.dylib" \
  "$TARGET_BUILD_DIR/AppleWatchUIKit WatchKit App.app/_WatchKitStub/WK"
install_name_tool -change \
  "/System/Library/PrivateFrameworks/SockPuppetGizmo.framework/SockPuppetGizmo" \
  "@rpath/AppleWatchUIKitFramework.dylib" \
  "$TARGET_BUILD_DIR/AppleWatchUIKit WatchKit App.app/AppleWatchUIKit WatchKit App"

# Sign the dylib and app
eval "$CODESIGN_CMD \"$TARGET_BUILD_DIR/AppleWatchUIKit WatchKit App.app/Frameworks/AppleWatchUIKitFramework.dylib\""
eval "$CODESIGN_CMD \"$TARGET_BUILD_DIR/AppleWatchUIKit WatchKit App.app\""

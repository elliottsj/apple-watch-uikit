# watchkit-uikit

Run UIKit on the Watch! Implemented based on @stroughtonsmith's experiment:
- http://blog.steventroughtonsmith.com/post/128957959685/native-uikit-apps-on-apple-watch
- http://blog.adambell.ca/post/128957319088/making-truly-native-native-apps-on-apple-watch

Check the [react-native branch](https://github.com/elliottsj/watchkit-uikit/tree/react-native) too experiment with React Native. Currently, the app crashes shortly after launch.

## Setup

### Copy iPhoneOS.platform frameworks to WatchOS.platform

```shell
IPHONE_FRAMEWORKS=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks
WATCH_FRAMEWORKS=/Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks

# Back up Frameworks
cp -R $WATCH_FRAMEWORKS/Frameworks $WATCH_FRAMEWORKS/Frameworks.backup
# (Restore Frameworks.backup to develop on WatchKit normally)

# Copy over iPhoneOS.platform frameworks
cp -R \
$IPHONE_FRAMEWORKS/AssetsLibrary.framework \
$IPHONE_FRAMEWORKS/AudioToolbox.framework \
$IPHONE_FRAMEWORKS/AudioUnit.framework \
$IPHONE_FRAMEWORKS/AVFoundation.framework \
$IPHONE_FRAMEWORKS/CoreAudio.framework \
$IPHONE_FRAMEWORKS/CoreMedia.framework \
$IPHONE_FRAMEWORKS/CoreVideo.framework \
$IPHONE_FRAMEWORKS/JavaScriptCore.framework \
$IPHONE_FRAMEWORKS/MediaToolbox.framework \
$IPHONE_FRAMEWORKS/Metal.framework \
$IPHONE_FRAMEWORKS/OpenGLES.framework \
$IPHONE_FRAMEWORKS/Photos.framework \
$IPHONE_FRAMEWORKS/QuartzCore.framework \
$IPHONE_FRAMEWORKS/SystemConfiguration.framework \
$WATCH_FRAMEWORKS
```

TODO: merge UIKit

### Include `armv7k` in .tbd files

TODO

## Building
Every time you build the watch app, you must do the following:

1. Build the **WatchApp** target for _watchOS Device_
2. Copy the resulting framework binary to the iPhone app as `WatchApp.dylib`:

   ```shell
   PRODUCTS_DIR=/Users/spencerelliott/Library/Developer/Xcode/DerivedData/WatchThis-bqkhiaywockvpnciggwtaxdodyze/Build/Products
   cd $PRODUCTS_DIR/Debug-watchos
   cp WatchApp.framework/WatchApp WatchThis\ WatchKit\ App.app/Frameworks/WatchApp.dylib
   ```

3. Rename the dylib path

   ```shell
   install_name_tool -change /System/Library/PrivateFrameworks/SockPuppetGizmo.framework/SockPuppetGizmo @rpath/WatchApp.dylib WatchThis\ WatchKit\ App.app/_WatchKitStub/WK 
   install_name_tool -change /System/Library/PrivateFrameworks/SockPuppetGizmo.framework/SockPuppetGizmo @rpath/WatchApp.dylib WatchThis\ WatchKit\ App.app/WatchThis\ WatchKit\ App
   ```

4. Verify the dylib path

   ```shell
   ❯ otool -l WatchThis\ WatchKit\ App.app/_WatchKitStub/WK | grep "@rpath/WatchApp.dylib"
         name @rpath/WatchApp.dylib (offset 24)
   ❯ otool -l WatchThis\ WatchKit\ App.app/WatchThis\ WatchKit\ App | grep "@rpath/WatchApp.dylib"
         name @rpath/WatchApp.dylib (offset 24)
   ```

5. Sign the app

   Check the Xcode build logs to find your signing identity and entitlements:

   ```shell
   # First sign the dylib
   codesign --force --sign E67C195Axxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --entitlements /Users/spencerelliott/Library/Developer/Xcode/DerivedData/UIKitWatch-bydwboirdlhgnbdcwbobbpbwkpts/Build/Intermediates/UIKitWatch.build/Debug-iphoneos/UIKitWatch.build/UIKitWatch.app.xcent --timestamp=none /Users/spencerelliott/Library/Developer/Xcode/DerivedData/UIKitWatch-bydwboirdlhgnbdcwbobbpbwkpts/Build/Products/Debug-watchos/UIKitWatch\ WatchKit\ App.app/Frameworks/WatchApp.dylib

   # Then sign the app
   codesign --force --sign E67C195Axxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --entitlements /Users/spencerelliott/Library/Developer/Xcode/DerivedData/WatchThis-bqkhiaywockvpnciggwtaxdodyze/Build/Intermediates/WatchThis.build/Debug-iphoneos/WatchThis.build/WatchThis.app.xcent --timestamp=none /Users/spencerelliott/Library/Developer/Xcode/DerivedData/WatchThis-bqkhiaywockvpnciggwtaxdodyze/Build/Products/Debug-watchos/WatchThis\ WatchKit\ App.app/
   ```

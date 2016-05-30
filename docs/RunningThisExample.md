## Running this example
In the [AppleWatchUIKit](/AppleWatchUIKit) directory is an example Xcode project preconfigured to run a UIKit demo for the Apple Watch. To run it, you must patch some framework files in Xcode.app:

### Patch WatchOS.platform frameworks

```bash
# Back up WatchOS.platform frameworks
# (Restore Frameworks.backup to develop on WatchKit normally)
sudo cp -R \
  /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks/ \
  /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks.backup

# Copy Frameworks from iPhoneOS.platform to WatchOS.platform
# ignoring Foundation.tbd and WatchKit.tbd to prevent build errors
sudo rsync --archive --verbose \
  --exclude=Foundation.tbd \
  --exclude=WatchKit.tbd \
  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/ \
  /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks/

# Remove MKMapView.h to prevent a build error
sudo rm /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks/MapKit.framework/Headers/MKMapView.h

# Add 'armv7k' to `archs` arrays in .tbd files
sudo sed -e '/archs:.*armv7k/! s/\(archs:.*\) ]$/\1, armv7k ]/' -i '' /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks/**/*.tbd
```

Then run [build.sh](/AppleWatchUIKit/build.sh) to build the app:
```bash
cd AppleWatchUIKit
./build.sh
```

*build.sh* will build the **AppleWatchUIKit WatchKit App** target normally, then patch the WatchKit app to load the AppleWatchUIKitFramework executable instead of the default SockPuppetGizmo executable. [Check out the source](/AppleWatchUIKit/build.sh) for details.

Finally, run the app without rebuilding:
```bash
open AppleWatchUIKit.xcodeproj
```
Do <kbd>Ctrl</kbd> + <kbd>Cmd</kbd> + <kbd>R</kbd> in Xcode.

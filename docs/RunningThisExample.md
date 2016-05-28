## Running this example


### Patch WatchOS Frameworks
```
# Copy Frameworks from iPhoneOS.platform
sudo rsync --archive --verbose --exclude=Foundation.tbd --exclude=WatchKit.tbd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/ /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks/

sudo rm /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks/MapKit.framework/Headers/MKMapView.h

# Add 'armv7k' to .tbd files
sudo sed -e '/archs:.*armv7k/! s/\(archs:.*\) ]$/\1, armv7k ]/' -i '' /Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/System/Library/Frameworks/**/*.tbd
```

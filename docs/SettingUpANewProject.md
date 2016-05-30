## Setting up a new project
To set up a brand new Xcode project using UIKit on the Apple Watch:

1. Create a new **iOS App with WatchKit App** project:

  ![New Project Type](images/NewProject1.png)

  ![New Project Options](images/NewProject2.png)

  ![New Project Location](images/NewProject3.png)

2. Add a **Watch Framework** target:

  ![New Framework Type](images/NewFramework1.png)

  ![New Framework Options](images/NewFramework2.png)

3. Add **main.m**, **AppDelegate.h**, and **AppDelegate.m** to the new target:

  ![New File...](images/NewFile.png)

  **main.m**:

  ![New File Type](images/Main1.png)

  ![New Objective-C File Options](images/Main2.png)

  ![New Objective-C File Location](images/Main3.png)

  ```objc
  #import <UIKit/UIKit.h>
  #import "AppDelegate.h"

  void __attribute__((constructor)) injected_main()
  {
      @autoreleasepool {
          UIApplicationMain(0, nil, @"UIApplication", NSStringFromClass([AppDelegate class]));
      }
  }

  ```

  **AppDelegate.h**:

  ![New File Type](images/AppDelegateH1.png)

  ![New Header File Location](images/AppDelegateH2.png)

  ```objc
  #import <UIKit/UIKit.h>

  @interface AppDelegate : UIResponder <UIApplicationDelegate>

  @property (strong, nonatomic) UIWindow *window;

  @end
  ```

  **AppDelegate.m**:

  ![New File Type](images/AppDelegateM1.png)

  ![New Objective-C File Options](images/AppDelegateM2.png)

  ![New Objective-C File Location](images/AppDelegateM3.png)

  ```objc
  #import "AppDelegate.h"

  @interface AppDelegate ()

  @end

  @implementation AppDelegate


  - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
  {
      // Initialize `self.window`. See AppleWatchUIKitFramework/AppDelegate.m for an example
      return YES;
  }

  @end

  ```

4. Patch WatchOS frameworks [as described in *Running this example*](RunningThisExample.md#patch-watchos-platform-frameworks).

5. Create a build script to patch the WatchKit app so it loads the framework target's executable. See [AppleWatchUIKit/build.sh](/AppleWatchUIKit/build.sh) for an example.

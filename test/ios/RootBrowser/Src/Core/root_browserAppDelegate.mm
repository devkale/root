#import <cstddef>
#import <cassert>
#import <vector>

#import <sys/sysctl.h>
#import <sys/types.h>

#import "TApplication.h"

#import "FileCollectionViewController.h"
#import "root_browserAppDelegate.h"
#import "Constants.h"


namespace ROOT {
namespace iOS {

bool deviceIsiPad3 = false;

}
}

@implementation root_browserAppDelegate {
   TApplication *rootApp;

   UINavigationController *navigationController;
   __weak FileCollectionViewController *rc;
}

@synthesize window=_window;

//____________________________________________________________________________________________________
- (void) initRootController
{
   UIStoryboard * const storyboard = [UIStoryboard storyboardWithName : @"Browser_iPad" bundle : nil];
   navigationController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier : ROOT::iOS::Browser::ROOTBrowserViewControllerID];
   assert([navigationController.topViewController isKindOfClass : [FileCollectionViewController class]] &&
          "initRootController, top view controller is either nil or has a wrong type");
  
   rc = (FileCollectionViewController *)navigationController.topViewController;

   [self.window setRootViewController : navigationController];
   [self.window makeKeyAndVisible];
}

//____________________________________________________________________________________________________
- (BOOL) application : (UIApplication *)application didFinishLaunchingWithOptions : (NSDictionary *)launchOptions
{
   // Override point for customization after application launch.
   rootApp = new TApplication("iosApp", 0, 0);
   [self initRootController];

   std::size_t dataSize = 0;
   sysctlbyname("hw.machine", nullptr, &dataSize, nullptr, 0);
   if (dataSize) {
      std::vector<char> line(dataSize);
      sysctlbyname("hw.machine", &line[0], &dataSize, nullptr, 0);
      NSString *machineName = [NSString stringWithCString : &line[0] encoding : NSASCIIStringEncoding];
      if ([machineName hasPrefix : @"iPad3,"])
         ROOT::iOS::Browser::deviceIsiPad3 = true;
   }

   return YES;
}

//____________________________________________________________________________________________________
- (void) applicationWillResignActive : (UIApplication *)application
{
   /*
   Sent when the application is about to move from active to inactive state. This can occur for certain 
   types of temporary interruptions (such as an incoming phone call or SMS message) or when the user 
   quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. 
   Games should use this method to pause the game.
   */
}

//____________________________________________________________________________________________________
- (void) applicationDidEnterBackground : (UIApplication *)application
{
   /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application 
   state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: 
   when the user quits.
   */
}

//____________________________________________________________________________________________________
- (void) applicationWillEnterForeground : (UIApplication *)application
{
   /*
   Called as part of the transition from the background to the inactive state;
   here you can undo many of the changes made on entering the background.
   */
}

//____________________________________________________________________________________________________
- (void) applicationDidBecomeActive : (UIApplication *)application
{
   /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. 
   If the application was previously in the background, optionally refresh the user interface.
   */
}

//____________________________________________________________________________________________________
- (void) applicationWillTerminate : (UIApplication *)application
{
   /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

//____________________________________________________________________________________________________
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   while ([navigationController.viewControllers count] > 1)
      [navigationController popViewControllerAnimated : NO];

   [rc addRootFile : [url path]];
   return YES;
}

//____________________________________________________________________________________________________
- (void) dealloc
{
   delete rootApp;
}

@end
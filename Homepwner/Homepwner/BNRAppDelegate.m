//
//  BNRAppDelegate.m
//  Homepwner
//
//  Created by John Russel Usi on 9/29/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"

NSString * const BNRNextItemValuePrefsKey = @"NextItemValue";
NSString * const BNRNextItemNamePrefsKey = @"NextItemName";

@implementation BNRAppDelegate

+ (void)initialize{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSDictionary *factorySettings = @{BNRNextItemValuePrefsKey : @75,
                                    BNRNextItemNamePrefsKey : @"Coffee Cup"};
  [defaults registerDefaults:factorySettings];
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  //  If the state restoration did not occur
  if (!self.window.rootViewController) {
  
  BNRItemsViewController *itemsViewController
  = [[BNRItemsViewController alloc] init];
  // Create an instance of a UINavigationController
  // its stack contains only itemsViewController
  UINavigationController *navController = [[UINavigationController alloc]
                                           initWithRootViewController:itemsViewController];
  
  //  Give the navigation controller a restoration identifier that is
  //  the same name as the class
  navController.restorationIdentifier = NSStringFromClass([navController class]);
  
  // Place navigation controller's view in the window hierarchy
  self.window.rootViewController = navController;
  }
  
  [self.window makeKeyAndVisible];
  return YES;
}

- (UIViewController *)application:(UIApplication *)application
viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
                            coder:(NSCoder *)coder{

  //  Create a new navigation controller
  UIViewController *vc = [[UINavigationController alloc]init];
  
  //  The last object in the path array is the restoration
  //  identifier for this view controller
  vc.restorationIdentifier = [identifierComponents lastObject];
  
  if ([identifierComponents count] == 1) {
    
    //  If there is 1 identifier component
    //  this is the root view controller
    self.window.rootViewController = vc;
  } else {
  
    //  Else it is the navigation controller for a new item,
    //  so you need to set its modal representaion style
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
  }
  
  return vc;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  
  BOOL success = [[BNRItemStore sharedStore]saveChanges];
  if (success) {
    
    NSLog(@"Saved all of the BNRItems");
  } else {
  
    NSLog(@"Could not save any of the BNRItems");
  }
}

- (BOOL)application:(UIApplication *)application
shouldSaveApplicationState:(NSCoder *)coder{

  return YES;
}

- (BOOL)application:(UIApplication *)application
shouldRestoreApplicationState:(NSCoder *)coder{

  return YES;
}

- (BOOL)application:(UIApplication *)application
willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

  self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
  self.window.backgroundColor = [UIColor whiteColor];
  
  return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

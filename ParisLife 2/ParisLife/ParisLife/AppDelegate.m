//
//  AppDelegate.m
//  ParisLifeFinal
//
//  Created by Mohamed Amine Rihane on 2/15/16.
//  Copyright © 2016 ParisLife. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Backendless.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import <AFNetworkActivityIndicatorManager.h>
static NSString *APP_ID = @"F955E07E-E12F-28D3-FF28-645913DA8000";
static NSString *SECRET_KEY = @"38E8FA06-4ADB-5828-FFB6-7539CB287B00";
static NSString *VERSION_NUM = @"v1";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (UIStoryboard *)grabStoryboard {
    
    
    // determine screen size
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIStoryboard *storyboard;
    
    NSLog(@"screenHeight:-%d",screenHeight);

    
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            storyboard = [UIStoryboard storyboardWithName:@"Main-4s" bundle:nil];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 5s
        case 568:
            storyboard = [UIStoryboard storyboardWithName:@"Main-5s" bundle:nil];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 6
        case 667:
            storyboard = [UIStoryboard storyboardWithName:@"Main-6s" bundle:nil];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            // iPhone 6 Plus
        default:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            NSLog(@"screenHeight:-%d",screenHeight);
            break;
            
            
    }
    
    
    
    return storyboard;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    NSLog(@"screenHeight valuesssss :-%d",screenHeight);
    
    
    UIStoryboard *storyboard = [self grabStoryboard];
    
    
    // show the storyboard
    self.window.rootViewController = [storyboard instantiateInitialViewController];

    
   
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [backendless initApp:APP_ID secret:SECRET_KEY version:VERSION_NUM];
    @try {
        [backendless initAppFault];
    }
    @catch (Fault *fault) {
        NSLog(@"didFinishLaunchingWithOptions: %@", fault);
    }
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    // Override point for customization after application launch.
    [FBSDKLoginButton class];
    
    
            [self.window makeKeyAndVisible];
    
    return YES;
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BOOL result = [[FBSDKApplicationDelegate sharedInstance]
                   application:application
                   openURL:url
                   sourceApplication:sourceApplication
                   annotation:annotation];
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    @try {
        NSDictionary *fieldsMapping = @{
                                        @"id" : @"facebookId",
                                        @"name" : @"name",
                                        @"first_name": @"fb_first_name",
                                        @"last_name" : @"fb_last_name",
                                        @"gender": @"gender"
                                        };
        
        BackendlessUser *user = [backendless.userService loginWithFacebookSDK:token fieldsMapping:fieldsMapping];
        NSLog(@"USER: %@", user);
        
       /* UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController *controller = (UIViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"0"];
        [navigationController pushViewController:controller animated:YES];*/
        
        /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        UIViewController *controller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier: @"SWRevealViewController"];
        [(UINavigationController *)self.window.rootViewController pushViewController:controller animated:YES];
        */
        
    }
    @catch (Fault *fault) {
        NSLog(@"openURL: %@", fault);
    }
    return result;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    [FBSDKAppEvents activateApp];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end

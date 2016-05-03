//
//  AppDelegate.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "AppDelegate.h"
#import "CZMainViewController.h"

#import "CZRecipSubListViewController.h"
#import "CZWelcomeViewController.h"
#import "CZTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [userDefaults objectForKey:@"CFBundleShortVersionString"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
 
    if (![dict[@"CFBundleShortVersionString"] isEqualToString:str]) {
        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        
        self.window.rootViewController = [[CZWelcomeViewController alloc]init];
        [self.window makeKeyAndVisible];
        [userDefaults setObject:dict[@"CFBundleShortVersionString"] forKey:@"CFBundleShortVersionString"];
        
    }else{
        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        self.window.rootViewController = [[CZTabBarController alloc]init];
        self.window.tintColor = kColorRGB(159 , 81, 33, 1.0);
        
        [self.window makeKeyAndVisible];
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:@"recipeCache"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *contents = [fm contentsOfDirectoryAtPath:path error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        [fm removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL];
    }
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {


}

@end

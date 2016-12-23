//
//  AppDelegate.m
//  CyhaiUIDemo
//
//  Created by 陈海哥 on 2016/12/23.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "oneViewController.h"
#import "TwoViewController.h"
#import "threeViewController.h"
#import "FourViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    oneViewController * ovc = [[oneViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:ovc];
    nvc.tabBarItem.title = @"one";
    
    TwoViewController * tvc = [[TwoViewController alloc] init];
    UINavigationController * nvc2 = [[UINavigationController alloc] initWithRootViewController:tvc];
    nvc2.tabBarItem.title = @"two";
    
    threeViewController * thvc = [[threeViewController alloc] init];
    UINavigationController * nvc3 = [[UINavigationController alloc] initWithRootViewController:thvc];
    nvc3.tabBarItem.title = @"three";
    
    FourViewController * fvc = [[FourViewController alloc] init];
    UINavigationController * nvc4 = [[UINavigationController alloc] initWithRootViewController:fvc];
    nvc4.tabBarItem.title = @"four";
    
    UITabBarController * tbv = [[UITabBarController alloc] init];
    tbv.viewControllers = @[nvc,nvc2,nvc3,nvc4];
    
    self.window.rootViewController = tbv;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

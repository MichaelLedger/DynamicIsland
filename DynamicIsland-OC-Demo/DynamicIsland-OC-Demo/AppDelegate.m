//
//  AppDelegate.m
//  DynamicIsland-OC-Demo
//
//  Created by Gavin Xiang on 2023/11/22.
//

#import "AppDelegate.h"
#import "DynamicIsland_OC_Demo-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (@available(iOS 16.1, *)) {
            UploadWidgetManager *manager = [UploadWidgetManager shared];
            [manager start];
        }
    });
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    if (@available(iOS 16.1, *)) {
        UploadWidgetManager *manager = [UploadWidgetManager shared];
        [manager end];
    }
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

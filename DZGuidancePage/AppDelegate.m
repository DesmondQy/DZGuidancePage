//
//  AppDelegate.m
//  DZGuidancePage
//
//  Created by 赵卫东 on 2017/5/16.
//  Copyright © 2017年 DZ. All rights reserved.
//

#import "AppDelegate.h"
#import "DZGuidancePageController.h"
#import "DZGuidancePageCell.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"First"]) {//首次打开
        [self starGuidancePageController];
    }else{
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
        self.window.rootViewController = na;
    }
    
    return YES;
}


-(void)starGuidancePageController{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"First"];
    DZGuidancePageController *leadController = [[DZGuidancePageController alloc] initWithPagesCount:3 setupCellHandler:^(DZGuidancePageCell *cell, NSIndexPath *indexPath) {
        // 设置图片
        NSString *imageName = [NSString stringWithFormat:@"d%ld",indexPath.row];
        cell.imageView.image = [UIImage imageNamed:imageName];
        // 设置按钮属性
        [cell.finishBtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [cell.finishBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    } finishHandler:^(UIButton *finishBtn) {
        NSLog(@"点击了完成按钮-----");
    }];
    leadController.mPageControl.pageIndicatorTintColor = [UIColor yellowColor];
    leadController.mPageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    self.window.rootViewController = leadController;
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

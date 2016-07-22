//
//  AppDelegate.m
//  UMTSDemo
//
//  Created by M-SJ076 on 16/7/22.
//  Copyright © 2016年 牛高航. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UMessage.h"



@interface AppDelegate ()<UIAlertViewDelegate>
{
    NSDictionary *_tzStr;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:@"设置 AppKey" launchOptions:launchOptions];
    
    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
    [UMessage registerForRemoteNotifications];
/*
//    如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
     //register remoteNotification types （iOS 8.0及其以上版本）
     UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
     action1.identifier = @"action1_identifier";
     action1.title=@"查看";
     action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
     
     UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
     action2.identifier = @"action2_identifier";
     action2.title=@"删除";
     action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
     action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
     action2.destructive = YES;
     
     UIMutableUserNotificationCategory *actionCategory = [[UIMutableUserNotificationCategory alloc] init];
     actionCategory.identifier = @"category1";//这组动作的唯一标示
     [actionCategory setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
     
     NSSet *categories = [NSSet setWithObject:actionCategory];
     
     //如果默认使用角标，文字和声音全部打开，请用下面的方法
     [UMessage registerForRemoteNotifications:categories];
     
     //如果对角标，文字和声音的取舍，请用下面的方法
     UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    
     UIUserNotificationType types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
    
     [UMessage registerForRemoteNotifications:categories withTypesForIos7:types7 withTypesForIos8:types8];
   
*/
    //for log
    [UMessage setLogEnabled:YES];
    
    
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ViewController *vc=[[ViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController=nav;

    return YES;
}
/*
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
//    查看
    if ([identifier isEqualToString:@"action1_identifier"])
    {
        NSDictionary *content = [userInfo valueForKey:@"aps"];
        NSString *str=[content valueForKey:@"alert"];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"现在去看!" otherButtonTitles:@"等会再说", nil];
        _tzStr=userInfo;
        [alert show];
        [UMessage didReceiveRemoteNotification:userInfo];
    }
     NSLog(@"----%@---%@---",userInfo,identifier);
}
*/

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //[UMessage registerDeviceToken:deviceToken];
    
    NSLog(@"---%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSDictionary *content = [userInfo valueForKey:@"aps"];
    NSString *str=[content valueForKey:@"alert"];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"现在去看!" otherButtonTitles:@"等会再说", nil];
    _tzStr=userInfo;
    [alert show];
    NSString *urlStr = [userInfo valueForKey:@"url"];
    NSLog(@"----%@---%@---%@-",userInfo,str,urlStr);
    [UMessage didReceiveRemoteNotification:userInfo];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  
    switch (buttonIndex)
    {
        case 0:
        {
            NSNotification *notification =[NSNotification notificationWithName:@"TUISONG" object:nil userInfo:_tzStr];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        }
            break;
        case 1:
            
            break;
        default:
            break;
    }
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

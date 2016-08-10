# UMTSDemo
写了一个友盟推送的demo


请先在友盟的消息推送管理后台中创建App，获得AppKey和AppSecret

流程就是 --------->>>>>> http://dev.umeng.com/push/ios/integration

//   关于自定义推送铃声

自定义铃声，把音频文件放到SDK，在友盟推送设置提醒方式为 自定义名字和音频文件名字相同  
**记得带上.MP3


//  关于iOS如何在接收到推送后打开指定页面

1.这个需要用户直接在 didFinishLaunchingWithOptions 和 didReceiveRemoteNotification 这两个方法里面捕获payload内容 自己去实现
2.给payload添加自定义参数。
（1）app在前台或者后台的时候用didReceiveRemoteNotification：


 (2)app未运行状态的时候didFinishLaunchingWithOptions：
NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];   



如果还有问题，请把问题发邮件至453460990@qq.com或者联系QQ:453460990
（在线时间：工作日9：00~18:00）我会尽快回复。
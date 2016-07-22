//
//  ViewController.m
//  UMTSDemo
//
//  Created by M-SJ076 on 16/7/22.
//  Copyright © 2016年 牛高航. All rights reserved.
//

#import "ViewController.h"
#import "IDViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title=@"友盟推送";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"TUISONG" object:nil];
}
- (void)tongzhi:(NSNotification *)text
{
    NSString *urlStr = [text.userInfo valueForKey:@"url"];
    IDViewController *idVC=[[IDViewController alloc]init];
    idVC.URL =urlStr;
    idVC.idtitle=@"梅斯医学";
    [self.navigationController pushViewController:idVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

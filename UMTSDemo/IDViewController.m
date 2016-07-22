//
//  IDViewController.m
//  UMTSDemo
//
//  Created by M-SJ076 on 16/7/22.
//  Copyright © 2016年 牛高航. All rights reserved.
//


//当前的宽高
#define Height_MY    [UIScreen mainScreen].bounds.size.height
#define Width_MY    [UIScreen mainScreen].bounds.size.width

#import "IDViewController.h"

@interface IDViewController ()<UIWebViewDelegate>
{
     UIWebView       *webView;
}

@end

@implementation IDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.title=self.idtitle;
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Width_MY, Height_MY)];
    webView.scalesPageToFit = YES;
    webView.delegate        = self;
    NSString *strUrl=self.URL;
    NSURL *url              = [NSURL URLWithString:strUrl];
    NSURLRequest *request   = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)backVC
{
    if (webView.canGoBack)
    {
        [webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

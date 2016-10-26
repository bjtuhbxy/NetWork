//
//  ViewController.m
//  NetWork
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "YDNetworkCheckView.h"

@interface ViewController ()
{
    YDNetworkCheckView *yd;
}
@property (nonatomic,strong) Reachability *reachability;
@property (nonatomic,strong) UITextField *txRes;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    yd = [[YDNetworkCheckView alloc]init];
#pragma mark 网络诊断按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(120, 480, 80, 30)];
    [btn addTarget:self action:@selector(startCheck) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blueColor];
    btn.layer.cornerRadius = 10;
    [btn setTitle:@"网络诊断" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
#pragma mark 网络诊断的文本输出
    _txRes = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 120, 40)];
//    _txRes.text = @"...";
    [self.view addSubview:_txRes];
    
//    NSURL *urlStr = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *req = [NSURLRequest requestWithURL:urlStr];
//    
//
//    
//    NSData *dataStr = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
////    NSLog(@"%@",dataStr);
//    
}
-(void)startCheck{
    NSString *url = @"http://www.baidu.com";
    NSString *ip = [yd getIPAddressForHost:url];
    NSLog(@"解析后的主机:%@",ip);
    
    _txRes.text = [yd startCheckForHost:url];
    
    NSLog(@"状态%@    %@",[yd startCheckForHost:url],_txRes.text);
    [yd startCheckForHost:url];
    NSLog(@"%i",[yd StatusCodeWithDomainName:url]);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  YDNetworkCheckView.m
//  NetWork
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDNetworkCheckView.h"
#import <netdb.h>
#import <arpa/inet.h>
//#import "Reachability.h"

@implementation YDNetworkCheckView


#pragma mark 域名解析
-(NSString *)getIPAddressForHost:(NSString *)theHost{
    theHost = [theHost substringFromIndex:7];
    NSLog(@"您要解析的域名是:%@",theHost);
    struct hostent *host = gethostbyname([theHost UTF8String]);
    if (!host) {
        herror("resolv");
        return NULL;
    }
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
    
    return addressString;
}
#pragma mark 开始检测网络
-(NSString *)startCheckForHost:(NSString *)domainName{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChanged:) name:kReachabilityChangedNotification object:nil];
    
    //创建网络检测对象
    domainName = [domainName substringFromIndex:7];
    _reachability = [Reachability reachabilityWithHostname:domainName];
    [_reachability startNotifier];
    
#pragma mark 接受返回的通知
    
    
    return _currentNetwork;
}

-(void)netWorkChanged:(NSNotification *)notifi{
    Reachability *obj = [notifi object];
    _currentNetwork = nil;
    if (obj.isReachable) {
        NSLog(@"网络正常");
        switch (obj.currentReachabilityStatus) {
            case ReachableViaWiFi:
                NSLog(@"当前为WIFI网络");
                _currentNetwork = @"WIFI";
                break;
            case ReachableViaWWAN:
                NSLog(@"当前为蜂窝网络");
                _currentNetwork = @"WWAN";
                break;
            case NotReachable:
                NSLog(@"糟糕，断网啦！");
                _currentNetwork = @"ERROR";
            default:
                break;
        }
    }else{
        NSLog(@"网络异常");
        _currentNetwork = @"ERROR";
    }
}
-(BOOL)StatusCodeWithDomainName:(NSString *)urlStr{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"GET"];
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    
    
    NSHTTPURLResponse* urlResponse = nil;
//    NSError *error = [[NSError alloc] init];
    NSError *error = [NSError errorWithDomain:@"domain" code:1001 userInfo:@{
                                                                              NSLocalizedDescriptionKey:@"Localised details here" }];
     error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"指定网站的状态码:%li",[urlResponse statusCode]);
    result = nil;
    if ([urlResponse statusCode] == 200) {
        return true;
    }else{
        return false;
    }
}

@end

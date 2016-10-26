//
//  YDNetworkCheckView.h
//  NetWork
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface YDNetworkCheckView : UIView

@property (nonatomic,strong) Reachability *reachability;

@property (nonatomic,copy) NSString *currentNetwork;


#pragma mark 域名解析
-(NSString *)getIPAddressForHost:(NSString *)theHost;
/*
 此方法为域名解析方法，theHost传入参数格式为完整域名，例："http://www.baidu.com"，传入参数需要带有http://，返回解析到的主机IP，若无法完成解析返回Unknown host。
 */
#pragma mark 开始检测网络
-(NSString *)startCheckForHost:(NSString *)domainName;
/*
 此方法为检测网络状态，domainName传入参数格式为完整域名，例："http://www.baidu.com"，传入参数需要带有http://，返回网络的类型。
 返回值包括：WIFI（当前为WIFI网络）
           ERROR（当前无网络）
           WWAN（当前为蜂窝网络）
 */
#pragma mark 检测指定网络状态码是否为200
-(BOOL)StatusCodeWithDomainName:(NSString *)urlStr;
/*
 此方法为返回指定网站的状态码方法，urlStr传入参数格式为完整域名，例："http://www.baidu.com"，传入参数需要带有http://，返回BOOL类型，真代表200，假代表其他，
 */
@end

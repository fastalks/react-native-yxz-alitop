//
//  RNYXZAlitop.m
//  RNYXZAlitop
//
//  Created by 王发果 on 2018/5/9.
//  Copyright © 2018年 王发果. All rights reserved.
//

#import "RNYXZAlitop.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#ifndef ALIBCTRADEMINISDK
#import "UTMini/AppMonitor.h"
#import<UTMini/AppMonitor.h>
#import <OpenMtopSDK/TBSDKLogUtil.h>
#import <TUnionTradeSDK/TUnionTradeSDK.h>

#endif
#import <AlibabaAuthSDK/albbsdk.h>

@interface RNYXZAlitop ()
@property(nonatomic, strong) loginSuccessCallback loginSuccessCallback;
@property(nonatomic, strong) loginFailureCallback loginFailedCallback;
@end

@implementation RNYXZAlitop
@synthesize _loginSuccessCallback;
@synthesize _loginFailedCallback;

RCT_EXPORT_MODULE();

- (instancetype)init
{
    self = [super init];
    if (self) {
        _loginSuccessCallback=^(ALBBSession *session){
            NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[session getUser]];
            NSLog(@"%@", tip);
        };
        
        _loginFailedCallback=^(ALBBSession *session, NSError *error){
            NSString *tip=[NSString stringWithFormat:@"登录失败:%@",@""];
            NSLog(@"%@", tip);
        };
    }
    return self;
}

RCT_EXPORT_METHOD(login:(NSString *)name) {
    RCTLogInfo(@"%@: %@", name, info);
    
    if(![[ALBBSession sharedInstance] isLogin]){
        [[ALBBSDK sharedInstance] auth:self successCallback:_loginSuccessCallback failureCallback:_loginFailedCallback];
    }else{
        ALBBSession *session = [ALBBSession sharedInstance];
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[[session getUser] ALBBUserDescription]];
        NSLog(@"%@", tip);
    }
}
@end

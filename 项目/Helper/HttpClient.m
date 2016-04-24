//
//  HttpClient.m
//  封装AFN&SDWeb
//
//  Created by 大欢 on 16/3/22.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient ()

@property (nonatomic, strong) AFHTTPSessionManager * manager;

@property (nonatomic, assign) BOOL isConnect;

@end

@implementation HttpClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.manager = [AFHTTPSessionManager manager];
        //设置请求类型
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //设置响应类型
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        
        //开启监听
        [self openNetMonitoring];
        
    }
    return self;
}

- (void)openNetMonitoring {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.isConnect = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.isConnect = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.isConnect = YES;
                break;
            default:
                break;
        }
        
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    self.isConnect = YES;
}

+ (HttpClient *)defaultClient {
    
    static HttpClient * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
            paramenters:(NSDictionary *)params
         prepareExecute:(PrepareExecuteBlock)prepare
                success:(SuccessBlock)success
                failure:(FailureBlock)failure {
    
    NSLog(@"请求网络地址为：%@",url);
    
    if ([self isConnectionAvailable]) {
        
        //预处理
        if (prepare) {
            prepare();
        }
        
        switch (method) {
            case HttpRequestGet:
                [self.manager GET:url parameters:params progress:nil success:success failure:failure];
                break;
            case HttpRequestPost:
                [self.manager POST:url parameters:params progress:nil success:success failure:failure];
                break;
            case HttpRequestPut:
                [self.manager PUT:url parameters:params success:success failure:failure];
                break;
            case HttpRequestDelete:
                [self.manager DELETE:url parameters:params success:success failure:failure];
                break;
            default:
                break;
        }

    } else {
        
        [self showExceptionDialog];
    }
}

- (BOOL)isConnectionAvailable {
    
    return self.isConnect;
}

- (void)showExceptionDialog {
    
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接异常，请检查网络连接" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
}

@end

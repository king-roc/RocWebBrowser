//
//  ViewController.m
//  webkit
//
//  Created by ma c on 16/4/21.
//  Copyright © 2016年 wp. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "RocWebBrowserViewController.h"

static NSString *const defaultAddress = @"https://www.baidu.com";
@interface ViewController ()<RocWebBrowserDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.navigationController.navigationBar.translucent =NO;
    self.navigationController.toolbar.translucent = NO;
    
    UINavigationController *webBrowserNavigationController = [RocWebBrowserViewController navigationControllerWithWebBrowser];
    RocWebBrowserViewController *webBrowser = [webBrowserNavigationController rootWebBrowser];
    [webBrowser setDelegate:self];
    webBrowser.tintColor = [UIColor whiteColor];
    webBrowser.barTintColor = [UIColor colorWithRed:102.0f/255.0f green:204.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
    //webBrowser.showsPageTitleInNavigationBar = YES;
    //webBrowser.showsURLInNavigationBar = YES;
    webBrowser.toolbarHidden=YES;
    [self presentViewController:webBrowserNavigationController animated:YES completion:nil];
    
    [webBrowser loadURLString:defaultAddress];
    
    //push
//    RocWebBrowserViewController *webBrowser = [RocWebBrowserViewController webBrowser];
//    [webBrowser setDelegate:self];
//    [self.navigationController pushViewController:webBrowser animated:YES];
//    [webBrowser loadURLString:defaultAddress];
}

#pragma mark - RocWebBrowserDelegate Protocol Implementation
- (void)webBrowser:(RocWebBrowserViewController *)webBrowser didStartLoadingURL:(NSURL *)URL {
    NSLog(@"Started Loading URL : %@", URL);
}

- (void)webBrowser:(RocWebBrowserViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL {
    NSLog(@"Finished Loading URL : %@", URL);
}

- (void)webBrowser:(RocWebBrowserViewController *)webBrowser didFailToLoadURL:(NSURL *)URL withError:(NSError *)error {
    NSLog(@"Failed To Load URL : %@ With Error: %@", URL, error);
}

- (void)webBrowserViewControllerWillDismiss:(RocWebBrowserViewController*)viewController {
    NSLog(@"View Controller will dismiss: %@", viewController);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

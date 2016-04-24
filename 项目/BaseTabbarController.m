//
//  BaseTabbarController.m
//  自定义tabbar
//


#import "BaseTabbarController.h"
#import "Tabbar.h"
#import "DockItem.h"
#import "BaseNavViewController.h"
@interface BaseTabbarController ()<TabbarDelegate>
@property (nonatomic, strong) NSArray * buttonList;
@property (nonatomic, strong)Tabbar *tabbar;
@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configController];
    [self.tabBar addSubview:self.tabbar];
}
-(Tabbar *)tabbar{
    if (!_tabbar) {
        _tabbar = [[Tabbar alloc] initWithFrame:self.tabBar.bounds];
        _tabbar.delegate = self;
    }
    return _tabbar;
}
-(void)configController{
    NSMutableArray * controllers=[[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < self.buttonList.count; i++) {
        NSDictionary *dict=_buttonList[i];
        UIViewController * vc = [[NSClassFromString(dict[@"name"]) alloc] init];
        UINavigationController * nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
            [controllers addObject:nav];
    }
    self.viewControllers = controllers;
}
- (void)tabbar:(Tabbar *)tabbar selectedAtIndex:(DockItemType)type {
    self.selectedIndex = type;
}

- (NSArray *)buttonList {
    
    if (!_buttonList) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"TabbarList" ofType:@"plist"];
        _buttonList = [NSArray arrayWithContentsOfFile:path];
    }
    return _buttonList;
}

@end

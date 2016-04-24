//
//  ShopController.m
//  项目
//
//  Created by ma c on 16/4/8.
//  Copyright © 2016年 swl. All rights reserved.
//

#import "ShopController.h"
#import "ShopInfoController.h"
@interface ShopController ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIView * Header;
@property (strong, nonatomic) UIScrollView *titleScrollView;
@property (strong, nonatomic) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray * titleNames;
@end

@implementation ShopController
-(UIView *)Header{
    if (!_Header) {
        _Header=[[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 230)];
        _Header.backgroundColor=[UIColor redColor];
    }
    return _Header;
}
-(UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.Header.frame), self.view.bounds.size.width, 30)];
    }
    return _titleScrollView;
}
-(UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), self.view.bounds.size.width, self.view.bounds.size.height)];
        _contentScrollView.delegate=self;
        _contentScrollView.backgroundColor=[UIColor yellowColor];
        _contentScrollView.contentOffset=CGPointMake(self.view.bounds.size.width, 0);
        
    }
    return _contentScrollView;
}
- (NSArray *)titleNames {
    
    if (!_titleNames) {
        _titleNames = @[@"热门",@"价格",@"好评",@"新品"];
    }
    return _titleNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self NavView];
    [self loadData];
    [self.view addSubview:self.titleScrollView];
    [self.view addSubview:self.contentScrollView];
    [self setupChildControllers];
    [self setupTitles];
   
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    [self.view addSubview:self.Header];
}
- (void)setupChildControllers {
    
    for (NSInteger i = 0 ; i < self.titleNames.count; i ++) {
        
        ShopInfoController * newsVC = [[ShopInfoController alloc] init];
        newsVC.title = self.titleNames[i];
        newsVC.index=i;
        [self addChildViewController:newsVC];
    }
    
}
- (void)setupTitles {
    
    CGFloat btnWidth = self.view.bounds.size.width/4;
    CGFloat btnHeight = self.titleScrollView.frame.size.height;
    
    for (NSInteger i = 0; i < self.titleNames.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:self.titleNames[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [self.titleScrollView addSubview:btn];
    }
    self.titleScrollView.contentSize = CGSizeMake(btnWidth * self.titleNames.count, 0);
    self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.titleNames.count, 0);
}
- (void)clickBtn:(UIButton *)button {
    
    NSInteger index = button.tag - 1;
    
    CGPoint point = CGPointMake([UIScreen mainScreen].bounds.size.width * index , 0);
    
    [self.contentScrollView setContentOffset:point animated:YES];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.frame.size.width;
    
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;
    
    UIButton * btn = self.titleScrollView.subviews[index];
    
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    
    titleOffset.x = btn.center.x - width / 2;
    
  
    if (titleOffset.x < 0) {
        
        titleOffset.x = 0;
    }
    
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    
    if (titleOffset.x > maxTitleOffsetX) {
        titleOffset.x = maxTitleOffsetX;
    }
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    UIViewController * childVC = self.childViewControllers[index];
    
    if ([childVC isViewLoaded]) return;
    
    childVC.view.frame = CGRectMake(index*width,-64, width, height);
    
    [scrollView addSubview:childVC.view];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}
-(void)loadData{
    NSDictionary *dict=@{@"ShopId":@"a8ab36ae-c611-43c8-b3de-d51c4bafa24b"};
    NSLog(@"%@",self.shopid);
    [self requestWithPath:@"http://123.57.141.249:8080/beautalk/appShop/appShopGoodsList.do" method:HttpRequestPost paramenters:dict prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
-(void)NavView{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
}
@end

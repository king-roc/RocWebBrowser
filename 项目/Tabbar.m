//
//  Tabbar.m
//  自定义Tabbar
//

//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "Tabbar.h"
#import "DockItem.h"

#define kTag 1000

@interface Tabbar ()

@property (nonatomic, strong) NSArray * buttonList;

@property (nonatomic, strong) DockItem * selectedItem;

@end

@implementation Tabbar

#pragma mark - getters and setters

- (NSArray *)buttonList {
    
    if (!_buttonList) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"TabbarList" ofType:@"plist"];
        _buttonList = [NSArray arrayWithContentsOfFile:path];
    }
    return _buttonList;
}

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = self.bounds.size.width/ self.buttonList.count;
        
        for (int i = 0; i < self.buttonList.count; i++) {
            
            NSDictionary * dict = self.buttonList[i];
            
            DockItem * item = [DockItem buttonWithType:UIButtonTypeCustom];
            
            item.tag = kTag + i;
            
            [item setTitle:dict[@"title"] forState:UIControlStateNormal];
            
            [item setTitleColor:[UIColor colorWithRed:65/255.0f green:201/255.0f blue:175/255.0f alpha:1] forState:UIControlStateSelected];
            [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [item setImage:[UIImage imageNamed:dict[@"normal"]] forState:UIControlStateSelected];
            [item setImage:[UIImage imageNamed:dict[@"selected"]] forState:UIControlStateNormal];
            
            item.frame = CGRectMake(width * i, 0, width, CGRectGetHeight(self.frame));
            
            [item addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        
            [self addSubview:item];
            
            if (i == 0) {
                item.selected = YES;
                self.selectedItem = item;
            }
        }
     
        
        UIView *lineView=[[UIView alloc]init];
        lineView.backgroundColor=[UIColor whiteColor];
        lineView.tag=100;
        lineView.frame=CGRectMake(0, 0, width, 2);
        [self addSubview:lineView];
    }
    return self;
}

#pragma mark - event handler

- (void)doAction:(DockItem *)button {
 
    button.selected = YES;
    self.selectedItem.selected = NO;
    self.selectedItem = button;
    
    if ([self.delegate respondsToSelector:@selector(tabbar:selectedAtIndex:)]) {
        [self.delegate tabbar:self selectedAtIndex:button.tag -kTag];
    }
    [UIView animateWithDuration:0.3 animations:^{
        UIView *lineView=[self viewWithTag:100];
        CGRect frame=lineView.frame;
        frame.origin.x=button.frame.origin.x;
        lineView.frame=frame;
    }];
    if (self.block) {
        self.block(button.tag - kTag);
    }
    
}



@end

//
//  DockItem.m
//  自定义Tabbar
//

//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "DockItem.h"

static CGFloat kImageScale = 0.64;

@implementation DockItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.imageView.contentMode = UIViewContentModeBottom;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat ponitX = 0;
    CGFloat ponitY = 0;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * kImageScale;
    
    return CGRectMake(ponitX, ponitY, width, height);

}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat ponitX = 0;
    CGFloat ponitY = contentRect.size.height * kImageScale;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height * (1 - kImageScale);
    
    return CGRectMake(ponitX, ponitY, width, height);
}












@end

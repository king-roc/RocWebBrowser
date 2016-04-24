//
//  Tabbar.h
//  自定义Tabbar
//

//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DockItemType) {
    DockItemTypeShou,
    DockItemTypeMessage,
    DockItemTypePhone,
    DockItemTypeMine
};

typedef void(^TabbarBlock)(DockItemType type);

@class Tabbar;

@protocol TabbarDelegate <NSObject>

- (void)tabbar:(Tabbar *)tabbar selectedAtIndex:(DockItemType)type;

@end

@interface Tabbar : UIView

@property (nonatomic, weak) id<TabbarDelegate> delegate;

@property (nonatomic, copy) TabbarBlock block;

@end

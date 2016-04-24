//
//  NSString+Helper.h
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Helper)

/**制作一个带删除线的字符串*/
+ (NSMutableAttributedString *)makeStrikethroughAttributedString:(NSString *)frontString :(NSString *)backString;

@end

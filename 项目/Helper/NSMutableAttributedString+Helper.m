//
//  NSString+Helper.m
//  SXT
//
//  Created by 赵金鹏 on 16/4/6.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "NSMutableAttributedString+Helper.h"

@implementation NSMutableAttributedString (Helper)

/**制作一个带删除线的字符串*/
+ (NSMutableAttributedString *)makeStrikethroughAttributedString:(NSString *)frontString :(NSString *)backString{
    NSDictionary * dict = @{NSForegroundColorAttributeName:[UIColor redColor],
                            NSFontAttributeName:[UIFont boldSystemFontOfSize:22]};
    
    NSAttributedString * string1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@ ",frontString] attributes:dict];
    
    NSDictionary * dict2 = @{NSForegroundColorAttributeName:[UIColor grayColor],
                             NSFontAttributeName:[UIFont systemFontOfSize:12],
                             NSStrikethroughStyleAttributeName:@(2)};
    NSAttributedString * string2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",backString] attributes:dict2];
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] init];
    [string insertAttributedString:string1 atIndex:0];
    [string insertAttributedString:string2 atIndex:string1.length];
    
    return string;
}

@end

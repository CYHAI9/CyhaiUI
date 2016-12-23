//
//  mySearchBar.m
//  Runtime
//
//  Created by 陈海哥 on 2016/12/19.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import "mySearchBar.h"

@implementation mySearchBar


- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView * view01 in self.subviews) {
        for (UIView * view02 in view01.subviews) {
            if ([view02 isKindOfClass:[UITextField class]]) {
                UIEdgeInsets Insets = self.searchInsets;
                if (Insets.top!= 0||Insets.left!= 0||Insets.bottom!= 0||Insets.right!= 0) {
                    view02.frame = CGRectMake(Insets.left, Insets.top, self.bounds.size.width - Insets.left - Insets.right, self.bounds.size.height - Insets.top - Insets.bottom);
                }
                else
                {
                    CGFloat top = (self.bounds.size.height - 28.0) / 2.0;
                    CGFloat bottom = top;
                    CGFloat left = 8.0;
                    CGFloat right = left;
                    self.searchInsets = UIEdgeInsetsMake(top, left, bottom, right);
                    view02.frame = CGRectMake(self.searchInsets.left, self.searchInsets.top, self.bounds.size.width - self.searchInsets.left - self.searchInsets.right, self.bounds.size.height - self.searchInsets.top - self.searchInsets.bottom);
                }
            }
        }
    }
}

@end

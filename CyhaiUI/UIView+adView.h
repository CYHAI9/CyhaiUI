//
//  UIView+adView.h
//  Runtime
//
//  Created by 陈海哥 on 2016/12/16.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (adView)<UIScrollViewDelegate>

- (void)setImageArray:(NSArray<UIImage *>*)imagelist Timer:(NSTimeInterval)time TapImageInfo:(void(^)(NSInteger imageindex))imageindex;

@end

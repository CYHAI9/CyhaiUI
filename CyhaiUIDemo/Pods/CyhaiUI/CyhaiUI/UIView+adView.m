//
//  UIView+adView.m
//  Runtime
//
//  Created by 陈海哥 on 2016/12/16.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import "UIView+adView.h"
typedef void(^imageIndexblock)(NSInteger);
@interface adScrollview : UIView

@property (nonatomic , strong)UIScrollView * adScrview;
@property (nonatomic , strong)UIView * BGview;
@property (nonatomic , strong)NSMutableArray * Imagelist;
@property (nonatomic , copy)imageIndexblock ImBlock;
@property (nonatomic , strong)NSTimer * imTimer;

+ (adScrollview *)shareAdscrmanager;

@end


static adScrollview * scrmanager;
@implementation adScrollview

+ (adScrollview *)shareAdscrmanager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        scrmanager = [adScrollview new];
        
    });
    
    return scrmanager;
}

- (NSTimer *)imTimer
{
    if (!_imTimer) {
        _imTimer = [[NSTimer alloc] init];
    }
    
    return _imTimer;
}

- (UIScrollView *)adScrview
{
    if (!_adScrview) {
        _adScrview = [[UIScrollView alloc] init];
        _adScrview.pagingEnabled = YES;
//        _adScrview.bounces = NO;
    }
    
    return _adScrview;
}

- (UIView *)BGview
{
    if (!_BGview) {
        _BGview = [[UIView alloc] init];
    }
    return _BGview;
}

- (NSMutableArray *)Imagelist
{
    if (!_Imagelist) {
        _Imagelist = [NSMutableArray new];
    }
    return _Imagelist;
}

@end

@implementation UIView (adView)

static NSInteger currenPage = 2;
BOOL isFire;
NSTimeInterval mytime;
- (void)setImageArray:(NSArray<UIImage *> *)imagelist Timer:(NSTimeInterval)time TapImageInfo:(void (^)(NSInteger))imageindex
{
    if (!imagelist) {
        
        return;
    }
    else{
        [adScrollview shareAdscrmanager].ImBlock = imageindex;
        
        [[adScrollview shareAdscrmanager].Imagelist addObjectsFromArray:imagelist];
        [[adScrollview shareAdscrmanager].Imagelist insertObject:[imagelist objectAtIndex:0] atIndex:[adScrollview shareAdscrmanager].Imagelist.count];
        [[adScrollview shareAdscrmanager].Imagelist insertObject:[imagelist objectAtIndex:imagelist.count - 1] atIndex:0];
        
        [adScrollview shareAdscrmanager].adScrview.frame = self.frame;
        [adScrollview shareAdscrmanager].adScrview.contentSize = CGSizeMake(self.frame.size.width * [adScrollview shareAdscrmanager].Imagelist.count,0);
        [adScrollview shareAdscrmanager].adScrview.contentOffset = CGPointMake(self.frame.size.width, 0);
        [adScrollview shareAdscrmanager].adScrview.delegate = self;
        [adScrollview shareAdscrmanager].adScrview.showsHorizontalScrollIndicator = NO;
        [adScrollview shareAdscrmanager].adScrview.backgroundColor = [UIColor yellowColor];
        [self addSubview:[adScrollview shareAdscrmanager].adScrview];
        
        [[adScrollview shareAdscrmanager].Imagelist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView * adimageview = [[UIImageView alloc] initWithFrame:CGRectMake(idx * self.frame.size.width,0, [adScrollview shareAdscrmanager].adScrview.frame.size.width, [adScrollview shareAdscrmanager].adScrview.frame.size.height)];
            [adimageview setImage:obj];
            [[adScrollview shareAdscrmanager].adScrview addSubview:adimageview];
            adimageview.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
            adimageview.backgroundColor = [UIColor redColor];
            adimageview.tag = 123 + idx;
            [adimageview addGestureRecognizer:tap];
        }];
        
    }
    
 
    isFire = (time==0?NO:YES);
    if (isFire) {
        mytime = time;
        [adScrollview shareAdscrmanager].imTimer = [NSTimer scheduledTimerWithTimeInterval:time repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            [[adScrollview shareAdscrmanager].adScrview setContentOffset:CGPointMake(currenPage * self.frame.size.width, 0) animated:YES];
            currenPage = [adScrollview shareAdscrmanager].adScrview.contentOffset.x/self.frame.size.width;
            if (currenPage == [adScrollview shareAdscrmanager].Imagelist.count - 1) {
                
                [[adScrollview shareAdscrmanager].adScrview setContentOffset:CGPointMake(self.frame.size.width , 0)];
                currenPage = [adScrollview shareAdscrmanager].adScrview.contentOffset.x/self.frame.size.width;
            }
            currenPage ++;
   }];
    [[NSRunLoop mainRunLoop] addTimer:[adScrollview shareAdscrmanager].imTimer forMode:NSRunLoopCommonModes];
        
    }
 
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [adScrollview shareAdscrmanager].ImBlock?[adScrollview shareAdscrmanager].ImBlock(tap.view.tag - 124):nil;
}

#pragma mark 轮番的判断

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    currenPage = [adScrollview shareAdscrmanager].adScrview.contentOffset.x/self.frame.size.width;
    if (currenPage == [adScrollview shareAdscrmanager].Imagelist.count - 1  ) {
        
        [[adScrollview shareAdscrmanager].adScrview setContentOffset:CGPointMake(self.frame.size.width, 0)];
        currenPage = 1;
        
    }
    else if (currenPage == 0) {
        
        [[adScrollview shareAdscrmanager].adScrview setContentOffset:CGPointMake(self.frame.size.width * ([adScrollview shareAdscrmanager].Imagelist.count - 2),0)];
        currenPage = [adScrollview shareAdscrmanager].Imagelist.count - 2;
    }
    currenPage = [adScrollview shareAdscrmanager].adScrview.contentOffset.x/self.frame.size.width;
 
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [adScrollview shareAdscrmanager].imTimer.isValid?[[adScrollview shareAdscrmanager].imTimer invalidate]:[[adScrollview shareAdscrmanager].imTimer fire];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isFire) {
        [adScrollview shareAdscrmanager].imTimer = [NSTimer scheduledTimerWithTimeInterval:mytime repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            [[adScrollview shareAdscrmanager].adScrview setContentOffset:CGPointMake(currenPage * self.frame.size.width, 0) animated:YES];
            currenPage = [adScrollview shareAdscrmanager].adScrview.contentOffset.x/self.frame.size.width;
            if (currenPage == [adScrollview shareAdscrmanager].Imagelist.count - 1) {
                
                [[adScrollview shareAdscrmanager].adScrview setContentOffset:CGPointMake(self.frame.size.width , 0)];
                currenPage = [adScrollview shareAdscrmanager].adScrview.contentOffset.x/self.frame.size.width;
            }
            currenPage ++;
        }];
        [[NSRunLoop mainRunLoop] addTimer:[adScrollview shareAdscrmanager].imTimer forMode:NSRunLoopCommonModes];
        
    };
}




@end

//
//  TwoViewController.m
//  CyhaiUIDemo
//
//  Created by 陈海哥 on 2016/12/23.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import "TwoViewController.h"
#import <UIView+adView.h>
@interface TwoViewController ()

@end
//
@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)createUI
{
    NSMutableArray * arr = [NSMutableArray new];
    
    UIImage * testimage = [UIImage imageNamed:@"to1.jpg"];
    UIImage * testimage1 = [UIImage imageNamed:@"to2.jpg"];
    UIImage * testimage3 = [UIImage imageNamed:@"to3.jpg"];
    
    [arr addObject:testimage];
    [arr addObject:testimage1];
    [arr addObject:testimage3];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,240)];
    
    [view setImageArray:arr Timer:3.0 TapImageInfo:^(NSInteger imageindex){
        
        NSLog(@"图片下标%ld",imageindex);
        
    }];
    
    [self.view addSubview:view];
    
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

@end

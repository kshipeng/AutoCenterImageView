//
//  ViewController.m
//  AutoCenteImageView
//
//  Created by 康世朋 on 16/9/14.
//  Copyright © 2016年 SP. All rights reserved.
//

#import "ViewController.h"
#import "SPAutoCentreView.h"

@interface ViewController ()<SPAutoCenterViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SPAutoCentreView *view = [[SPAutoCentreView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200) placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    view.dataSource = @[@"",@"",@"",@""];
    view.itemSpacing = 40;
    view.numberOfItemsInLine = 3;
    view.delegate = self;
    [view sp_autoCenterViewDidSelectItemAtIndexPath:^(NSInteger index) {
        NSLog(@"block>>%ld",index);
        
    }];
    [self.view addSubview:view];
}
- (void)sp_autoCenterViewDidSelectItemAtIndexPath:(NSInteger)index {
    NSLog(@"%ld",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

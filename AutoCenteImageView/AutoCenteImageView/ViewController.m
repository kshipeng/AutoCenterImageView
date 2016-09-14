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
    view.dataSource = @[@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage000.jpg",@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage001.jpg",@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage002.jpg",@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage003.jpg"];
    view.itemSpacing = 20;
    view.numberOfItemsInLine = 3;
    view.delegate = self;
    view.itemSize = CGSizeMake(60, 60);
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

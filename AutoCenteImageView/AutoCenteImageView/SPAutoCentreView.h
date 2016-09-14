//
//  SPAutoCentreView.h
//  AutoCentre
//
//  Created by 康世朋 on 16/9/14.
//  Copyright © 2016年 SP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SPAutoCenterViewDelegate <NSObject>
@optional
- (void)sp_autoCenterViewDidSelectItemAtIndexPath:(NSInteger )index;

@end

@interface SPAutoCentreView : UIView
/**
 *  代理
 */
@property (nonatomic, assign) id<SPAutoCenterViewDelegate> delegate;
/**
 *  数据源
 */
@property (nonatomic, retain) NSArray<NSString *> *dataSource;
/**
 *  item大小
 */
@property (nonatomic, assign) CGSize itemSize;
/**
 *  一行显示几个
 */
@property (nonatomic, assign) NSInteger numberOfItemsInLine;
/**
 *  item之间的间距
 */
@property (nonatomic, assign) CGFloat itemSpacing;
/**
 *  初始化方法
 *
 *  @param frame frame
 *  @param image 占位图
 *
 *  @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame placeholderImage:(UIImage *)image;
/**
 *  点击事件获取
 *
 *  @param block 点击事件
 */
- (void)sp_autoCenterViewDidSelectItemAtIndexPath:(void(^)(NSInteger index)) block;

@end

@interface SPCollectionCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *imageView;
@end

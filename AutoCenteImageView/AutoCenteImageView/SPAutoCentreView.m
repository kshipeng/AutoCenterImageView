//
//  SPAutoCentreView.m
//  AutoCentre
//
//  Created by 康世朋 on 16/9/14.
//  Copyright © 2016年 SP. All rights reserved.
//

#import "SPAutoCentreView.h"

#define SPW self.bounds.size.width
#define SPH self.bounds.size.height

@interface SPAutoCentreView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, retain) UICollectionView *mainCollectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) UIEdgeInsets bottomInsets;
@property (nonatomic, assign) NSInteger allSection;
@property (nonatomic,   copy) void(^block)(NSInteger index);
@property (nonatomic, retain) UIImage *placeImage;
@end

@implementation SPAutoCentreView

- (instancetype)initWithFrame:(CGRect)frame placeholderImage:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        
        _insets = UIEdgeInsetsMake(10, 10, 10, 10);
        _itemSize = CGSizeMake(50, 50);
        _numberOfItemsInLine = 5;
        _placeImage = image;
        
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 15.;
        _flowLayout.minimumInteritemSpacing = 10.;
        
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:_flowLayout];
        [_mainCollectionView registerClass:[SPCollectionCell class] forCellWithReuseIdentifier:@"SPCELL"];
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        [self addSubview:_mainCollectionView];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger num = 1;
    if (self.dataSource.count < self.numberOfItemsInLine || self.dataSource.count == self.numberOfItemsInLine) {
        return 1;
    }
    if (self.dataSource.count % self.numberOfItemsInLine == 0) {
        num = self.dataSource.count/self.numberOfItemsInLine;
    }else {
        num = self.dataSource.count/self.numberOfItemsInLine+1;
    }
    _allSection = num;
    return num;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num = 1;
    if (self.dataSource.count < self.numberOfItemsInLine || self.dataSource.count == self.numberOfItemsInLine) {
        return self.dataSource.count;
    }
    if (self.dataSource.count % self.numberOfItemsInLine == 0) {
        num = self.numberOfItemsInLine;
    }else {
        if (section != _allSection -1) {
            num = self.numberOfItemsInLine;
        }else {
            num = self.dataSource.count % self.numberOfItemsInLine;
        }
    }
    return num;
}


#pragma mark - 📚集合视图代理方法
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section != _allSection - 1 || self.dataSource.count % self.numberOfItemsInLine == 0) {
        return self.insets;
    }else {
        return self.bottomInsets;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SPCELL" forIndexPath:indexPath];
    cell.imageView.image = _placeImage;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger indx = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(sp_autoCenterViewDidSelectItemAtIndexPath:)]) {
        if (self.dataSource.count < self.numberOfItemsInLine || self.dataSource.count == self.numberOfItemsInLine) {
            indx = indexPath.row;
        }else {
            indx = indexPath.section * self.numberOfItemsInLine + indexPath.row;
        }

        [_delegate sp_autoCenterViewDidSelectItemAtIndexPath:indx];
    }
    
    if (_block) {
        _block(indx);
    }
}
- (void)sp_autoCenterViewDidSelectItemAtIndexPath:(void (^)(NSInteger))block {
    _block = block;
}
#pragma mark - ⚙一些设置
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self confige];
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    [self confige];
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    _itemSpacing = itemSpacing;
    _flowLayout.minimumInteritemSpacing = itemSpacing;
    [self confige];
}
- (void)setNumberOfItemsInLine:(NSInteger)numberOfItemsInLine {
    _numberOfItemsInLine = numberOfItemsInLine;
    [self confige];
}

- (void)confige {
    CGFloat top = 10, left = 10, bottom = 10, right = 10;
    if (self.dataSource.count < self.numberOfItemsInLine || self.dataSource.count == self.numberOfItemsInLine) {
        left = (SPW - self.itemSize.width*self.dataSource.count - self.itemSpacing *(self.dataSource.count - 1))/2;
        right = left;
    }else if (self.dataSource.count > self.numberOfItemsInLine && self.dataSource.count % self.numberOfItemsInLine == 0){
        left = (SPW - self.itemSize.width*self.numberOfItemsInLine - self.itemSpacing *(self.numberOfItemsInLine - 1))/2;
        right = left;
    }else if (self.dataSource.count > self.numberOfItemsInLine && self.dataSource.count % self.numberOfItemsInLine != 0) {
        left = (SPW - self.itemSize.width*self.numberOfItemsInLine - self.itemSpacing *(self.numberOfItemsInLine - 1))/2;
        right = left;
        
        CGFloat left1 = (SPW - self.itemSize.width*(self.dataSource.count % self.numberOfItemsInLine) - self.itemSpacing *(self.dataSource.count % self.numberOfItemsInLine - 1))/2;
        CGFloat right1 = left1;
        _bottomInsets = UIEdgeInsetsMake(top, left1, bottom, right1);
        
    }
    
    self.insets = UIEdgeInsetsMake(top, left, bottom, right);
    [_mainCollectionView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation SPCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _imageView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

@end

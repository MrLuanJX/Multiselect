//
//  HeaderCollectionView.h
//  申请标签列表多选
//
//  Created by Mr.Luan on 16/1/6.
//  Copyright © 2016年 中邦游. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MLabel.h"

@class HeaderCollectionView;

@protocol HeaderCollectionViewDelegate <NSObject>

@optional
/** 点击全选调用此方法*/
- (void)headerDidClick:(HeaderCollectionView *)header indexPath:(NSIndexPath *)indexPath;

/** 点击展开／合拢调用此方法*/
- (void)headerDidClickZhankaiBtn:(HeaderCollectionView *)header indexPath:(NSIndexPath *)indexPath;
@end

@interface HeaderCollectionView : UICollectionReusableView
@property (nonatomic, weak) id<HeaderCollectionViewDelegate> delegate;
@property (nonatomic, strong) MLabel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

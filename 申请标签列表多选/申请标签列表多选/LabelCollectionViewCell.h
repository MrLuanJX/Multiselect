//
//  LabelCollectionViewCell.h
//  申请标签列表多选
//
//  Created by Mr.Luan on 16/1/6.
//  Copyright © 2016年 中邦游. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MItem.h"

@interface LabelCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) MItem *model;
@end

//
//  MItem.h
//  申请标签列表多选
//
//  Created by Mr.Luan on 16/1/6.
//  Copyright © 2016年 中邦游. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MItem : NSObject
@property (nonatomic, copy) NSString *itemTitle;


@property (nonatomic, assign) BOOL clicked; // 是否选中
@end

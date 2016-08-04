//
//  MLabel.h
//  申请标签列表多选
//
//  Created by Mr.Luan on 16/1/6.
//  Copyright © 2016年 中邦游. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLabel : NSObject

@property (nonatomic , copy) NSString * sectionStr;

@property (nonatomic, copy) NSArray * items;

@property (nonatomic, assign) BOOL allSelected; // 是否全选
@property (nonatomic, assign) BOOL open; // 是否全选
@end

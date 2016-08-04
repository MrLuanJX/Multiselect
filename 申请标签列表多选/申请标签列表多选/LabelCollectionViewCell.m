//
//  LabelCollectionViewCell.m
//  申请标签列表多选
//
//  Created by Mr.Luan on 16/1/6.
//  Copyright © 2016年 中邦游. All rights reserved.
//

#import "LabelCollectionViewCell.h"

@interface LabelCollectionViewCell ()
@property (nonatomic , strong) UILabel * label;
@end

@implementation LabelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];
    }
    return self;
}

- (void)setModel:(MItem *)model {
    _model = model;
    self.label.text = model.itemTitle;
    if (model.clicked) {
        self.label.backgroundColor = [UIColor redColor];
        self.label.textColor = [UIColor whiteColor];
    } else {
        self.label.backgroundColor = [UIColor cyanColor];
        self.label.textColor = [UIColor blackColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

#pragma mark - getter 
- (UILabel *)label {
    if (_label == nil) {
        _label = UILabel.new;
        self.label.layer.cornerRadius = 10.0f;
        self.label.layer.borderWidth = 1.0f;
        self.label.layer.masksToBounds = YES;
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
@end

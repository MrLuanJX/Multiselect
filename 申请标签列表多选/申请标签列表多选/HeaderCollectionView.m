//
//  HeaderCollectionView.m
//  申请标签列表多选
//
//  Created by Mr.Luan on 16/1/6.
//  Copyright © 2016年 中邦游. All rights reserved.
//

#import "HeaderCollectionView.h"

@interface HeaderCollectionView ()
/** */
@property (nonatomic, strong) UIButton *quanxuanBtn;
@property (nonatomic, strong) UIButton *zhankaiBtn;
@end

@implementation HeaderCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.quanxuanBtn];
        [self addSubview:self.zhankaiBtn];
    }
    return self;
}

- (void)setModel:(MLabel *)model {
    _model = model;
    [self.quanxuanBtn setTitle:model.sectionStr forState:UIControlStateNormal];
    if (model.allSelected) {
        self.quanxuanBtn.backgroundColor = [UIColor redColor];
        [self.quanxuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.quanxuanBtn.backgroundColor = [UIColor cyanColor];
        [self.quanxuanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.quanxuanBtn.frame = CGRectMake(10, 10, 60, 20);
    self.zhankaiBtn.frame = CGRectMake(self.bounds.size.width - 80, 10, 60, 20);
}

#pragma mark - event method
- (void)quanxuanBtnClick {
    if ([self.delegate respondsToSelector:@selector(headerDidClick:indexPath:)]) {
        [self.delegate headerDidClick:self indexPath:self.indexPath];
    }
}

- (void)zhankaiBtnClick {
    if ([self.delegate respondsToSelector:@selector(headerDidClickZhankaiBtn:indexPath:)]) {
        [self.delegate headerDidClickZhankaiBtn:self indexPath:self.indexPath];
    }
}

#pragma mark - getter
- (UIButton *)quanxuanBtn {
    if (!_quanxuanBtn) {
        _quanxuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.quanxuanBtn.layer.cornerRadius = 10.0;
        self.quanxuanBtn.layer.borderWidth = 1;
        self.quanxuanBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_quanxuanBtn addTarget:self action:@selector(quanxuanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quanxuanBtn;
}

- (UIButton *)zhankaiBtn {
    if (!_zhankaiBtn) {
        _zhankaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zhankaiBtn setTitle:@"展开/合拢" forState:UIControlStateNormal];
        [_zhankaiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _zhankaiBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _zhankaiBtn.layer.cornerRadius = 10.0;
        _zhankaiBtn.layer.borderWidth = 1;
        _zhankaiBtn.backgroundColor = [UIColor cyanColor];
        [_zhankaiBtn addTarget:self action:@selector(zhankaiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zhankaiBtn;
}
@end

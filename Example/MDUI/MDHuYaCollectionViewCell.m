//
//  MDHuYaCollectionViewCell.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/27.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDHuYaCollectionViewCell.h"

@implementation MDHuYaCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.signLabel];
        [self addSubview:self.signImageView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.signImageView.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    
    self.signLabel.frame = CGRectMake(self.signImageView.frame.size.width, 0, self.frame.size.width / 2.0, self.frame.size.height);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _signLabel.text = title;
}

- (UILabel *)signLabel {
    if (!_signLabel) {
        _signLabel = [[UILabel alloc]init];
    }
    return _signLabel;
}

-(UIImageView *)signImageView {
    if (!_signImageView) {
        _signImageView = [[UIImageView alloc]init];
        
    }
    return _signImageView;
}

@end

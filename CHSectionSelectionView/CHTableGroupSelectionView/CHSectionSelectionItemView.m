//
//  CHSectionSelectionItemView.m
//  CHTableGroupSelectionView
//
//  Created by Clemens Hammerl on 20.11.12.
//  Copyright (c) 2012 Clemens Hammerl. All rights reserved.
//

#import "CHSectionSelectionItemView.h"

@implementation CHSectionSelectionItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        _bgImageView = [[UIImageView alloc] init];
        [_contentView addSubview:_bgImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.highlightedTextColor = [UIColor whiteColor];

        _titleLabel.textAlignment = UITextAlignmentCenter;
        [_contentView addSubview:_titleLabel];
        
    }
    return self;
}

// The following methods should be overriden by your subclass

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    [_titleLabel setHighlighted:highlighted];
    [_bgImageView setHighlighted:highlighted];

}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [self setHighlighted:selected animated:animated];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentView.frame = self.bounds;
    _bgImageView.frame = self.contentView.bounds;
    _titleLabel.frame = self.contentView.bounds;
    
}

@end

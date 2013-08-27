//
//  CHSectionSelectionItemView.m
//  CHTableGroupSelectionView
//
//  Created by Clemens Hammerl on 20.11.12.
//  Copyright (c) 2012 Clemens Hammerl. All rights reserved.
//

#import "CHSectionSelectionItemView.h"

@implementation CHSectionSelectionItemView

- (void) _initializeAttributes
{
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
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    _titleLabel.textAlignment = NSTextAlignmentCenter;
#else
    _titleLabel.textAlignment = UITextAlignmentCenter;
#endif
    
    [_contentView addSubview:_titleLabel];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self _initializeAttributes];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _initializeAttributes];
    }
    return self;
}

- (id)init
{
    self = [super initWithFrame:CGRectZero];
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

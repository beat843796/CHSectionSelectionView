//
//  CHSectionSelectionItemView.h
//  CHTableGroupSelectionView
//
//  Created by Clemens Hammerl on 20.11.12.
//  Copyright (c) 2012 Clemens Hammerl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHSectionSelectionItemView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger section;            // Corresponding section is set by the SectionSelectorView in Reload sections


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;
-(void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end

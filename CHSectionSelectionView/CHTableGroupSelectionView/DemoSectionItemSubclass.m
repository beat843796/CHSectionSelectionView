//
//  DemoSectionItemSubclass.m
//  CHTableGroupSelectionView
//
//  Created by Clemens Hammerl on 20.11.12.
//  Copyright (c) 2012 Clemens Hammerl. All rights reserved.
//

#import "DemoSectionItemSubclass.h"

@implementation DemoSectionItemSubclass

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // Setting a nice BG Image for our sections
        self.bgImageView.image = [UIImage imageNamed:@"sectionItemBG"];

    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // modifying our title labels frame

    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width*0.45, self.bounds.size.height);
    
}


@end

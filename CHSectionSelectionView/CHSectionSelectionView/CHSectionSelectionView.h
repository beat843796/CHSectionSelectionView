//
//  CHSectionSelectionView.h
//  CHTableGroupSelectionView
//
//  Created by Clemens Hammerl on 20.11.12.
//  Copyright (c) 2012 Clemens Hammerl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHSectionSelectionItemView.h"

@class CHSectionSelectionView;
@protocol CHSectionSelectionViewDataSource <NSObject>

-(CHSectionSelectionItemView *)sectionSelectionView:(CHSectionSelectionView *)sectionSelectionView sectionSelectionItemViewForSection:(NSInteger)section;
-(NSInteger)numberOfSectionsInSectionSelectionView:(CHSectionSelectionView *)sectionSelectionView;

@optional
-(UIView *)sectionSelectionView:(CHSectionSelectionView *)sectionSelectionView callOutViewForSelectedSection:(NSInteger)section;


@end

@protocol CHSectionSelectionViewDelegate <NSObject>

@optional
-(void)sectionSelectionView:(CHSectionSelectionView *)sectionSelectionView didSelectSection:(NSInteger)section;

@end

// Show the callout left or right

typedef enum {
    SectionCalloutDirectionLeft,
    SectionCalloutDirectionRight,
}SectionCalloutDirection;

@interface CHSectionSelectionView : UIView
{
    
    __weak id<CHSectionSelectionViewDataSource> dataSource;     // The Data Source
    __weak id<CHSectionSelectionViewDelegate> delegate;         // The Delegate
    
    CGFloat sectionHeight;
    NSMutableArray *sectionViews;                               // Contains all the section views
    NSInteger highlightedSection;                               // index of current highlighted section, -1 if nothing is highlighted
    
    UIView *callOut;                                            // the current shown callout, nil if no callout is shown
}

@property (nonatomic, weak) id<CHSectionSelectionViewDataSource> dataSource;
@property (nonatomic, weak) id<CHSectionSelectionViewDelegate> delegate;
@property (nonatomic, assign) SectionCalloutDirection calloutDirection;         // Defaults to SectionCalloutDirectionRight
@property (nonatomic, assign) BOOL showCallouts;                                // turning callouts of and on. defaults to YES
@property (nonatomic, assign) CGFloat fixedSectionItemHeight;   // can be used to make sure an item has a fixed height, will be ignored if it is 0
@property (nonatomic, assign) CGFloat calloutPadding;           // the space between the callout and the sectionView, defaults to 0
-(void)reloadSections;      // Should be called after initialization, and everytime the corresponding tableview is reloaded

@end

//
//  CHSectionSelectionView.m
//  CHTableGroupSelectionView
//
//  Created by Clemens Hammerl on 20.11.12.
//  Copyright (c) 2012 Clemens Hammerl. All rights reserved.
//

#import "CHSectionSelectionView.h"

@interface CHSectionSelectionView (private)

-(void)layoutSections;
-(void)highlightItemAtSection:(NSInteger)section;
-(void)unhighlightAllSections;
-(void)selectedSection:(NSInteger)selectedSection;

@end

@implementation CHSectionSelectionView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

//////////////////////////////////////////////////////////////////////////
#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        sectionViews = [[NSMutableArray alloc] init];
        
        self.clipsToBounds = NO; // Needed bacause the callouts will live outside our view
        
        // setting some default values
        
        _calloutPadding = 0;
        _fixedSectionItemHeight = 0;
        _showCallouts = YES;
        _calloutDirection = SectionCalloutDirectionRight;
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark - View stuff

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutSections];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods


/*
 Reloads the whole View, asks the datasource for number of sections
 and the corresponding section views. the size of each view must be
 set by the datasource and is not modified here
*/
-(void)reloadSections
{
    for (UIView *sectionView in sectionViews) {
        [sectionView removeFromSuperview];
    }

    [sectionViews removeAllObjects];
    
    NSInteger numberOfSections = 0;
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfSectionsInSectionSelectionView:)]) {
        numberOfSections = [_dataSource numberOfSectionsInSectionSelectionView:self];
    }
    
    for (int section = 0; section < numberOfSections; section++) {
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(sectionSelectionView:sectionSelectionItemViewForSection:)]) {
            CHSectionSelectionItemView *sectionView = [_dataSource sectionSelectionView:self sectionSelectionItemViewForSection:section];
            sectionView.section = section;
            NSLog(@"fetched view");
            
            [sectionViews addObject:sectionView];
            [self addSubview:sectionView];
            
        }
        
    }
    
    [self layoutSections];
}



//////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods

-(void)layoutSections
{


    
    sectionHeight = self.bounds.size.height/(CGFloat)[sectionViews count];

    
    if (_fixedSectionItemHeight > 0) {
        sectionHeight = _fixedSectionItemHeight;
    }
    
    CGFloat yOffset = 0;
    
    for (UIView *sectionView in sectionViews) {
        sectionView.frame = CGRectMake(0, yOffset, self.bounds.size.width, sectionHeight);
        yOffset+=sectionHeight;
    }
}


-(void)selectedSection:(NSInteger)selectedSection
{
    [self highlightItemAtSection:selectedSection];

    if (_showCallouts) {
        if (_dataSource && [_dataSource respondsToSelector:@selector(sectionSelectionView:callOutViewForSelectedSection:)]) {
            
            callOut = [_dataSource sectionSelectionView:self callOutViewForSelectedSection:selectedSection];
            [self addSubview:callOut];
            
            CHSectionSelectionItemView *selectedSectionView = [sectionViews objectAtIndex:selectedSection];

            CGFloat callOutHeight = callOut.frame.size.height;


            CGFloat centerY = selectedSectionView.center.y;
            
            
            if(centerY-callOutHeight/2 < 0) {
                centerY = callOutHeight/2;
            }
            
            if (selectedSectionView.center.y+callOutHeight/2 > sectionHeight*[sectionViews count]) {
                centerY = sectionHeight*[sectionViews count]-callOutHeight/2;
            }
            
            switch (_calloutDirection) {
                case SectionCalloutDirectionLeft:

                    callOut.center = CGPointMake(0-callOut.frame.size.width/2-_calloutPadding, centerY);
                    break;
                case SectionCalloutDirectionRight:

                    callOut.center = CGPointMake(selectedSectionView.frame.size.width+callOut.frame.size.width/2+_calloutPadding, centerY);
                    break;
                default:
                    NSLog(@"Error in CHSectionSelectionView: Unknown Callout Directions");
                    break;
            }

        }
    }

    // Inform the delegate about the selection
    
    if (_delegate && [_delegate respondsToSelector:@selector(sectionSelectionView:didSelectSection:)]) {
        [_delegate sectionSelectionView:self didSelectSection:selectedSection];
    }
    
}


-(void)unhighlightAllSections
{
    
    if (_showCallouts) {
        // Remove the callout if it exists
        [callOut removeFromSuperview];
        callOut = nil;
    }

    for (CHSectionSelectionItemView *sectionView in sectionViews) {
        [sectionView setHighlighted:NO animated:NO];
    }
}

-(void)highlightItemAtSection:(NSInteger)section
{
    
    [self unhighlightAllSections];
    
    CHSectionSelectionItemView *item = [sectionViews objectAtIndex:section];

    [item setHighlighted:YES animated:YES];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark - Touch handling

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    
    for (CHSectionSelectionItemView *sectionView in sectionViews) {
        
        if (CGRectContainsPoint(sectionView.frame, touchPoint)) {
            
            [self selectedSection:sectionView.section];
            highlightedSection = sectionView.section;
            return;
            
        }
        
    }
    
    highlightedSection = -1; // nothing is highlighted
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];

    for (CHSectionSelectionItemView *sectionView in sectionViews) {
        
        if (CGRectContainsPoint(sectionView.frame, touchPoint)) {
            
            // just highlight again if the section has changed
            if (sectionView.section != highlightedSection) {
                [self selectedSection:sectionView.section];
                highlightedSection = sectionView.section;
                
                return;
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesCancelled:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self unhighlightAllSections];
    
    highlightedSection = -1; // nothing is highlighted
}

@end

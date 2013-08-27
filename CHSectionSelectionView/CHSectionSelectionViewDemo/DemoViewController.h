//
//  DemoViewController.h
//  CHTableGroupSelectionView
//
//  Created by Clemens Hammerl on 20.11.12.
//  Copyright (c) 2012 Clemens Hammerl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHSectionSelectionView.h"
#import "DemoSectionItemSubclass.h"
@interface DemoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,CHSectionSelectionViewDataSource, CHSectionSelectionViewDelegate>
{
    NSArray *sections;
    NSArray *cellData;
}

@property (nonatomic, strong) UITableView *testTableView;
@property (nonatomic, strong) CHSectionSelectionView *selectionView;

@end

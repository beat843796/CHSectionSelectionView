//
//  DemoViewController.m
//  CHTableGroupSelectionView
//
//  Created by Clemens Hammerl on 20.11.12.
//  Copyright (c) 2012 Clemens Hammerl. All rights reserved.
//

#import "DemoViewController.h"
#import <QuartzCore/QuartzCore.h>
#define kSectionSelectorWidth 45

@interface DemoViewController ()

@end

@implementation DemoViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        // Lets create some dummy Data
        
        cellData = [NSArray arrayWithObjects:@"Test 1",@"Test 2",@"Test 42",@"Test 5", nil];
        sections = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
        
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark - SectionSelectionView DataSource

// Tell the datasource how many sections we have - best is to forward to the tableviews datasource
-(NSInteger)numberOfSectionsInSectionSelectionView:(CHSectionSelectionView *)sectionSelectionView
{
    return [_testTableView.dataSource numberOfSectionsInTableView:_testTableView];
}

// Create a nice callout view so that you see whats selected when
// your finger covers the sectionSelectionView
-(UIView *)sectionSelectionView:(CHSectionSelectionView *)selectionView callOutViewForSelectedSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    
    label.frame = CGRectMake(0, 0, 80, 80); // you MUST set the size of the callout in this method
    
    // do some ui stuff
    
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor redColor];
    label.font = [UIFont boldSystemFontOfSize:40];
    label.text = [_testTableView.dataSource tableView:_testTableView titleForHeaderInSection:section];
    label.textAlignment = UITextAlignmentCenter;

    // dont use that in your code cause layer shadows are
    // negatively affecting performance
    
    [label.layer setCornerRadius:label.frame.size.width/2];
    [label.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [label.layer setBorderWidth:3.0f];
    [label.layer setShadowColor:[UIColor blackColor].CGColor];
    [label.layer setShadowOpacity:0.8];
    [label.layer setShadowRadius:5.0];
    [label.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    return label;
}


// Create the view that is displayed inside the sectionSelectionView
// This is basically our letter index. CHSectionSelectionItemView subclass
// should be used here. The frame of the view is set by the sectionSelectionView
// it takes its, width and height/numberOfSections for the height
-(CHSectionSelectionItemView *)sectionSelectionView:(CHSectionSelectionView *)selectionView sectionSelectionItemViewForSection:(NSInteger)section
{
    DemoSectionItemSubclass *selectionItem = [[DemoSectionItemSubclass alloc] init];
    
    selectionItem.titleLabel.text = [_testTableView.dataSource tableView:_testTableView titleForHeaderInSection:section];
    selectionItem.titleLabel.font = [UIFont systemFontOfSize:12];
    selectionItem.titleLabel.textColor = [UIColor darkGrayColor];
    selectionItem.titleLabel.highlightedTextColor = [UIColor redColor];
    selectionItem.titleLabel.shadowColor = [UIColor whiteColor];
    selectionItem.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    return selectionItem;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark - SectionSelectionView Delegate

// Jump to the selected section in our tableview
-(void)sectionSelectionView:(CHSectionSelectionView *)sectionSelectionView didSelectSection:(NSInteger)section
{
    [_testTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark - TableView Delegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sections objectAtIndex:section];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark - TableView DataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.contentView.backgroundColor = [UIColor darkGrayColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
    }
    
    cell.textLabel.text = [cellData objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellData count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}


//////////////////////////////////////////////////////////////////////////
#pragma mark - View Stuff

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _testTableView = [[UITableView alloc] init];
    _testTableView.dataSource = self;
    _testTableView.delegate = self;
    [self.view addSubview:_testTableView];
    
    _selectionView = [[CHSectionSelectionView alloc] init];
    _selectionView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
    _selectionView.dataSource = self;
    _selectionView.delegate = self; 
    _selectionView.showCallouts = YES; // the view should show a callout when an item is selected
    _selectionView.calloutDirection = SectionCalloutDirectionRight; // Callouts should appear on the right side
    _selectionView.calloutPadding = 20;
    [self.view addSubview:_selectionView];
    
    _testTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_selectionView reloadSections];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _testTableView.frame = CGRectMake(kSectionSelectorWidth, 0, self.view.bounds.size.width-kSectionSelectorWidth, self.view.bounds.size.height);
    _selectionView.frame = CGRectMake(0, 0, kSectionSelectorWidth, self.view.bounds.size.height);
}


-(BOOL)shouldAutorotate
{
    return YES;
}

@end

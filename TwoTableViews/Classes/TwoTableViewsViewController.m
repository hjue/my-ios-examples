//
//  TwoTableViewsViewController.m
//  TwoTableViews
//
//  Created by Manuel on 16.08.10.
//  Copyright apparatschik 2010. All rights reserved.
//

#import "TwoTableViewsViewController.h"

@implementation TwoTableViewsViewController



/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
     [super loadView];
     isShow = YES;
 }
 

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect frame = [self.view frame];
    CGRect frameLeft = frame;
    CGRect frameRight =frame;
    
    //    frameLeft.origin.x = -100.0;
    frameLeft.size.width = 100;
    frameRight.origin.x = 100.0;
    firstTable.frame = frameLeft;
    
    secondTable.frame = frameRight;
    
    [self.view bringSubviewToFront:secondTable];
    [self.view bringSubviewToFront:firstTable];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if (firstController == nil) {
		firstController = [[FirstTVContoller alloc] init];
	}
	if (secondController == nil) {
		secondController = [[SecondTVController alloc] init];
	}
	[firstTable setDataSource:firstController];
	[secondTable setDataSource:secondController];
	
	[firstTable setDelegate:firstController];
	[secondTable setDelegate:secondController];
	firstController.view = firstController.tableView;
	secondController.view = secondController.tableView;

    UIBarButtonItem *navItem = [[UIBarButtonItem alloc]initWithTitle:@"Toggle" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleView)];
    self.navigationItem.leftBarButtonItem = navItem;
}


- (void) toggleView
{
    if (isShow) {
        CGRect newFrame = firstTable.frame;
        newFrame.size.width = 0;
        
        CGRect secondFrame = secondTable.frame;
        secondFrame.origin.x = 0;
        
//        firstTable.hidden = YES;
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            firstTable.frame = newFrame;
            
            secondTable.frame = secondFrame;
        }
        completion:nil];
  
        isShow = NO;
    }else
    {
        CGRect newFrame = firstTable.frame;
        newFrame.size.width = 100;
        
        CGRect secondFrame = secondTable.frame;
        secondFrame.origin.x = 100;
        
//        firstTable.hidden = YES;
        [UIView animateWithDuration:1.0 animations:^{
            firstTable.frame = newFrame;
            
            secondTable.frame = secondFrame;
        }];
        [self.view bringSubviewToFront:firstTable];
        isShow = YES;
    }
}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[firstController release];
	[secondController release];
	[firstTable release];
	[secondTable release];
    [super dealloc];
}

@end

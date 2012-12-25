//
//  CoreTextViewController.m
//  iPhoneDemos
//
//  Created by haoyu on 12-9-12.
//  Copyright (c) 2012年 haoyu. All rights reserved.
//

#import "CoreTextViewController.h"
#import "CTView.h"

@interface CoreTextViewController ()

@end

@implementation CoreTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    CGRect area = [self.view bounds];
    CTView *view = [[CTView alloc]initWithFrame:area];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"article" ofType:@"txt"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    
    NSAttributedString* attString = [[NSAttributedString alloc]initWithString:text ];
    view.attString = attString;
    [view  buildFrames];
    
    [view  setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

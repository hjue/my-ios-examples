//
//  CSTableViewController.h
//  HuiYiTong
//
//  Created by Yu Hao on 12-7-18.
//  Copyright (c) 2012年 CSDN.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJTableViewController : UITableViewController

@property (nonatomic,retain)  NSDictionary *jsonRoot;
@property (nonatomic,retain)  NSString * targetControllerName;
- (id)initWithJsonFile:(NSString *)jsonFile;

@end

//
//  CTColumnView.h
//  iPhoneDemos
//
//  Created by haoyu on 12-9-13.
//  Copyright (c) 2012年 haoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CTColumnView : UIView {
    id ctFrame;
    NSMutableArray* images;
}

@property (retain, nonatomic) NSMutableArray* images;

-(void)setCTFrame:(id)f;

@end

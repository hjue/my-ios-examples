//
//  CTView.h
//  iPhoneDemos
//
//  Created by haoyu on 12-9-13.
//  Copyright (c) 2012年 haoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "CTColumnView.h"

@interface CTView : UIScrollView<UIScrollViewDelegate>
{
    float frameXOffset;
    float frameYOffset;
}

@property (retain, nonatomic) NSAttributedString* attString;
@property (retain, nonatomic) NSMutableArray* frames;

-(void)buildFrames;
//-(void)attachImagesWithFrame:(CTFrameRef)f inColumnView:(CTColumnView*)col;
@end

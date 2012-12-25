//
//  CTColumnView.m
//  iPhoneDemos
//
//  Created by haoyu on 12-9-13.
//  Copyright (c) 2012年 haoyu. All rights reserved.
//

#import "CTColumnView.h"

@implementation CTColumnView

@synthesize images;

-(id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]!=nil) {
        self.images = [NSMutableArray array];
    }
    return self;
}

-(void)dealloc
{
    self.images= nil;
}

-(void)setCTFrame: (id) f
{
    ctFrame = f;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //翻转坐标,翻转的原因是CoreText的坐标原点是左下角，而UIView的坐标原点是左上角。
    //奇怪的是在iPhone不翻转就看不到文字，估计是NavigationBar影响所致
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameDraw((__bridge CTFrameRef)ctFrame, context);
    
    for (NSArray* imageData in self.images) {
        UIImage* img = [imageData objectAtIndex:0];
        CGRect imgBounds = CGRectFromString([imageData objectAtIndex:1]);
        CGContextDrawImage(context, imgBounds, img.CGImage);
    }
}

@end
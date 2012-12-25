//
//  NSObject+Subscripts.h
//  HuiYiTong
//
//  Created by haoyu on 12-8-3.
//  Copyright (c) 2012年 CSDN.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Subscripts)
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;
- (id)objectForKeyedSubscript:(id)key;
@end

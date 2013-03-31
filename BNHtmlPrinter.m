//
//  BNHtmlPrinter.m
//
//  Created by Brent Nycum.
//  Copyright (c) 2013 Brent Nycum. All rights reserved.
//

#import "BNHtmlPrinter.h"

#define BNRectMake(width, height) CGRectMake(0, 0, width, height)

@interface BNHtmlPrinter ()
- (CGRect)_rectFromPageSize:(BNPageSize)pageSize;
@end

@implementation BNHtmlPrinter

- (CGRect)_rectFromPageSize:(BNPageSize)pageSize {
	return CGRectZero;
}

@end


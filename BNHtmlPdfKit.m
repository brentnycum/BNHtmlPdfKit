//
//  BNHtmlPdfKit.m
//
//  Created by Brent Nycum.
//  Copyright (c) 2013 Brent Nycum. All rights reserved.
//

#import "BNHtmlPdfKit.h"

#define PPI 72
#define BNRectMake(width, height) CGRectMake(0, 0, width * PPI, height * PPI)

@interface BNHtmlPdfKit ()
- (CGRect)_rectFromPageSize:(BNPageSize)pageSize;
@end

@implementation BNHtmlPdfKit

- (CGRect)_rectFromPageSize:(BNPageSize)pageSize {
	switch (pageSize) {
		case BNPageSizeLetter:
			return BNRectMake(8.5f, 11.0f);
		case BNPageSizeGovernmentLetter:
			return BNRectMake(8.0f, 10.5f);
		case BNPageSizeLegal:
			return BNRectMake(8.5f, 14f);
		case BNPageSizeJuniorLegal:
			return BNRectMake(8.5f, 5.0f);
		case BNPageSizeLedger:
			return BNRectMake(17.0f, 11.0f);
		case BNPageSizeTabloid:
			return BNRectMake(11.0f, 17.0f);
		case BNPageSizeA0:
			return BNRectMake(33.11f, 46.81f);
		case BNPageSizeA1:
			return BNRectMake(23.39f, 33.11f);
		case BNPageSizeA2:
			return BNRectMake(16.54f, 23.39f);
		case BNPageSizeA3:
			return BNRectMake(11.69f, 16.54f);
		case BNPageSizeA4:
			return BNRectMake(8.27f, 11.69f);
		case BNPageSizeA5:
			return BNRectMake(5.83f, 8.27f);
		case BNPageSizeA6:
			return BNRectMake(4.13f, 5.83f);
		case BNPageSizeA7:
			return BNRectMake(2.91f, 4.13f);
		case BNPageSizeA8:
			return BNRectMake(2.05f, 2.91f);
		case BNPageSizeA9:
			return BNRectMake(1.46f, 2.05f);
		case BNPageSizeA10:
			return BNRectMake(1.02f, 1.46f);
		case BNPageSizeB0:
			return BNRectMake(39.37f, 55.67f);
		case BNPageSizeB1:
			return BNRectMake(27.83f, 39.37f);
		case BNPageSizeB2:
			return BNRectMake(19.69f, 27.83f);
		case BNPageSizeB3:
			return BNRectMake(13.90f, 19.69f);
		case BNPageSizeB4:
			return BNRectMake(9.84f, 13.90f);
		case BNPageSizeB5:
			return BNRectMake(6.93f, 9.84f);
		case BNPageSizeB6:
			return BNRectMake(4.92f, 6.93f);
		case BNPageSizeB7:
			return BNRectMake(3.46f, 4.92f);
		case BNPageSizeB8:
			return BNRectMake(2.44f, 3.46f);
		case BNPageSizeB9:
			return BNRectMake(1.73f, 2.44f);
		case BNPageSizeB10:
			return BNRectMake(1.22f, 1.73f);
		case BNPageSizeC0:
			return BNRectMake(36.10f, 51.06f);
		case BNPageSizeC1:
			return BNRectMake(25.51f, 36.10f);
		case BNPageSizeC2:
			return BNRectMake(18.03f, 25.51f);
		case BNPageSizeC3:
			return BNRectMake(12.76f, 18.03f);
		case BNPageSizeC4:
			return BNRectMake(9.02f, 12.76f);
		case BNPageSizeC5:
			return BNRectMake(6.38f, 9.02f);
		case BNPageSizeC6:
			return BNRectMake(4.49f, 6.38f);
		case BNPageSizeC7:
			return BNRectMake(3.19f, 4.49f);
		case BNPageSizeC8:
			return BNRectMake(2.24f, 3.19f);
		case BNPageSizeC9:
			return BNRectMake(1.57f, 2.24f);
		case BNPageSizeC10:
			return BNRectMake(1.10f, 1.57f);
		case BNPageSizeJapaneseB0:
			return BNRectMake(40.55f, 57.32f);
		case BNPageSizeJapaneseB1:
			return BNRectMake(28.66f, 40.55f);
		case BNPageSizeJapaneseB2:
			return BNRectMake(20.28f, 28.66f);
		case BNPageSizeJapaneseB3:
			return BNRectMake(14.33f, 20.28f);
		case BNPageSizeJapaneseB4:
			return BNRectMake(10.12f, 14.33f);
		case BNPageSizeJapaneseB5:
			return BNRectMake(7.17f, 10.12f);
		case BNPageSizeJapaneseB6:
			return BNRectMake(5.04f, 7.17f);
		case BNPageSizeJapaneseB7:
			return BNRectMake(3.58f, 5.04f);
		case BNPageSizeJapaneseB8:
			return BNRectMake(2.52f, 3.58f);
		case BNPageSizeJapaneseB9:
			return BNRectMake(1.77f, 2.52f);
		case BNPageSizeJapaneseB10:
			return BNRectMake(1.26f, 1.77f);
		case BNPageSizeJapaneseB11:
			return BNRectMake(0.87f, 1.26f);
		case BNPageSizeJapaneseB12:
			return BNRectMake(0.63f, 0.87f);
		case BNPageSizeCustom:
			return CGRectZero;
	}
	return CGRectZero;
}

@end


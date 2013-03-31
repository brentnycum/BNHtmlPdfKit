//
//  BNHtmlPdfKit.h
//
//  Created by Brent Nycum.
//  Copyright (c) 2013 Brent Nycum. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://en.wikipedia.org/wiki/Paper_size
typedef enum {
	BNPageSizeLetter,
	BNPageSizeGovernmentLetter,
	BNPageSizeLegal,
	BNPageSizeJuniorLegal,
	BNPageSizeLedger,
	BNPageSizeTabloid,
	BNPageSizeA0,
	BNPageSizeA1,
	BNPageSizeA2,
	BNPageSizeA3,
	BNPageSizeA4,
	BNPageSizeA5,
	BNPageSizeA6,
	BNPageSizeA7,
	BNPageSizeA8,
	BNPageSizeA9,
	BNPageSizeA10,
	BNPageSizeB0,
	BNPageSizeB1,
	BNPageSizeB2,
	BNPageSizeB3,
	BNPageSizeB4,
	BNPageSizeB5,
	BNPageSizeB6,
	BNPageSizeB7,
	BNPageSizeB8,
	BNPageSizeB9,
	BNPageSizeB10,
	BNPageSizeC0,
	BNPageSizeC1,
	BNPageSizeC2,
	BNPageSizeC3,
	BNPageSizeC4,
	BNPageSizeC5,
	BNPageSizeC6,
	BNPageSizeC7,
	BNPageSizeC8,
	BNPageSizeC9,
	BNPageSizeC10,
	BNPageSizeJapaneseB0,
	BNPageSizeJapaneseB1,
	BNPageSizeJapaneseB2,
	BNPageSizeJapaneseB3,
	BNPageSizeJapaneseB4,
	BNPageSizeJapaneseB5,
	BNPageSizeJapaneseB6,
	BNPageSizeJapaneseB7,
	BNPageSizeJapaneseB8,
	BNPageSizeJapaneseB9,
	BNPageSizeJapaneseB10,
	BNPageSizeJapaneseB11,
	BNPageSizeJapaneseB12,
	BNPageSizeCustom
} BNPageSize;

@interface BNHtmlPdfKit : NSObject

/**
The paper size of the generated PDF.
*/
@property (nonatomic, assign) BNPageSize pageSize;

@end;

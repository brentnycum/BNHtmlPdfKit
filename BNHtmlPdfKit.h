//
//  BNHtmlPdfKit.h
//
//  Created by Brent Nycum.
//  Copyright (c) 2013 Brent Nycum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@protocol BNHtmlPdfKitDelegate;

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

/**
Custom page size.
*/
@property (nonatomic, assign) CGSize customPageSize;

/**
Is page landscape?
*/
@property (nonatomic, assign, getter=isLandscape) BOOL landscape;

/**
Top and Bottom page margins.
*/
@property (nonatomic, assign) CGFloat topAndBottomMarginSize;

/**
Left and Right page margins.
*/
@property (nonatomic, assign) CGFloat leftAndRightMarginSize;

/**
Base URL to use.
*/
@property (nonatomic, retain) NSURL *baseUrl;

/**
 The receiver's `delegate`.

 The `delegate` is sent messages when content is loading.
 */
@property (nonatomic, assign) id<BNHtmlPdfKitDelegate> delegate;

/**
Creates a BNHtmlPdfKit object to save a URL as PDF.

@param url URL to save PDF of.
@param completion Block to be notified when PDF data is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url success:(void (^)(NSData *pdfData))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as PDF with BNPageSize.

@param url URL to save PDF of.
@param pageSize BNPageSize of the page to be generated.
@param completion Block to be notified when PDF data is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url pageSize:(BNPageSize)pageSize success:(void (^)(NSData *pdfData))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as PDF with BNPageSize and if in landscape.

@param url URL to save PDF of.
@param pageSize BNPageSize of the page to be generated.
@param landscape Should the page be landscape.
@param completion Block to be notified when PDF data is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url pageSize:(BNPageSize)pageSize isLandscape:(BOOL)landscape success:(void (^)(NSData *pdfData))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as PDF with BNPageSize, landscape orientation, and margin sizes.

@param url URL to save PDF of.
@param pageSize BNPageSize of the page to be generated.
@param landscape Should the page be landscape.
@param topAndBottom Top and bottom margin size.
@param leftAndRight Left and right margin size.
@param completion Block to be notified when PDF data is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url pageSize:(BNPageSize)pageSize isLandscape:(BOOL)landscape topAndBottomMarginSize:(CGFloat)topAndBottom leftAndRightMarginSize:(CGFloat)leftAndRight success:(void (^)(NSData *pdfData))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as a PDF file.

@param url URL to save PDF of.
@param completion Block to be notified when PDF file is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url toFile:(NSString *)filename success:(void (^)(NSString *filename))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as a PDF file with BNPageSize.

@param url URL to save PDF of.
@param filename Filename to save file as.
@param pageSize BNPageSize of the page to be generated.
@param completion Block to be notified when PDF file is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url toFile:(NSString *)filename pageSize:(BNPageSize)pageSize success:(void (^)(NSString *filename))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as a PDF file with BNPageSize, and landscape orientation.

@param url URL to save PDF of.
@param filename Filename to save file as.
@param pageSize BNPageSize of the page to be generated.
@param landscape Should the page be landscape.
@param completion Block to be notified when PDF file is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url toFile:(NSString *)filename pageSize:(BNPageSize)pageSize isLandscape:(BOOL)landscape success:(void (^)(NSString *filename))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as a PDF file with BNPageSize, landscape orientation, and margin sizes.

@param url URL to save PDF of.
@param pageSize BNPageSize of the page to be generated.
@param landscape Should the page be landscape.
@param topAndBottom Top and bottom margin size.
@param leftAndRight Left and right margin size.
@param completion Block to be notified when PDF file is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url toFile:(NSString *)filename pageSize:(BNPageSize)pageSize isLandscape:(BOOL)landscape topAndBottomMarginSize:(CGFloat)topAndBottom leftAndRightMarginSize:(CGFloat)leftAndRight success:(void (^)(NSString *filename))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as PDF with custom page size..

@param url URL to save PDF of.
@param pageSize CGSize of the page to be generated.
@param completion Block to be notified when PDF file is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url customPageSize:(CGSize)pageSize success:(void (^)(NSData *pdfData))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as PDF with custom page size.

@param url URL to save PDF of.
@param pageSize CGSize of the page to be generated.
@param topAndBottom Top and bottom margin size.
@param leftAndRight Left and right margin size.
@param completion Block to be notified when PDF data is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url customPageSize:(CGSize)pageSize topAndBottomMarginSize:(CGFloat)topAndBottom leftAndRightMarginSize:(CGFloat)leftAndRight success:(void (^)(NSData *pdfData))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as PDF with custom page size.

@param url URL to save PDF of.
@param filename Filename to save file as.
@param pageSize CGSize of the page to be generated.
@param completion Block to be notified when PDF data is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url toFile:(NSString *)filename customPageSize:(CGSize)pageSize success:(void (^)(NSString *filename))completion failure:(void (^)(NSError *error))failure;

/**
Creates a BNHtmlPdfKit object to save a URL as PDF with BNPageSize.

@param url URL to save PDF of.
@param filename Filename to save file as.
@param pageSize CGSize of the page to be generated.
@param topAndBottom Top and bottom margin size.
@param leftAndRight Left and right margin size.
@param completion Block to be notified when PDF file is generated.
@param failure Block to be notified of failure.
*/
+ (BNHtmlPdfKit *)saveUrlAsPdf:(NSURL *)url toFile:(NSString *)filename customPageSize:(CGSize)pageSize topAndBottomMarginSize:(CGFloat)topAndBottom leftAndRightMarginSize:(CGFloat)leftAndRight success:(void (^)(NSString *filename))completion failure:(void (^)(NSError *error))failure;


/**
Initializes BNHtmlPdfKit with a BNPageSize.

@param pageSize The page size the output should be at.

@return An initialized `BNHtmlPdfKit` object.
*/
- (id)initWithPageSize:(BNPageSize)pageSize;

/**
Initializes BNHtmlPdfKit with a BNPageSize.

@param pageSize The page size the output should be at.
@param landscape Should the page be printed in landscape?

@return An initialized `BNHtmlPdfKit` object.
*/
- (id)initWithPageSize:(BNPageSize)pageSize isLandscape:(BOOL)landscape;

/**
Initializes BNHtmlPdfKit with a custom page size.

@param pageSize The page size the output should be at.

@return An initialized `BNHtmlPdfKit` object.
*/
- (id)initWithCustomPageSize:(CGSize)pageSize;

/**
Get a CGSize of what the BNPageSize represents.

@param pageSize Page Size to get the CGSize of.
*/
+ (CGSize)sizeForPageSize:(BNPageSize)pageSize;

/**
The size of the paper to print on.
*/
- (CGSize)actualPageSize;

/**
Saves an html string to PDF data.

@param html The HTML to save as a pdf.
*/
- (void)saveHtmlAsPdf:(NSString *)html;


/**
Saves an html string to a PDF file.

@param html The HTML to save as a pdf file.
@param file The filename of the pdf file to save.
*/
- (void)saveHtmlAsPdf:(NSString *)html toFile:(NSString *)file;

/**
Saves an html string to PDF data.

@param url The URL to save as a pdf.
*/
- (void)saveUrlAsPdf:(NSURL *)url;


/**
Saves an html string to a PDF file.

@param url The URL to save as a pdf file.
@param file The filename of the pdf file to save.
*/
- (void)saveUrlAsPdf:(NSURL *)url toFile:(NSString *)file;

/**
Saves an webView to PDF data.

@param webView The webView to save as a pdf.
*/
- (void)saveWebViewAsPdf:(WKWebView *)webView;

/**
Saves webView content to a PDF file.

@param webView The webView to save as a pdf file.
@param file The filename of the pdf file to save.
*/
- (void)saveWebViewAsPdf:(WKWebView *)webView toFile:(NSString *)file;

/**
Determine the preferred paper size for general printing. From Pierre Bernard.

@return paper size (currently: A4 or Letter).
*/
+ (BNPageSize)defaultPageSize;

@end;


/**
The `BNHtmlPdfKitDelegate` protocol defines methods that a delegate of a `BNHtmlPdfKit` object that provides feedback
based on the operations being performed.
*/
@protocol BNHtmlPdfKitDelegate <NSObject>

@optional

/**
Sent when pdf data has been generated.

@param htmlPdfKit The `BNHtmlPdfKit` that data is being saved from.
@param data The PDF data that was created from HTML/URL.
*/
- (void)htmlPdfKit:(BNHtmlPdfKit *)htmlPdfKit didSavePdfData:(NSData *)data;

/**
Sent when pdf data has been generated.

@param htmlPdfKit The `BNHtmlPdfKit` that data is being saved from.
*/
- (void)htmlPdfKit:(BNHtmlPdfKit *)htmlPdfKit didSavePdfFile:(NSString *)file;

/**
Sent when there was an error trying to generate the PDF.

@param htmlPdfKit The `BNHtmlPdfKit` that theerror generated from.
*/
- (void)htmlPdfKit:(BNHtmlPdfKit *)htmlPdfKit didFailWithError:(NSError *)error;

@end;

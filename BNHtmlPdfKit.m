//
//  BNHtmlPdfKit.m
//
//  Created by Brent Nycum.
//  Copyright (c) 2013 Brent Nycum. All rights reserved.
//

#import "BNHtmlPdfKit.h"

#define PPI 72
#define BNSizeMakeWithPPI(width, height) CGSizeMake(width * PPI, height * PPI)


#pragma mark - BNHtmlPdfKitPageRenderer Interface

@interface BNHtmlPdfKitPageRenderer : UIPrintPageRenderer

@property (nonatomic, assign) CGFloat topAndBottomMarginSize;
@property (nonatomic, assign) CGFloat leftAndRightMarginSize;

@end


#pragma mark - BNHtmlPdfKitPageRenderer Implementation

@implementation BNHtmlPdfKitPageRenderer

- (CGRect)paperRect {
	return UIGraphicsGetPDFContextBounds();
}

- (CGRect)printableRect {
	return CGRectInset([self paperRect], self.leftAndRightMarginSize, self.topAndBottomMarginSize);
}

@end


#pragma mark - BNHtmlPdfKit Extension

@interface BNHtmlPdfKit () <UIWebViewDelegate>

- (CGSize)_sizeFromPageSize:(BNPageSize)pageSize;

- (void)_timeout;
- (void)_savePdf;

@property (nonatomic, copy) NSString *outputFile;
@property (nonatomic, strong) UIWebView *webView;

@end

#pragma mark - BNHtmlPdfKit Implementation

@implementation BNHtmlPdfKit

#pragma mark - Initializers

- (id)init {
	if (self = [super init]) {
		self.pageSize = [BNHtmlPdfKit defaultPageSize];
		self.landscape = NO;

		// Default 1/4" margins
		self.topAndBottomMarginSize = 0.25f * 72.0f;
		self.leftAndRightMarginSize = 0.25f * 72.0f;
	}
	return self;
}

- (id)initWithPageSize:(BNPageSize)pageSize {
	if (self = [super init]) {
		self.pageSize = pageSize;
		self.landscape = NO;

		// Default 1/4" margins
		self.topAndBottomMarginSize = 0.25f * 72.0f;
		self.leftAndRightMarginSize = 0.25f * 72.0f;
	}
	return self;
}

- (id)initWithPageSize:(BNPageSize)pageSize isLandscape:(BOOL)landscape {
	if (self = [super init]) {
		self.pageSize = pageSize;
		self.landscape = landscape;

		// Default 1/4" margins
		self.topAndBottomMarginSize = 0.25f * 72.0f;
		self.leftAndRightMarginSize = 0.25f * 72.0f;
	}
	return self;
}

- (id)initWithCustomPageSize:(CGSize)pageSize {
	if (self = [super init]) {
		self.pageSize = BNPageSizeCustom;
		self.customPageSize = pageSize;
		self.landscape = NO;

		// Default 1/4" margins
		self.topAndBottomMarginSize = 0.25f * 72.0f;
		self.leftAndRightMarginSize = 0.25f * 72.0f;
	}
	return self;
}

- (void)dealloc {
	[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeout) object:nil];

	[self.webView setDelegate:nil];
	[self.webView stopLoading];
}

#pragma mark - Class Methods

+ (CGSize)sizeForPageSize:(BNPageSize)pageSize {
	switch (pageSize) {
		case BNPageSizeLetter:
			return BNSizeMakeWithPPI(8.5f, 11.0f);
		case BNPageSizeGovernmentLetter:
			return BNSizeMakeWithPPI(8.0f, 10.5f);
		case BNPageSizeLegal:
			return BNSizeMakeWithPPI(8.5f, 14.0f);
		case BNPageSizeJuniorLegal:
			return BNSizeMakeWithPPI(8.5f, 5.0f);
		case BNPageSizeLedger:
			return BNSizeMakeWithPPI(17.0f, 11.0f);
		case BNPageSizeTabloid:
			return BNSizeMakeWithPPI(11.0f, 17.0f);
		case BNPageSizeA0:
			return BNSizeMakeWithPPI(33.11f, 46.81f);
		case BNPageSizeA1:
			return BNSizeMakeWithPPI(23.39f, 33.11f);
		case BNPageSizeA2:
			return BNSizeMakeWithPPI(16.54f, 23.39f);
		case BNPageSizeA3:
			return BNSizeMakeWithPPI(11.69f, 16.54f);
		case BNPageSizeA4:
			return BNSizeMakeWithPPI(8.26666667, 11.6916667);
		case BNPageSizeA5:
			return BNSizeMakeWithPPI(5.83f, 8.27f);
		case BNPageSizeA6:
			return BNSizeMakeWithPPI(4.13f, 5.83f);
		case BNPageSizeA7:
			return BNSizeMakeWithPPI(2.91f, 4.13f);
		case BNPageSizeA8:
			return BNSizeMakeWithPPI(2.05f, 2.91f);
		case BNPageSizeA9:
			return BNSizeMakeWithPPI(1.46f, 2.05f);
		case BNPageSizeA10:
			return BNSizeMakeWithPPI(1.02f, 1.46f);
		case BNPageSizeB0:
			return BNSizeMakeWithPPI(39.37f, 55.67f);
		case BNPageSizeB1:
			return BNSizeMakeWithPPI(27.83f, 39.37f);
		case BNPageSizeB2:
			return BNSizeMakeWithPPI(19.69f, 27.83f);
		case BNPageSizeB3:
			return BNSizeMakeWithPPI(13.90f, 19.69f);
		case BNPageSizeB4:
			return BNSizeMakeWithPPI(9.84f, 13.90f);
		case BNPageSizeB5:
			return BNSizeMakeWithPPI(6.93f, 9.84f);
		case BNPageSizeB6:
			return BNSizeMakeWithPPI(4.92f, 6.93f);
		case BNPageSizeB7:
			return BNSizeMakeWithPPI(3.46f, 4.92f);
		case BNPageSizeB8:
			return BNSizeMakeWithPPI(2.44f, 3.46f);
		case BNPageSizeB9:
			return BNSizeMakeWithPPI(1.73f, 2.44f);
		case BNPageSizeB10:
			return BNSizeMakeWithPPI(1.22f, 1.73f);
		case BNPageSizeC0:
			return BNSizeMakeWithPPI(36.10f, 51.06f);
		case BNPageSizeC1:
			return BNSizeMakeWithPPI(25.51f, 36.10f);
		case BNPageSizeC2:
			return BNSizeMakeWithPPI(18.03f, 25.51f);
		case BNPageSizeC3:
			return BNSizeMakeWithPPI(12.76f, 18.03f);
		case BNPageSizeC4:
			return BNSizeMakeWithPPI(9.02f, 12.76f);
		case BNPageSizeC5:
			return BNSizeMakeWithPPI(6.38f, 9.02f);
		case BNPageSizeC6:
			return BNSizeMakeWithPPI(4.49f, 6.38f);
		case BNPageSizeC7:
			return BNSizeMakeWithPPI(3.19f, 4.49f);
		case BNPageSizeC8:
			return BNSizeMakeWithPPI(2.24f, 3.19f);
		case BNPageSizeC9:
			return BNSizeMakeWithPPI(1.57f, 2.24f);
		case BNPageSizeC10:
			return BNSizeMakeWithPPI(1.10f, 1.57f);
		case BNPageSizeJapaneseB0:
			return BNSizeMakeWithPPI(40.55f, 57.32f);
		case BNPageSizeJapaneseB1:
			return BNSizeMakeWithPPI(28.66f, 40.55f);
		case BNPageSizeJapaneseB2:
			return BNSizeMakeWithPPI(20.28f, 28.66f);
		case BNPageSizeJapaneseB3:
			return BNSizeMakeWithPPI(14.33f, 20.28f);
		case BNPageSizeJapaneseB4:
			return BNSizeMakeWithPPI(10.12f, 14.33f);
		case BNPageSizeJapaneseB5:
			return BNSizeMakeWithPPI(7.17f, 10.12f);
		case BNPageSizeJapaneseB6:
			return BNSizeMakeWithPPI(5.04f, 7.17f);
		case BNPageSizeJapaneseB7:
			return BNSizeMakeWithPPI(3.58f, 5.04f);
		case BNPageSizeJapaneseB8:
			return BNSizeMakeWithPPI(2.52f, 3.58f);
		case BNPageSizeJapaneseB9:
			return BNSizeMakeWithPPI(1.77f, 2.52f);
		case BNPageSizeJapaneseB10:
			return BNSizeMakeWithPPI(1.26f, 1.77f);
		case BNPageSizeJapaneseB11:
			return BNSizeMakeWithPPI(0.87f, 1.26f);
		case BNPageSizeJapaneseB12:
			return BNSizeMakeWithPPI(0.63f, 0.87f);
	}
	return CGSizeZero;
}

#pragma mark - Methods

- (CGSize)actualPageSize {
	if (self.landscape) {
		CGSize pageSize = [self _sizeFromPageSize:self.pageSize];
		return CGSizeMake(pageSize.height, pageSize.width);
	}
	return [self _sizeFromPageSize:self.pageSize];
}

- (void)saveHtmlAsPdf:(NSString *)html {
	[self saveHtmlAsPdf:html toFile:nil];
}

- (void)saveHtmlAsPdf:(NSString *)html toFile:(NSString *)file {
	self.outputFile = file;

	self.webView = [[UIWebView alloc] init];
	self.webView.delegate = self;

	if (!self.baseUrl) {
		[self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://localhost"]];
	} else {
		[self.webView loadHTMLString:html baseURL:self.baseUrl];
	}
}

- (void)saveUrlAsPdf:(NSURL *)url {
	[self saveUrlAsPdf:url toFile:nil];
}

- (void)saveUrlAsPdf:(NSURL *)url toFile:(NSString *)file {
	self.outputFile = file;

	self.webView = [[UIWebView alloc] init];
	self.webView.delegate = self;

	if ([self.webView respondsToSelector:@selector(setSuppressesIncrementalRendering:)]) {
		[self.webView setSuppressesIncrementalRendering:YES];
	}

	[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)saveWebViewAsPdf:(UIWebView *)webView {
	[self saveWebViewAsPdf:webView toFile:nil];
}

- (void)saveWebViewAsPdf:(UIWebView *)webView toFile:(NSString *)file {
	[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeout) object:nil];

	self.outputFile = file;

	webView.delegate = self;

	self.webView = webView;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
	BOOL complete = [readyState isEqualToString:@"complete"];

	[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeout) object:nil];

	if (complete) {
		[self _savePdf];
	} else {
		[self performSelector:@selector(_timeout) withObject:nil afterDelay:1.0f];
	}
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeout) object:nil];

	if ([self.delegate respondsToSelector:@selector(htmlPdfKit:didFailWithError:)]) {
		[self.delegate htmlPdfKit:self didFailWithError:error];
	}

	self.webView = nil;
}

#pragma mark - Private Methods

- (void)_timeout {
	[self _savePdf];
}

- (void)_savePdf {
	if (!self.webView) {
		return;
	}

	UIPrintFormatter *formatter = self.webView.viewPrintFormatter;

	BNHtmlPdfKitPageRenderer *renderer = [[BNHtmlPdfKitPageRenderer alloc] init];
	renderer.topAndBottomMarginSize = self.topAndBottomMarginSize;
	renderer.leftAndRightMarginSize = self.leftAndRightMarginSize;

	[renderer addPrintFormatter:formatter startingAtPageAtIndex:0];

	NSMutableData *currentReportData = [NSMutableData data];

	CGSize pageSize = [self actualPageSize];
	CGRect pageRect = CGRectMake(0, 0, pageSize.width, pageSize.height);

	UIGraphicsBeginPDFContextToData(currentReportData, pageRect, nil);

	[renderer prepareForDrawingPages:NSMakeRange(0, 1)];

	NSInteger pages = [renderer numberOfPages];

	for (NSInteger i = 0; i < pages; i++) {
		UIGraphicsBeginPDFPage();
		[renderer drawPageAtIndex:i inRect:renderer.paperRect];
	}

	UIGraphicsEndPDFContext();

	if ([self.delegate respondsToSelector:@selector(htmlPdfKit:didSavePdfData:)]) {
		[self.delegate htmlPdfKit:self didSavePdfData:currentReportData];
	}

	if (self.outputFile) {
		[currentReportData writeToFile:self.outputFile atomically:YES];

		if ([self.delegate respondsToSelector:@selector(htmlPdfKit:didSavePdfFile:)]) {
			[self.delegate htmlPdfKit:self didSavePdfFile:self.outputFile];
		}
	}

	self.webView = nil;
}

- (CGSize)_sizeFromPageSize:(BNPageSize)pageSize {
	if (pageSize == BNPageSizeCustom) {
		return self.customPageSize;
	}

	return [BNHtmlPdfKit sizeForPageSize:pageSize];
}

+ (BNPageSize)defaultPageSize {
	NSLocale *locale = [NSLocale currentLocale];
	BOOL useMetric = [[locale objectForKey:NSLocaleUsesMetricSystem] boolValue];
	BNPageSize pageSize = (useMetric ? BNPageSizeA4 : BNPageSizeLetter);

	return pageSize;
}

@end

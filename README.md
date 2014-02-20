# BNHtmlPdfKit

BNHtmlPdfKit easily turns HTML data from an HTML string or URL into a PDF file on iOS. Feel free to fork this project and help make it better!

If you are using BNHtmlPdfKit in your app I would love to [hear about it](mailto:brentnycum@gmail.com)!

## Adding BNHtmlPdfKit To Your Project

Just copy `BNHtmlPdfKit.h` and `BNHtmlPdfKit.m` into your project.

### CocoaPods

```ruby
pod 'BNHtmlPdfKit', :git => 'https://github.com/brentnycum/BNHtmlPdfKit'
```

## Background

This all started with a [post of mine](http://itsbrent.net/2011/06/printing-converting-uiwebview-to-pdf/) back in June of 2011, when I was trying to save Html data to a PDF and copy the PDF data to an email as an attachment. I had always wanted to make the code better and was finally able to. The post of mine generates a bunch of traffic to my blog to this day, by an order of 10 fold to the next top page and is still a very popular problem that people are working on.

## Usage

Be sure to retain a reference to the `BNHtmlPdfKit` object outside the scope of the calling method. Otherwise, no delegate methods will be called:

```objective-c
@interface MyCoolViewController () {
    BNHtmlPdfKit *_htmlPdfKit;
}

- (void) createPdf:(id)sender {
    _htmlPdfKit = [[BNHtmlPdfKit alloc] init];
    _htmlPdfKit.delegate = self;
    [_htmlPdfKit saveUrlAsPdf:[NSURL URLWithString:@"http://itsbrent.net/index.html"]];
}

@end

// Delegate methods go here...

```

### Initializers

```objective-c
- (id)init;
- (id)initWithPageSize:(BNPageSize)pageSize;
- (id)initWithCustomPageSize:(CGSize)pageSize;
```

Default initializer has default page size based on locale (thanks Pierre Bernard) and 1/4" margins.

### Saving a URL

```objective-c
BNHtmlPdfKit *htmlPdfKit = [[BNHtmlPdfKit alloc] init];
htmlPdfKit.delegate = self;
[htmlPdfKit saveUrlAsPdf:[NSURL URLWithString:@"http://itsbrent.net"] toFile:@"...itsbrent.pdf"];
```

To just save PDF data.

```objective-c
[htmlPdfKit saveUrlAsPdf:[NSURL URLWithString:@"http://itsbrent.net"]];
```

### Saving an HTML String

```objective-c
BNHtmlPdfKit *htmlPdfKit = [[BNHtmlPdfKit alloc] init];
htmlPdfKit.delegate = self;
[htmlPdfKit saveHtmlAsPdf:@"<html>..." toFile:@"...itsbrent.pdf"];
```

To just save PDF data.

```objective-c
[htmlPdfKit saveHtmlAsPdf:@"<html>..."];
```

### Delegate Methods

```objective-c
- (void)htmlPdfKit:(BNHtmlPdfKit *)htmlPdfKit didSavePdfData:(NSData *)data;
- (void)htmlPdfKit:(BNHtmlPdfKit *)htmlPdfKit didSavePdfFile:(NSString *)file;
- (void)htmlPdfKit:(BNHtmlPdfKit *)htmlPdfKit didFailWithError:(NSError *)error;
```

`didSavePdfData` is called whenever PDF data is generated for an Html string or URL. `didSavePdfFile` is called whenever a PDF file was saved using the `toFile` methods.

### Page Sizes

BNHtmlPdfKit has support for many of the top [paper sizes](http://en.wikipedia.org/wiki/Paper_size).

 * Letter - `BNPageSizeLetter`
 * Government Letter - `BNPageSizeGovernmentLetter`
 * Legal - `BNPageSizeLegal`
 * Junior Legal - `BNPageSizeJuniorLegal`
 * Ledger - `BNPageSizeLedger`
 * Tabloid - `BNPageSizeTabloid`
 * A0 - `BNPageSizeA0`
 * A1 - `BNPageSizeA1`
 * A2 - `BNPageSizeA2`
 * A3 - `BNPageSizeA3`
 * A4 - `BNPageSizeA4`
 * A5 - `BNPageSizeA5`
 * A6 - `BNPageSizeA6`
 * A7 - `BNPageSizeA7`
 * A8 - `BNPageSizeA8`
 * A9 - `BNPageSizeA9`
 * A10 - `BNPageSizeA10`
 * B0 - `BNPageSizeB0`
 * B1 - `BNPageSizeB1`
 * B2 - `BNPageSizeB2`
 * B3 - `BNPageSizeB3`
 * B4 - `BNPageSizeB4`
 * B5 - `BNPageSizeB5`
 * B6 - `BNPageSizeB6`
 * B7 - `BNPageSizeB7`
 * B8 - `BNPageSizeB8`
 * B9 - `BNPageSizeB9`
 * B10 - `BNPageSizeB10`
 * C0 - `BNPageSizeC0`
 * C1 - `BNPageSizeC1`
 * C2 - `BNPageSizeC2`
 * C3 - `BNPageSizeC3`
 * C4 - `BNPageSizeC4`
 * C5 - `BNPageSizeC5`
 * C6 - `BNPageSizeC6`
 * C7 - `BNPageSizeC7`
 * C8 - `BNPageSizeC8`
 * C9 - `BNPageSizeC9`
 * C10 - `BNPageSizeC10`
 * Japanese B0 - `BNPageSizeJapaneseB0`
 * Japanese B1 - `BNPageSizeJapaneseB1`
 * Japanese B2 - `BNPageSizeJapaneseB2`
 * Japanese B3 - `BNPageSizeJapaneseB3`
 * Japanese B4 - `BNPageSizeJapaneseB4`
 * Japanese B5 - `BNPageSizeJapaneseB5`
 * Japanese B6 - `BNPageSizeJapaneseB6`
 * Japanese B7 - `BNPageSizeJapaneseB7`
 * Japanese B8 - `BNPageSizeJapaneseB8`
 * Japanese B9 - `BNPageSizeJapaneseB9`
 * Japanese B10 - `BNPageSizeJapaneseB10`
 * Japanese B11 - `BNPageSizeJapaneseB11`
 * Japanese B12 - `BNPageSizeJapaneseB12`

### Custom Page Sizes

BNHtmlPdfKit also supports custom page sizes by using the `customPageSize` property. Specify your page size in inches * 72.0f.

```objective-c
htmlPdfKit.customPageSize = CGSizeMake(8.5f * 72.0f, 11.0f * 72.0f);
```

### Landscape Support

Support for setting a paper size and setting as landscape is available by either using the `landscape` property or by using the custom init method below.

```objective-c
- (id)initWithPageSize:(BNPageSize)pageSize isLandscape:(BOOL)landscape;
```

### Margin Sizes

Default margin size is set to 1/4".

```objective-c
htmlPdfKit.topAndBottomMarginSize = 0.25f * 72.0f;
htmlPdfKit.leftAndRightMarginSize = 0.25f * 72.0f;
```

## Todo

 * Fix page sizes to not use rounded inch values.
 * Custom Top, Left, Bottom, and Right margins

## Contact

 * [http://itsbrent.net](http://itsbrent.net)
 * [@BrentNycum](http://twitter.com/brentnycum)

## Thanks

 * [Brent Anderson](https://github.com/brentjanderson) for commit [6767874ecd](https://github.com/brentnycum/BNHtmlPdfKit/commit/6767874ecd381f1659aaed57a40531b757385e43).
 * [Pierre Bernard](https://github.com/gloubibou) who also has his own fork [gloubibou/BNHtmlPdfKit](https://github.com/gloubibou/BNHtmlPdfKit).
 * [Laurent Denoue](https://twitter.com/ldenoue) for finding [this bug](https://github.com/brentnycum/BNHtmlPdfKit/commit/77b5d51ae3f297bc69f52a9ec7b1db3e19b19786).

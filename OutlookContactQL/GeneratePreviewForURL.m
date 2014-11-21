#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <Cocoa/Cocoa.h>
#include <QuickLook/QuickLook.h>

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{

    @autoreleasepool {

        if (QLPreviewRequestIsCancelled(preview)) {
            return noErr;
        }

    //    NSString *file = @"/Users/craibuc/Projects/xcode/OutlookContactQL/x01_29716.olk14Contact";
    //    NSData *data = [NSData dataWithContentsOfFile: file];

    //    NSString *_content = [NSString stringWithContentsOfURL:(__bridge NSURL *)url encoding:NSUTF8StringEncoding error:nil];
    
        //
        // get file's metadata via shell ($ mdls <filepath>)
        //
        NSURL *filepath = (__bridge NSURL *)(url);
        
        NSPipe *pipe = [NSPipe pipe];
        NSFileHandle *file = pipe.fileHandleForReading;

        NSTask *task = [[NSTask alloc] init];
        task.launchPath = @"/usr/bin/mdls";
        task.arguments = @[filepath];
        task.standardOutput = pipe;

        [task launch];

        NSData *data = [file readDataToEndOfFile];
        [file closeFile];

        //
        // convert to string
        //
        NSString *_content = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];

        //
        // return simple representation
        //
        QLPreviewRequestSetDataRepresentation(
              preview,
              (__bridge CFDataRef)[_content dataUsingEncoding:NSUTF8StringEncoding],
              kUTTypePlainText,
              NULL
          );
        
        //
        // convert string to dictionary
        //
//        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile: _content];

        //
        // load HTML template from Resources folder
        //
//        NSURL *htmlURL = [[NSBundle bundleWithIdentifier: @"com.cogniza.OutlookContactQL"] URLForResource:@"template" withExtension:@"html"];
//        NSMutableString *html = [NSMutableString stringWithContentsOfURL:htmlURL encoding:NSUTF8StringEncoding error:NULL];
//        NSString *html = @"<html><head><title>FIRST LAST</title></head><body><h1>First Last</h1></body></html>";
        
        //
        // replace template's variables with values from dictionary
        //

        // set HTML metadata
//        NSDictionary *properties = @{
//             (__bridge NSString *)kQLPreviewPropertyTextEncodingNameKey : @"UTF-8",
//             (__bridge NSString *)kQLPreviewPropertyMIMETypeKey : @"text/html"
//        };

        //
        // return Preview
        //
//        QLPreviewRequestSetDataRepresentation(
//            preview,
//            (__bridge CFDataRef)[html dataUsingEncoding:NSUTF8StringEncoding],
//            kUTTypeHTML,
//            (__bridge CFDictionaryRef)properties)
//        ;
        
    }

    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}

#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <Cocoa/Cocoa.h>
#include <QuickLook/QuickLook.h>
#include <Contact.h>

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

        Contact *contact = [Contact openFromUrl: (__bridge NSURL *)(url)];
        NSDictionary *dictionary = [contact dictionary];

        //
        // load HTML template from Resources folder
        //
        NSURL *htmlURL = [[NSBundle bundleWithIdentifier: @"com.cogniza.OutlookContactQL"] URLForResource:@"template" withExtension:@"html"];
        NSMutableString *html = [NSMutableString stringWithContentsOfURL:htmlURL encoding:NSUTF8StringEncoding error:NULL];

        //
        // replace template's variables with values from dictionary
        //
        for (NSString *key in [dictionary allKeys]) {
            
            NSString *token = [NSString stringWithFormat:@"__%@__", key];
            NSString *replacementValue = nil;
            
            @try {
                
                if ( [[dictionary objectForKey:key] isKindOfClass:[NSString class]] ) {

                    replacementValue = [dictionary objectForKey:key];
                    
                }
                else if ([[dictionary objectForKey:key] isKindOfClass:[NSArray class]]) {
                    replacementValue = [[dictionary objectForKey: key] componentsJoinedByString:@"<br/>"];
                }
                
//                [replacementValue replaceOccurrencesOfString:@"\n" withString: @""];
                
//                NSString *replacementValue = [dictionary objectForKey:key];
//                NSString *replacementToken = [NSString stringWithFormat:@"__%@__", key];
                
                [html replaceOccurrencesOfString:token withString:replacementValue options:0 range:NSMakeRange(0, [html length])];
            }
            @catch (NSException *exception) {
                // ignore exceptions to allow processing to continue
            }
    
        }
        
        // set HTML metadata
        NSDictionary *properties = @{
             (__bridge NSString *)kQLPreviewPropertyTextEncodingNameKey : @"UTF-8",
             (__bridge NSString *)kQLPreviewPropertyMIMETypeKey : @"text/html"
        };

        //
        // return Preview
        //
        QLPreviewRequestSetDataRepresentation(
            preview,
            (__bridge CFDataRef)[html dataUsingEncoding:NSUTF8StringEncoding],
            kUTTypeHTML,
            (__bridge CFDictionaryRef)properties
        );
        
    }

    return noErr;
}

//- (NSString*) formatHTML: (NSDictionary *) dict {
//
//    NSMutableString *html=[[NSMutableString alloc] init];
//    
//    [html appendString:@"<html>"];
//    [html appendString:@"<body>"];
//    [html appendString:@"<h1>"];
//    [html appendString: [dictionary valueForKey:@"kMDItemDisplayName"]];
//    [html appendString:@"</h1>"];
//    [html appendString:@"</body>"];
//    [html appendString:@"</html>"];
//
//    //
//    // load HTML template from Resources folder
//    //
//    
//
//    //        NSURL *htmlURL = [[NSBundle bundleWithIdentifier: @"com.cogniza.OutlookContactQL"] URLForResource:@"template" withExtension:@"html"];
//    return html;
//
//}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}



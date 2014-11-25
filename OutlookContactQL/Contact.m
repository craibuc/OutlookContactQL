//
//  Contact.m
//  OutlookContactQL
//
//  Created by Craig Buchanan on 11/22/14.
//  Copyright (c) 2014 Craig Buchanan. All rights reserved.
//

#import "Contact.h"

@implementation Contact

+ (instancetype) openFromUrl: (NSURL *) url {
    
    //
    // create new Contact
    //
    Contact *contact = [[self alloc] init];

    //
    // get associated metadata
    //
    NSDictionary *dictionary = [self getMetadata: url];
    
    //
    // deserialize
    //
    [Contact deserialize: contact : dictionary];
    
    return contact;
    
}

/* 
--------------------------------------------------------------------------------
Private Methods
--------------------------------------------------------------------------------
*/

/*! Use API to get metadata associated with the contact's .olk14Contact file
 \param url - .olk14Contact file's location in format file:///path/to/file/x.olk14Contact
 \returns NSDictionary
 */
+ (NSDictionary *) getMetadata: (NSURL *) url {

    MDItemRef item;
    CFArrayRef names;

    @try {
        
        item = MDItemCreateWithURL(NULL, (__bridge CFURLRef)url);
        names = MDItemCopyAttributeNames(item);

        return CFBridgingRelease(MDItemCopyAttributes(item, names));
    }
    @catch (NSException *exception) {
        //
    }
    @finally {
        CFRelease(names);
        CFRelease(item);
    }

}

+ (void) deserialize: (Contact *) contact : (NSDictionary *) dictionary {

    [contact setDictionary: dictionary];

    [contact setFirstName: [dictionary valueForKey: @"com_microsoft_outlook_firstName"]];
    [contact setLastName: [dictionary valueForKey: @"com_microsoft_outlook_lastName"]];
    [contact setBirthDate: [dictionary valueForKey: @"com_microsoft_outlook_birthday"]];
    
    Address *homeAddress = [[Address alloc] initWithData
                            :@"Home"
                            :[dictionary valueForKey: @"com_microsoft_outlook_homeStreet"]
                            :[dictionary valueForKey: @"com_microsoft_outlook_homeCity"]
                            :[dictionary valueForKey: @"com_microsoft_outlook_homeState"]
                            :[dictionary valueForKey: @"com_microsoft_outlook_homeZip"]
                            :[dictionary valueForKey: @"com_microsoft_outlook_homeCountry"]
                            ];
//    [contact setHomeAddress: homeAddress];
    [[contact addresses] addObject: homeAddress];
    
    Address *workAddress = [[Address alloc] initWithData
                            :@"Work"
                            :[dictionary valueForKey: @"com_microsoft_outlook_workStreet"]
                            :[dictionary valueForKey: @"com_microsoft_outlook_workCity"]
                            :[dictionary valueForKey: @"com_microsoft_outlook_workState"]
                            :[dictionary valueForKey: @"com_microsoft_outlook_workZip"]
                            :[dictionary valueForKey: @"com_microsoft_outlook_workCountry"]
                            ];
//    [contact setWorkAddress: workAddress];
    [[contact addresses] addObject: workAddress];
    
}



/*! The string representation of the Contact instance
 \returns NSString
 */
- (NSString *) description {
    
    return [NSString stringWithFormat:@"%@ %@", [self firstName], [self lastName]];
    
}

@end
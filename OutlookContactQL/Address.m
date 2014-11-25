//
//  Address.m
//  OutlookContactQL
//
//  Created by Craig Buchanan on 11/24/14.
//  Copyright (c) 2014 Craig Buchanan. All rights reserved.
//

#import "Address.h"

@implementation Address

-(id) initWithData :(NSString*) aLabel :(NSString*) aStreet :(NSString*) aCity :(NSString*) aRegionCode :(NSString*) aPostalCode :(NSString*) aCountry {
    
    self = [super init];
    
    if (self) {

        [self setStreet: aLabel];
        [self setStreet: aStreet];
        [self setCity: aCity];
        [self setRegionCode: aRegionCode];
        [self setPostalCode: aPostalCode];
        [self setCountry: aCountry];
        
    }
    
    return self;
    
}

/*! The string representation of the Address instance
 \returns NSString
 */
- (NSString *) description {
    
    // autorelease
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if ([[self street] length] != 0)
        [array addObject: [self street]];

    if ([[self city] length] != 0)
        [array addObject: [self city]];
    
    if ([[self regionCode] length] !=0)
        [array addObject: [self regionCode]];

    if ([[self postalCode] length] !=0)
        [array addObject: [self postalCode]];
    
    if ([[self country] length] !=0)
        [array addObject: [self country]];
    
    return [array componentsJoinedByString:@", "];
    
}

@end

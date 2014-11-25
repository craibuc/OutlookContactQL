//
//  Address.h
//  OutlookContactQL
//
//  Created by Craig Buchanan on 11/24/14.
//  Copyright (c) 2014 Craig Buchanan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject {

//    NSString *_city;
//    NSString *_regionCode;
//    NSString *_postalCode;
//    NSString *_countryCode;

}

@property (nonatomic,copy) NSString *label;
@property (nonatomic,copy) NSString *street;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *regionCode;
@property (nonatomic,copy) NSString *postalCode;
@property (nonatomic,copy) NSString *country;

/*! Creates a new Address instances given the supplied values.
 \param aLabel - a label (e.g. Home, Work)
 \param aCity - a city
 \param aStreet - a street
 \param aRegionCode - an ISO 3166-2 country subdivision codes
 \param aPostalCode - a postal code
 \param aCountryCode - an ISO 3166-1 alpha-2 county code
 \returns id
 */
-(id) initWithData:(NSString*) aLabel
                  :(NSString*) aStreet
                  :(NSString*) aCity
                  :(NSString*) aRegionCode
                  :(NSString*) aPostalCode
                  :(NSString*) aCountry;

@end

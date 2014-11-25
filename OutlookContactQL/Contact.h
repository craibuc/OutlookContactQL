//
//  Contact.h
//  OutlookContactQL
//
//  Created by Craig Buchanan on 11/22/14.
//  Copyright (c) 2014 Craig Buchanan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <Address.h>

@interface Contact : NSObject

@property (nonatomic,copy) NSDictionary *dictionary;

@property (nonatomic,retain) NSString *firstName;
@property (nonatomic,copy) NSString *lastName;
@property (nonatomic,copy) NSDate *birthDate;

//@property (nonatomic,retain) Address *homeAddress;
//@property (nonatomic,retain) Address *workAddress;
@property (nonatomic,retain) NSMutableArray *addresses;

@property (nonatomic,retain) NSString *emails;
@property (nonatomic,retain) NSString *telephones;

/*! Creates a new Address instances given the supplied values.
 \param url - the .olk14Contact file's url
 \returns id
 */
+ (instancetype) openFromUrl: (NSURL *)url;

@end

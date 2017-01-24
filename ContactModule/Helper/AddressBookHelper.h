//
//  AddressBookHelper.h
//  ContactListSorter
//
//  Created by fallen.ink on 11/19/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookHelper : NSObject

+ (instancetype)sharedInstance;

- (void)loadContacts:(void (^)(BOOL succeeded, NSError *error))completionBlock;

@end

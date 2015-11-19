//
//  AddressBookHelper.m
//  ContactListSorter
//
//  Created by fallen.ink on 11/19/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "AddressBookHelper.h"

@implementation AddressBookHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{ _sharedObject = [[self alloc] init]; });
    return _sharedObject;
}

- (void)loadContacts:(void (^)(BOOL, NSError *))completionBlock {
    
}

@end

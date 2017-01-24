//
//  ContactService.h
//  ContactListSorter
//
//  Created by fallen.ink on 24/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

//  1. 在项目中包含Contacts.framework和ContactsUI.framework
//  2. 不支持：#import <AddressBook/AddressBook.h>

#import <Foundation/Foundation.h>

#import "ContactExample.h"

@interface ContactService : NSObject

// 权限


// 获取所有联系人
- (void)loadContacts:(void (^)(BOOL succeeded, NSError *error))completionBlock;

@end

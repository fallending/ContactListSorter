//
//  ContactService.m
//  ContactListSorter
//
//  Created by fallen.ink on 24/01/2017.
//  Copyright © 2017 fallen.ink. All rights reserved.
//

#import "ContactService.h"

@interface ContactService ()

@property (nonatomic, strong) CNContactStore *contactStore;

@end

@implementation ContactService

- (instancetype)init {
    if (self = [super init]) {
        self.contactStore = [CNContactStore new];
    }
    
    return self;
}

- (void)loadContacts:(void (^)(BOOL, NSError *))completionBlock {
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        [self.contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
            if (error) {
                NSLog(@"Error: %@", error);
                // 错误
            } else if (!granted) {
                
//                block(NO,YES);
                // 用户不允许
            } else {
//                block(YES,YES);
                // 获取成功
            }
        }];
    }
    else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
//        block(YES,YES);
        // 获取成功
    }
    else {
        NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
    }
}

#pragma mark - Private

- (void)loadContacts {
    NSError *error = nil;
    NSArray *typeArray = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:typeArray];
    [self.contactStore enumerateContactsWithFetchRequest:request
                                                   error:&error
                                              usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                                                  // 获取所有的联系人，找出那些
                                                  
                                                  
                                                  /*
                                                   *  CNLabeledValue 该类在json 转化二进制流的时候，不能被转化。切记一定要转化，否者也存不到文件里面
                                                   */
                                              }];
}

- (void)storeContacts {
    NSError *error = nil;
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
//    [request ad]
}

@end

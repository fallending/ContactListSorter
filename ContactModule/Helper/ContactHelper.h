//
//  ContactHelper.h
//  ContactListSorter
//
//  Created by fallen.ink on 11/15/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ContactModel;

@interface ContactHelper : NSObject

@property (nonatomic, strong, readonly) NSArray<ContactModel *> *contacts; // 原始联系人，默认排序
@property (nonatomic, strong, readonly) NSArray<NSString *> *   contactNames;
@property (nonatomic, strong, readonly) NSArray<NSString *> *   contactMarks;
@property (nonatomic, strong, readonly) NSArray<NSString *> *   contactEngs;

// 默认初始化
- (void)initCommonly;

// 用Plist文件初始化
- (void)initWithPlist:(NSString *)filename;

// 获取section titles
- (NSArray<NSString *> *)contactTableSectionTitles;

// 获取section、row二维model数组
- (NSDictionary *)contactTableDataSource;

@end

#pragma mark - ContactModel

@interface ContactModel : NSObject // TODO: 应该继承 iOS 的AddressBook

@property (nonatomic, copy) NSString *name; // 原名字或昵称
@property (nonatomic, copy) NSString *mark; // 备注
@property (nonatomic, copy) NSString *eng;  // 英文名

@end

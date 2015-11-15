//
//  ContactHelper.h
//  ContactListSorter
//
//  Created by fallen.ink on 11/15/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactHelper : NSObject

@property (nonatomic, strong) NSArray *contacts; // 原始联系人，默认排序

// 默认初始化
- (void)initCommonly;

// 用Plist文件初始化
- (void)initWithPlist:(NSString *)filename;

// 获取section titles
- (NSArray *)contactTableSectionTitles;

// 获取section、row二维model数组
- (NSArray *)contactTableDataSource;

@end

#pragma mark - ContactModel

@interface ContactModel : NSObject

@property (nonatomic, copy) NSString *name; // 原名字或昵称
@property (nonatomic, copy) NSString *mark; // 备注
@property (nonatomic, copy) NSString *eng;  // 英文名

@end

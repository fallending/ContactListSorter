//
//  NSArray+ContactFieldRecognize.h
//  kata
//
//  Created by fallen.ink on 09/02/2017.
//  Copyright © 2017 fallenink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ContactFieldRecognize)

#define OCRKeyName              @"姓名"
#define OCRKeyMobile            @"手机"
#define OCRKeyEmail             @"邮箱"
#define OCRKeyCompanyName       @"公司名"
#define OCRKeyCompanyAddress    @"地址"
- (NSString *)OCRName;
- (NSArray<NSString *> *)OCRMobile;
- (NSString *)OCREmail;
- (NSString *)OCRCompanyName;
- (NSString *)OCRCompanyAddress;

- (NSDictionary *)OCRContactParams;

@end

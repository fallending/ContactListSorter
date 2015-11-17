//
//  NSArray+FirstLetterArray.m
//  LetterDescent
//
//  Created by Mr.Yang on 13-8-20.
//  Copyright (c) 2013年 Hunter. All rights reserved.
//

#import "NSArray+HTLetter.h"
#import "NSString+HTLetter.h"
#import "pinyin.h"

@implementation NSArray (HTLetter)

- (NSDictionary *)sortedByFirstLetter {
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    const char *letterPoint = NULL;
    NSString *firstLetter = nil;
    for (NSString *str in self) {
        
        //检查 str 是不是 NSString 类型
        if (![str isKindOfClass:[NSString class]]) {
            assert(@"object in array is not NSString");
#ifdef DEBUG
            NSLog(@"object in array is not NSString, it's [%@]", NSStringFromClass([str class]));
#endif
            continue;
        }
        
        letterPoint = [str UTF8String];

        //如果开头不是大小写字母则读取 首字符
        if (!(*letterPoint > 'a' && *letterPoint < 'z') &&
            !(*letterPoint > 'A' && *letterPoint < 'Z')) {
            
            //汉字或其它字符
            char letter = pinyinFirstLetter([str characterAtIndex:0]);
            letterPoint = &letter;
            
        }
        //首字母转成大写
        firstLetter = [[NSString stringWithFormat:@"%c", *letterPoint] uppercaseString];
        
        //首字母所对应的 姓名列表
        NSMutableArray *mutArray = [mutDic objectForKey:firstLetter];
        
        if (mutArray == nil) {
            mutArray = [NSMutableArray array];
            [mutDic setObject:mutArray forKey:firstLetter];
        }
        
        [mutArray addObject:str];
    }
    
    //字典是无序的，数组是有序的，
    //将数组排序
    for (NSString *key in [mutDic allKeys]) {
        NSArray *nameArray = [[mutDic objectForKey:key] sortedArrayUsingSelector:@selector(compare:)];
        [mutDic setValue:nameArray forKey:key];
    }
    
    return mutDic;
}

- (NSDictionary *)sortedByFirstLetterWithPropertyKey:(NSString *)propertyKey {
    NSAssert(propertyKey, @"sortedByFirstLetterWithPropertyKey key nil");
    
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    char firstChar;
    NSString *firstLetter       = nil;
    for (NSObject *obj in self) {
        NSString *str           = [obj valueForKey:propertyKey];
        
        // 去掉特殊字符
        str                     = [str trimSpecialCharacter];
        [obj setValue:str forKey:propertyKey];
        
        // 检查 str 是不是 NSString 类型
        if (![str isKindOfClass:[NSString class]]) {
            NSAssert(NO, @"object in array is not NSString");

            continue;
        }

        // 如果开头不是大小写字母则读取 首字符
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        NSString *initialStr = [str length] ? [str substringToIndex:1] : @"";
        if ([predicate evaluateWithObject:initialStr]) {
            str = [str capitalizedString];
            firstChar  = [str characterAtIndex:0];
        } else {
            firstChar = pinyinFirstLetter([str characterAtIndex:0]);
        }
        
        firstLetter = [[NSString stringWithFormat:@"%c", firstChar] uppercaseString];

        //首字母所对应的 姓名列表
        NSMutableArray *mutArray = [mutDic objectForKey:firstLetter];
        
        if (mutArray == nil) {
            mutArray = [NSMutableArray array];
            [mutDic setObject:mutArray forKey:firstLetter];
        }
        
        [mutArray addObject:obj];
    }
    
    // 将数组，按propertyKey，按降序排列
    for (NSString *key in [mutDic allKeys]) {
        NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:propertyKey ascending:NO]];
        NSArray *nameArray = [[mutDic objectForKey:key] sortedArrayUsingDescriptors:sortDescriptors];
        [mutDic setValue:nameArray forKey:key];
    }
    
    return mutDic;
}

@end

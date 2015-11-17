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
#import "NSString+Wrapper.h"

@implementation NSArray (HTLetter)

- (NSDictionary *)sortedDictionary {
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

- (NSDictionary *)sortedDictionaryWithPropertyKey:(NSString *)propertyKey {
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

#pragma mark - 拼音匹配

@implementation NSArray ( PinyinMatch )

- (char)charAtObjectIndex:(NSInteger)objectIndex atCharacterIndex:(NSInteger)charIndex {
    return 0;
}

/**
 * 辅佐函数，确保pinyin[n].charAt(0)(n<=wordIndex)都按顺序依次出现在search里面
 * 防止zhou ming zhong匹配zz，跳过了ming
 *
 * @param search
 * @param pinyin
 * @param wordIndex 已经匹配到拼音索引
 * @return 都按顺序依次出现了，返回true
 */
- (BOOL)distinguish:(NSString *)search withWordIndex:(int)wordIndex {
    NSString *searchString  = [NSString stringWithString:search];
    int lastIndex   = 0;
    int i           = 0;
    
    for (i = 0; i < wordIndex; i++) {
        char c      = [[self objectAtIndex:i] characterAtIndex:0];
        lastIndex   = [searchString indexOfChar:c fromIndex:lastIndex];
        
        if (lastIndex == -1) return NO;
        
        lastIndex ++;
    }
    
    return YES;
}

/**
 * 不完整拼音匹配算法，可用到汉字词组的自动完成
 * 拼音搜索匹配 huang hai yan  => huhy,hhy
 * 通过递归方法实现
 *
 * @param search 输入的拼音字母
 * @param pinyin 汉字拼音数组，通过pinyin4j获取汉字拼音 @see http://pinyin4j.sourceforge.net/
 * @return 匹配成功返回 true
 * @author 黄海晏
 */
- (BOOL)distinguish:(NSString *)search withSearchIndex:(int)searchIndex wordIndex:(int)wordIndex wordStart:(int)wordStart {
    if (searchIndex == 0) {
        return
        [search characterAtIndex:0] == [self charAtObjectIndex:0 atCharacterIndex:0] // 第一个必须匹配
        &&
        (search.length == 1 ||
         [self distinguish:search withSearchIndex:1 wordIndex:0 wordStart:1]
         );//如果仅是1个字符，算匹配，否则从第二个字符开始比较
    }
    
    if ([self[wordIndex] length] > wordStart //判断不越界
        &&
        [search characterAtIndex:searchIndex] == [self charAtObjectIndex:wordIndex atCharacterIndex:wordStart]) {//判断匹配
        return searchIndex == [search length] - 1 ? [self distinguish:search withWordIndex:wordIndex]
        //如果这是最后一个字符，检查之前的声母是否依次出现
        :
        [self distinguish:search withSearchIndex:searchIndex + 1 wordIndex:wordIndex wordStart:wordStart];// 同一个字拼音连续匹配
    } else if ([self count] > wordIndex + 1 //判断不越界
               &&
               [search characterAtIndex:searchIndex] == [self charAtObjectIndex:wordIndex+1 atCharacterIndex:0]) { //不能拼音连续匹配的情况下，看看下一个字拼音的首字母是否能匹配
        return searchIndex == [search length] - 1 ? [self distinguish:search withWordIndex:wordIndex] //如果这是最后一个字符，检查之前的声母是否依次出现
        : [self distinguish:search withSearchIndex:searchIndex+1 wordIndex:wordIndex+1 wordStart:1];//去判断下一个字拼音的第二个字母
    } else if ([self count] > wordIndex + 1) {//回退试试看  对于zhuang an lan  searchIndex > 1 &&
        for (int i = 1; i < searchIndex; i++) {
            if ([self distinguish:search withSearchIndex:searchIndex-i wordIndex:wordIndex+1 wordStart:0]) {
                return true;
            }
        }
    }
    
    return false;
}



- (NSArray *)filteredArrayWithSearchingString:(NSString *)search {
    
    
    
    return self;
}

@end

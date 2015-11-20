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
#import "PinYin4Objc.h"

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

- (NSArray *)sortedArrayWithPropertykey:(NSString *)propertyKey {
    NSDictionary *selfDict   = [self sortedDictionaryWithPropertyKey:propertyKey];
    NSMutableArray *sortedArray = [NSMutableArray new];
    
    [sortedArray addObjectsFromArray:selfDict.allValues];
    
    return sortedArray;
}

@end

#pragma mark - 拼音匹配

@implementation NSArray ( PinyinMatch )

- (char)charAtObjectIndex:(NSInteger)objectIndex atCharacterIndex:(NSInteger)charIndex {
    NSAssert([[self objectAtIndex:0] isKindOfClass:NSString.class], @"类型不符");
    
    return [(NSString *)[self objectAtIndex:objectIndex] characterAtIndex:charIndex];
}

/**
 * 源代码链接：http://blog.csdn.net/nanman/article/details/6062764
 
 * 辅佐函数，确保pinyin[n].charAt(0)(n<=wordIndex)都按顺序依次出现在search里面
 * 防止zhou ming zhong匹配zz，跳过了ming
 *
 * @param search    如：@"zgr"
 * @param pinyin    如：张国荣 则是 @[@"zhang", @"guo", @"rong"]
 * @param wordIndex 已经匹配到拼音索引
 * @return 都按顺序依次出现了，返回true
 */
- (BOOL)distinguish:(NSString *)search inPinyin:(NSArray<NSString *> *)pinyin withWordIndex:(int)wordIndex {
    NSString *searchString  = [NSString stringWithString:search];
    int lastIndex   = 0;
    int i           = 0;
    
    for (i = 0; i < wordIndex; i++) {
        char c      = [[pinyin objectAtIndex:i] characterAtIndex:0];
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
 * @param searchIndex 是对输入的拼音字符的索引
 * @param pinyin 汉字拼音数组，通过pinyin4j获取汉字拼音 @see http://pinyin4j.sourceforge.net/
 * @return 匹配成功返回 true
 * @author 黄海晏
 */
- (BOOL)distinguish:(NSString *)search
    withSearchIndex:(int)searchIndex
           inPinyin:(NSArray<NSString *> *)pinyin
          wordIndex:(int)wordIndex // 默认 0
          wordStart:(int)wordStart // 默认 0，后续会递归下去
{
    //
    if (searchIndex == 0) {
        // 第一个必须匹配
        BOOL bFirstCharMatch    = [search characterAtIndex:0] == [pinyin charAtObjectIndex:0 atCharacterIndex:0];
        // 从第二个字符还是比较
        BOOL bSecondCharToMatch = [self distinguish:search
                                    withSearchIndex:1
                                           inPinyin:pinyin
                                          wordIndex:0
                                          wordStart:1];
        
        return bFirstCharMatch &&
        (search.length == 1 || bSecondCharToMatch);//如果仅是1个字符，算匹配，否则从第二个字符开始比较
    }
    
    BOOL bStringInArrayNotOverflow  = (pinyin[wordIndex].length > wordStart) &&
    (search.length > searchIndex); // 数组中的字串，相对wordStart不越界
    BOOL bArrayNotOverflow          = ([pinyin count] > wordIndex + 1) &&
    (search.length > searchIndex);
    BOOL bCharMatch = NO;
    if (bStringInArrayNotOverflow) {
       bCharMatch   = [search characterAtIndex:searchIndex] == [pinyin charAtObjectIndex:wordIndex atCharacterIndex:wordStart]; // 常规匹配
    }
    
    if (bStringInArrayNotOverflow && //判断不越界
        bCharMatch) {                //判断匹配
        return searchIndex == [search length] - 1 ?
        [self distinguish:search
                 inPinyin:pinyin
            withWordIndex:wordIndex]
        //如果这是最后一个字符，检查之前的声母是否依次出现
        :
        [self distinguish:search
          withSearchIndex:searchIndex + 1
                 inPinyin:pinyin
                wordIndex:wordIndex
                wordStart:wordStart];   // 同一个字拼音连续匹配
    } else if (bArrayNotOverflow &&     //判断不越界
               [search characterAtIndex:searchIndex] == [self charAtObjectIndex:wordIndex+1 atCharacterIndex:0]) { //不能拼音连续匹配的情况下，看看下一个字拼音的首字母是否能匹配
        return searchIndex == [search length] - 1 ?
        [self distinguish:search
                 inPinyin:pinyin
            withWordIndex:wordIndex] //如果这是最后一个字符，检查之前的声母是否依次出现
        :
        [self distinguish:search
          withSearchIndex:searchIndex+1
                 inPinyin:pinyin
                wordIndex:wordIndex+1
                wordStart:1];//去判断下一个字拼音的第二个字母
    } else if (bArrayNotOverflow) {//回退试试看  对于zhuang an lan  searchIndex > 1 &&
        for (int i = 1; i < searchIndex; i++) {
            if ([self distinguish:search
                  withSearchIndex:searchIndex-i
                         inPinyin:pinyin
                        wordIndex:wordIndex+1
                        wordStart:0]) {
                return true;
            }
        }
    }
    
    return false;
}

- (NSArray *)filteredArrayWithSearchingString:(NSString *)search reduceByPropertyKey:(NSString *)key {
    __block NSMutableArray *results = [@[] mutableCopy];
    
    // 搜索串为空，则返回空
    if ([search length]) {
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 输出指定属性
            NSString *hanyu = [obj valueForKey:key];
            
            // 断言 NSString 类型
            NSAssert([hanyu isKindOfClass:NSString.class], @"应该为字符串类型！！");
            
            // 输出汉语拼音
            NSString *seperater = @"~";
            HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
            [outputFormat setToneType:ToneTypeWithoutTone];
            [outputFormat setVCharType:VCharTypeWithV];
            [outputFormat setCaseType:CaseTypeLowercase];
            NSString *outputPinyin      =[PinyinHelper toHanyuPinyinStringWithNSString:hanyu
                                                           withHanyuPinyinOutputFormat:outputFormat
                                                                          withNSString:seperater];
            NSArray *outputPinyinArray  = [outputPinyin componentsSeparatedByString:seperater];
            
            // 断言 拼音数组不为空
            NSAssert([outputPinyinArray count]>0, @"输出的汉语拼音为空");
            
            // 匹配 名称
            if ([self distinguish:search
                  withSearchIndex:0
                         inPinyin:outputPinyinArray
                        wordIndex:0
                        wordStart:0]) {
                [results addObject:[self objectAtIndex:idx]];
            }
        }];
    }
    
    return results;
}

@end

#pragma mark - 模型数组降维

@implementation NSArray ( DimensionReduce )

- (NSArray *)arrayReduceByPropertyKey:(NSString *)propertyKey {
    NSMutableArray *arrayReduced    = [NSMutableArray new];
    
    for (id obj in self) {
        id property = [obj valueForKey:propertyKey];
        
        [arrayReduced addObject:property];
    }
    
    return arrayReduced;
}

@end



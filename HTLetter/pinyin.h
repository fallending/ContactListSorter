//
//  POAPinyin.h
//  POA
//
//  Created by haung he on 11-7-18.
//  Copyright 2011年 huanghe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_INLINE char pinyinFirstLetter(unsigned short hanzi);

@class PinyinMapObject;

@interface Pinyin : NSObject

/**
 *  @input
 *  中文汉字
 
 *  @return
 *  全拼
 */
+ (NSString *)pinyinWithLetterChn:(NSString *)chnString;

@end

#pragma mark - 拼音首字母

@interface Pinyin ( FirstLetter )
/**
 *  @desc
 *  获取汉字首字母，如果参数既不是汉字也不是英文字母，则返回 @“#”
 
 *  @goal
 *  主要用于生成，通讯录右侧的indexes
 */
+ (NSString *)firstLetter:(NSString *)chnString;

/**
 *  @desc
 *  返回参数中所有汉字的首字母，遇到其他字符，则用 # 替换
 
 *  @goal
 *  主要用于生成，通讯录右侧的indexes
 */
+ (NSString *)firstLetters:(NSString *)chnString;


@end

#pragma mark -

@interface PinyinMapObject : NSObject

+ (NSArray<PinyinMapObject *> *)map;

@property (nonatomic, strong) NSString *pinyin; // 拼音
@property (nonatomic, strong) NSString *pinyinChn; // 汉子

@end
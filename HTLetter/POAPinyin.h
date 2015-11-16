//
//  POAPinyin.h
//  POA
//
//  Created by haung he on 11-7-18.
//  Copyright 2011年 huanghe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PinyinMapObject;

@interface POAPinyin : NSObject

@property (nonatomic, strong, readonly) NSArray<PinyinMapObject *> *pinyinTable;

//输入中文，返回全拼。

/**
 *  @input
 *  中文汉字
 
 *  @return
 *  全拼
 */
+ (NSString *)pinyinWithLetterChn:(NSString *)chnString;

@end

@interface PinyinMapObject : NSObject

@property (nonatomic, strong) NSString *pinyin; // 拼音
@property (nonatomic, strong) NSString *pinyinChn; // 汉子

@end
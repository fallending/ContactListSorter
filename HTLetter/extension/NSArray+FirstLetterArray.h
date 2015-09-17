//
//  NSArray+FirstLetterArray.h
//  LetterDescent
//
//  Created by Mr.Yang on 13-8-20.
//  Copyright (c) 2013年 Hunter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FirstLetterArray)

/**
 *	通过需要按【首字母分类】的 【姓名数组】 调用此函数
 *
 *	@return	A：以a打头的姓名或者单词
            B：以b打头的姓名或者单词
 */

- (NSDictionary *)sortedByFirstLetter;

/**
 *  Add by fallenink.
 *
 *  功能与sortedArrayUsingFirstLetter类似
 
 *  但是支持Array中时任意对象，需要提供Key
 */
- (NSDictionary *)sortedByFirstLetterWithPropertyKey:(NSString *)propertyKey;

@end

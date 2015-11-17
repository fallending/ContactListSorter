//
//  NSString+FirstLetter.m
//  HTLetterManger
//
//  Created by Mr.Yang on 13-8-25.
//  Copyright (c) 2013年 Hunter. All rights reserved.
//

#import "NSString+HTLetter.h"
#import "pinyin.h"

@implementation NSString (HTLetter)

- (NSString *)firstLetter {
    return [Pinyin firstLetter:self];
}

- (NSString *)firstLetters {
    return [Pinyin firstLetters:self];
}

- (NSString *)allLetters {
    return [Pinyin pinyinWithLetterChn:self];
}

- (NSString *)trimSpecialCharacter {
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound) {
        return [self trimSpecialCharacter];
    }
    return self;
}

#pragma mark - Private

- (NSString *)trimSpecialCharacter:(NSString *)srcString {
    NSRange urgentRange = [srcString rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound) {
        return [self trimSpecialCharacter:[srcString stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return srcString;
}

@end

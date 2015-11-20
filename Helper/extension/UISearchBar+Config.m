//
//  UISearchBar+Config.m
//  ContactListSorter
//
//  Created by fallen.ink on 11/19/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "UISearchBar+Config.h"

@implementation UISearchBar (Config)
@dynamic title;
@dynamic titleButton;

- (UIButton *)titleButton {
    for (UIView *view in [[self.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            return (UIButton *)view;
        }
    }
    
    return nil;
}

- (NSString *)title {
    if (self.titleButton) {
        return self.titleButton.titleLabel.text;
    }
    
    return nil;
}

- (void)setTitle:(NSString *)title {
    if (self.titleButton) {
        [self.titleButton setTitle:title forState:UIControlStateNormal];
    }
}

@end

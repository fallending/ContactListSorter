#import "UITableViewCell+Base.h"

@implementation UITableViewCell (Base)

#pragma mark - Class

+ (NSString *)identifier {
    return NSStringFromClass(self);
}

+ (UINib *)nib {
    return [UINib nibWithNibName:[self identifier] bundle:nil];
}

+ (CGFloat)cellHeight {
    return 0.f;
}

#pragma mark - Object

- (CGFloat)cellHeight {
    return 0.f;
}

- (void)setModel:(id)model {
    // do nothing.
}

@end
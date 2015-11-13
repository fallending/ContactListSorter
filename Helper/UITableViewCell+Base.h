#import <UIKit/UIKit.h>

@interface UITableViewCell (Base)

+ (NSString *)identifier;
+ (UINib *)nib;
+ (CGFloat)cellHeight;

- (CGFloat)cellHeight;
- (void)setModel:(id)model;

@end

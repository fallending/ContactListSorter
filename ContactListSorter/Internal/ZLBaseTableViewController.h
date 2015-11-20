//
//  ZLBaseTableViewController.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactModel;

@interface ZLBaseTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *partitionedContacts;
@property (strong, nonatomic) NSMutableSet *selectedPeople;

- (void)setPartitionedContactsWithContacts:(NSArray *)contacts;
- (void)configureCell:(UITableViewCell *)cell forContact:(ContactModel *)model;
- (BOOL)shouldEnableCellforContact:(ContactModel *)model;
- (ContactModel *)contactForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark - Search delegate

@protocol BaseSearchDelegate <NSObject>

/**
 *  分段的标题数组
 */
- (NSArray<NSString *> *)sectionTitlesOfSearchController:(ZLBaseTableViewController *)search;

/**
 *
 */


@end
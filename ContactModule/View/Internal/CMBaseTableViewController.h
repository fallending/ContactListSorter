//
//  ZLBaseTableViewController.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactModel;

@interface CMBaseTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *partitionedContacts;
@property (strong, nonatomic) NSMutableSet *selectedPeople;

- (void)setPartitionedContactsWithContacts:(NSArray *)contacts;
- (void)configureCell:(UITableViewCell *)cell forContact:(ContactModel *)model;
- (BOOL)shouldEnableCellforContact:(ContactModel *)model;
- (ContactModel *)contactForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

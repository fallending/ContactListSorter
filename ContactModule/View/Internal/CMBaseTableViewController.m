//
//  ZLBaseTableViewController.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "CMBaseTableViewController.h"
#import "LRIndexedCollationWithSearch.h"
//#import "AppDelegate.h"
#import "mvc-native.h"
#import "HTLetter.h"
#import "ContactVM.h"

@interface CMBaseTableViewController ()

@property (nonatomic, strong) NSMutableArray<NSString *> *  sectionTitles;
@property (nonatomic, strong) NSMutableDictionary *         dataSource;

@end

@implementation CMBaseTableViewController

#pragma mark - Properties
- (NSMutableArray *)partitionedContacts {
    if (!_partitionedContacts) {
        _partitionedContacts = [[self emptyPartitionedArray] mutableCopy];
    }
    return _partitionedContacts;
}

- (NSMutableSet *)selectedPeople {
    if (!_selectedPeople) {
        _selectedPeople = [NSMutableSet set];
    }
    return _selectedPeople;
}

- (void)setPartitionedContactsWithContacts:(NSArray *)contacts {
    self.partitionedContacts = [contacts mutableCopy];
    self.dataSource = (NSMutableDictionary *)[contacts sortedDictionaryWithPropertyKey:@"name"];
    self.sectionTitles = [[[self.dataSource allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView
    titleForHeaderInSection:(NSInteger)section {
    return [self.sectionTitles objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionTitles;
}

- (NSInteger)tableView:(UITableView *)tableView
    sectionForSectionIndexTitle:(NSString *)title
                        atIndex:(NSInteger)index {
    NSInteger ret = [[LRIndexedCollationWithSearch currentCollation]
        sectionForSectionIndexTitleAtIndex:index];
    if (ret == NSNotFound) {
        [self.tableView
            setContentOffset:CGPointMake(0.0,-self.tableView.contentInset.top)];
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    id key = [self.sectionTitles objectAtIndex:section];
    return [[self.dataSource objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = (UITableViewCell *)
        [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];

    if (cell == nil) {
        cell =
            [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:[UITableViewCell identifier]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    ContactModel *contact = [self contactForRowAtIndexPath:indexPath];
    [self configureCell:cell forContact:contact];

    return cell;
}

#pragma mark - ()
- (void)configureCell:(UITableViewCell *)cell forContact:(ContactModel *)contact {
//    NSString *stringToHightlight =
//        contact.lastName ? contact.lastName : contact.compositeName;
//    NSRange rangeToHightlight =
//        [contact.compositeName rangeOfString:stringToHightlight];
//    NSMutableAttributedString *attributedString = [
//        [NSMutableAttributedString alloc] initWithString:contact.compositeName];
//
//    [attributedString beginEditing];
//    [attributedString addAttribute:NSFontAttributeName
//                             value:[UIFont boldSystemFontOfSize:18]
//                             range:rangeToHightlight];
//    if (![self shouldEnableCellforContact:contact]) {
//        [attributedString addAttribute:NSForegroundColorAttributeName
//                                 value:[UIColor grayColor]
//                                 range:NSMakeRange(0, attributedString.length)];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//
//    [attributedString endEditing];

//    cell.textLabel.attributedText = attributedString;
    
    //
    cell.textLabel.text         = contact.name;
    cell.detailTextLabel.text   = [NSString stringWithFormat:@"%@ (%@)", contact.mark, contact.eng];
}

- (BOOL)shouldEnableCellforContact:(ContactModel *)contact {
//    if(self.filedMask == ZLContactFieldAll) {
//        return YES;
//    }
//    else {
        return YES;
//    return ((self.filedMask & ZLContactFieldPhones) &&
//            contact.phones.count > 0) ||
//           ((self.filedMask & ZLContactFieldEmails) &&
//            contact.emails.count > 0) ||
//           ((self.filedMask & ZLContactFieldPhoto) && contact.thumbnail) ||
//           ((self.filedMask & ZLContactFieldAddresses) &&
//            contact.addresses.count > 0);
//    }
}

- (ContactModel *)contactForRowAtIndexPath:(NSIndexPath *)indexPath {
    id key = [self.sectionTitles objectAtIndex:indexPath.section];
    return [[self.dataSource objectForKey:key] objectAtIndex:indexPath.row];
}

- (NSMutableArray *)emptyPartitionedArray {
    NSUInteger sectionCount =
        [[[LRIndexedCollationWithSearch currentCollation] sectionTitles] count];
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:sectionCount];
    for (int i = 0; i < sectionCount; i++) {
        [sections addObject:[NSMutableArray array]];
    }
    return sections;
}

@end

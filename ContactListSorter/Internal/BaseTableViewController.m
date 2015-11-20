//
//  ZLBaseTableViewController.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "BaseTableViewController.h"
#import "LRIndexedCollationWithSearch.h"
#import "AppDelegate.h"

@implementation BaseTableViewController

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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.partitionedContacts.count > 0) {
        return [self.partitionedContacts count];
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView
    titleForHeaderInSection:(NSInteger)section {
    if ((NSInteger)[[self.partitionedContacts
            objectAtIndex:(NSUInteger)section] count] == 0) {
        return @"";
    }
    
    NSDictionary *dataSource    = (NSMutableDictionary *)[self.partitionedContacts sortedDictionaryWithPropertyKey:@"name"];
    NSArray *sectionTitles      = [[dataSource allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    return [sectionTitles objectAtIndex:section];
}

// 不显示SectionIndexes
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.partitionedContacts.count > 0) {
        NSDictionary *dataSource = (NSMutableDictionary *)[self.partitionedContacts sortedDictionaryWithPropertyKey:@"name"];
        
        return [[dataSource allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView
    sectionForSectionIndexTitle:(NSString *)title
                        atIndex:(NSInteger)index {
    NSInteger ret = [[LRIndexedCollationWithSearch currentCollation]
        sectionForSectionIndexTitleAtIndex:index];
    if (ret == NSNotFound) {
        [self.tableView
            setContentOffset:CGPointMake(0.0,
                                         -self.tableView.contentInset.top)];
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)[
        [self.partitionedContacts objectAtIndex:(NSUInteger)section] count];
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
    return
        [[self.partitionedContacts objectAtIndex:(NSUInteger)indexPath.section]
            objectAtIndex:(NSUInteger)indexPath.row];
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

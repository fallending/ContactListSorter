//
//  ContactViewController.m
//  ContactListSorter
//
//  Created by fallen.ink on 11/13/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "ContactViewController.h"
#import "AppDelegate.h"

@interface ContactViewController () <
    UITableViewDelegate,
    UITableViewDataSource,
    GDIIndexBarDelegate,
    UISearchBarDelegate,
    UISearchControllerDelegate,
    UISearchResultsUpdating
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 名字索引
@property (nonatomic, strong) GDIIndexBar *                 indexBar;

// 搜索栏
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation ContactViewController

#pragma mark - Intialize

- (void)initData {
    self.helper     = [ContactHelper new];
    
    [self.helper initCommonly];
}

- (void)initTableView {
    self.tableView.tableFooterView                      = [UIView new];
    
    [self.view addSubview:self.indexBar];
    
//    [self.indexBar reload];
}


#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化当前Controller，用大括号分隔
    {
        self.title  = @"通讯录";
    }
    
    [self initData];
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

//  UITableView 自带的 indexTitle
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return [self.helper contactTableSectionTitles];
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.helper contactTableSectionTitles] objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.helper contactTableSectionTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id key = [[self.helper contactTableSectionTitles] objectAtIndex:section];
    return [[[self.helper contactTableDataSource] objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier]];
    id key = [[self.helper contactTableSectionTitles] objectAtIndex:indexPath.section];
    NSArray *models = [[self.helper contactTableDataSource] objectForKey:key];
    ContactModel *model = [models objectAtIndex:indexPath.row];
    
    if (!cell) {
        cell    = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[UITableViewCell identifier]];
    }
    
    cell.textLabel.text     = model.name;
    cell.detailTextLabel.text   = [NSString stringWithFormat:@"%@ (%@)", model.mark, model.eng];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - GDIIndexBarDelegate

- (NSUInteger)numberOfIndexesForIndexBar:(GDIIndexBar *)indexBar {
    return [[self.helper contactTableSectionTitles] count];
}

- (NSString *)stringForIndex:(NSUInteger)index {
    return [[self.helper contactTableSectionTitles] objectAtIndex:index];
}

- (void)indexBar:(GDIIndexBar *)indexBar didSelectIndex:(NSUInteger)index {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)aSearchBar {
    [aSearchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [aSearchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - UISearchControllerDelegate



#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:
(UISearchController *)searchController {
//    // update the filtered array based on the search text
//    NSString *searchText = searchController.searchBar.text;
//    NSMutableArray *searchResults = [[self.partitionedContacts
//                                      valueForKeyPath:@"@unionOfArrays.self"] mutableCopy];
//    
//    // strip out all the leading and trailing spaces
//    NSString *strippedStr =
//    [searchText stringByTrimmingCharactersInSet:
//     [NSCharacterSet whitespaceCharacterSet]];
//    
//    // break up the search terms (separated by spaces)
//    NSArray *searchItems = nil;
//    if (strippedStr.length > 0) {
//        searchItems = [strippedStr componentsSeparatedByString:@" "];
//    }
//    // build all the "AND" expressions for each value in the searchString
//    NSMutableArray *andMatchPredicates = [NSMutableArray array];
//    
//    for (NSString *searchString in searchItems) {
//        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
//        
//        // TODO: match phone number matching
//        
//        // name field matching
//        NSPredicate *finalPredicate = [NSPredicate
//                                       predicateWithFormat:@"compositeName CONTAINS[c] %@", searchString];
//        [searchItemsPredicate addObject:finalPredicate];
//        
//        NSPredicate *predicate =
//        [NSPredicate predicateWithFormat:@"ANY SELF.emails CONTAINS[c] %@",
//         searchString];
//        [searchItemsPredicate addObject:predicate];
//        
//        predicate = [NSPredicate
//                     predicateWithFormat:@"ANY SELF.addresses.street CONTAINS[c] %@",
//                     searchString];
//        [searchItemsPredicate addObject:predicate];
//        predicate = [NSPredicate
//                     predicateWithFormat:@"ANY SELF.addresses.city CONTAINS[c] %@",
//                     searchString];
//        [searchItemsPredicate addObject:predicate];
//        predicate = [NSPredicate
//                     predicateWithFormat:@"ANY SELF.addresses.zip CONTAINS[c] %@",
//                     searchString];
//        [searchItemsPredicate addObject:predicate];
//        predicate = [NSPredicate
//                     predicateWithFormat:@"ANY SELF.addresses.country CONTAINS[c] %@",
//                     searchString];
//        [searchItemsPredicate addObject:predicate];
//        predicate = [NSPredicate
//                     predicateWithFormat:
//                     @"ANY SELF.addresses.countryCode CONTAINS[c] %@", searchString];
//        [searchItemsPredicate addObject:predicate];
//        
//        //        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc]
//        //        init];
//        //        [numFormatter setNumberStyle:NSNumberFormatterNoStyle];
//        //        NSNumber *targetNumber = [numFormatter
//        //        numberFromString:searchString];
//        //        if (targetNumber != nil) {   // searchString may not convert
//        //        to a number
//        //            predicate = [NSPredicate predicateWithFormat:@"ANY
//        //            SELF.sanitizePhones CONTAINS[c] %@", searchString];
//        //            [searchItemsPredicate addObject:predicate];
//        //        }
//        
//        // at this OR predicate to our master AND predicate
//        NSCompoundPredicate *orMatchPredicates =
//        (NSCompoundPredicate *)[NSCompoundPredicate
//                                orPredicateWithSubpredicates:searchItemsPredicate];
//        [andMatchPredicates addObject:orMatchPredicates];
//    }
//    
//    NSCompoundPredicate *finalCompoundPredicate = nil;
//    
//    // match up the fields of the Product object
//    finalCompoundPredicate = (NSCompoundPredicate *)
//    [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
//    
//    searchResults = [[searchResults
//                      filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
//    
//    // hand over the filtered results to our search results table
//    ZLResultsTableViewController *tableController =
//    (ZLResultsTableViewController *)
//    self.searchController.searchResultsController;
//    tableController.filedMask = self.filedMask;
//    tableController.selectedPeople = self.selectedPeople;
//    [tableController setPartitionedContactsWithContacts:searchResults];
//    [tableController.tableView reloadData];
}

#pragma mark - Property

- (GDIIndexBar *)indexBar {
    if (!_indexBar) {
        _indexBar                       = [[GDIIndexBar alloc] initWithTableView:self.tableView];
        _indexBar.delegate              = self;
        _indexBar.barBackgroundColor    = [UIColor clearColor];
        _indexBar.textColor             = [UIColor blackColor];
        _indexBar.textFont              = [UIFont boldSystemFontOfSize:9.f];
    }
    
    return _indexBar;
}

@end

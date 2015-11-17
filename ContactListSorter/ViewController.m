//
//  ViewController.m
//  ContactListSorter
//
//  Created by fallen.ink on 11/13/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController () <
    UITableViewDelegate,
    UITableViewDataSource,
    GDIIndexBarDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) GDIIndexBar *                 indexBar;

@end

@implementation ViewController

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

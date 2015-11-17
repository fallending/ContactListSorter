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
    UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

#pragma mark - Intialize

- (void)initData {
    self.helper     = [ContactHelper new];
    
    [self.helper initCommonly];
}

- (void)initTableView {
//    [self.tableView registerClass:[UITableViewCell class]
//           forCellReuseIdentifier:[UITableViewCell identifier]];
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

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.helper contactTableSectionTitles];
}

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

@end

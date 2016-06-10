//
//  ViewController.m
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerFormDataSource.h"
#import "DynamicTableManager.h"

@interface ViewController () {
    ViewControllerFormDataSource *dataSource;
    DynamicTableManager *tableManager;
}

@end

@implementation ViewController

@synthesize mArrFormContentIdentifiersOrder;
@synthesize mDicFormContentTableData;
@synthesize tableViewFormContainer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mArrFormContentIdentifiersOrder = [[NSMutableArray alloc] init];
    self.mDicFormContentTableData = [[NSMutableDictionary alloc] init];
    
    dataSource = [[ViewControllerFormDataSource alloc] initWithTableViewFormContainer:self.tableViewFormContainer
                                                                     inViewController:self];
    
    tableManager = [[DynamicTableManager alloc] initWithContentIdentifiersArray:self.mArrFormContentIdentifiersOrder
                                                           andContentDictionary:self.mDicFormContentTableData
                                                                   andTableView:self.tableViewFormContainer];
    
    [dataSource setupDataSourceForViewControllerWithConfiguration:nil withDynamicTableManager:tableManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count: %ld", (unsigned long)[[tableManager mArrFormContentIdentifiersOrder] count]);
    return [[tableManager mArrFormContentIdentifiersOrder] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *contentIdentifier = [[tableManager mArrFormContentIdentifiersOrder] objectAtIndex:indexPath.row];
    FormPortionTableViewCellData *data = (FormPortionTableViewCellData *) [[tableManager mDicFormContentTableData] objectForKey:contentIdentifier];
    return data.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [dataSource tableView:tableView formTableCellForRowAtIndexPath:indexPath withDynamicTableManager:tableManager];
}

@end

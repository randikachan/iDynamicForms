//
//  TableViewFormDataSource.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>
#import <UIKit/UITableViewCell.h>
#import "ViewControllerFormConfig.h"
#import "DynamicTableManager.h"
#import "TableViewFormDataSource.h"

@protocol TableViewFormDataSource <NSObject>

- (void) setupDataSourceForViewControllerWithConfiguration:(ViewControllerFormConfig *) config withDynamicTableManager:(DynamicTableManager *)manager;
- (UITableViewCell *) tableView:(UITableView *)tableView formTableCellForRowAtIndexPath:(NSIndexPath *)indexPath withDynamicTableManager:(DynamicTableManager *)manager;

@end
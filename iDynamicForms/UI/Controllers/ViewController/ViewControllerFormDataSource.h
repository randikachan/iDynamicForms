//
//  ViewControllerFormDataSource.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewFormDataSource.h"

@interface ViewControllerFormDataSource : NSObject <TableViewFormDataSource>

@property (weak, nonatomic) IBOutlet UITableView *formContainer;
@property (nonatomic, assign, getter=isSetupDataSourceDone) BOOL setupDataSourceDone;
@property (nonatomic, assign, getter=isSetTableViewCellsClearColor) BOOL setTableViewCellsClearColor;

- (id) initWithTableViewFormContainer:(UITableView *) container;

@end
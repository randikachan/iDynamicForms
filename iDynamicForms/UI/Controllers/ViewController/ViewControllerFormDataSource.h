//
//  ViewControllerFormDataSource.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewFormDataSource.h"

@interface ViewControllerFormDataSource : NSObject <TableViewFormDataSource, UITextFieldDelegate>

@property (weak, nonatomic) UITableView *formContainer;
@property (nonatomic, assign, getter=isSetupDataSourceDone) BOOL setupDataSourceDone;
@property (weak, nonatomic) UIViewController *viewController;

- (id) initWithTableViewFormContainer:(UITableView *) container inViewController:(UIViewController *) viewController;

@end
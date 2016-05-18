//
//  ViewController.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// This UITableView becomes our entire form from top to bottom
@property (weak, nonatomic) IBOutlet UITableView *tableViewFormContainer;

@property (nonatomic, strong) NSMutableArray* mArrFormContentIdentifiersOrder;

@property (nonatomic, strong) NSMutableDictionary* mDicFormContentTableData;

@end


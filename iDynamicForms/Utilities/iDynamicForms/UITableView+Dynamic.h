//
//  UITableView+Dynamic.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Dynamic)

- (NSIndexPath *) getIndexPathForKey: (NSString *) key withContentArray:(NSMutableArray *)mArrFormContentIdentifiersOrder;
- (BOOL) resetDataSource:(NSString *) forKey withContentArray:(NSMutableArray *)mArrFormContentIdentifiersOrder andContentDictionary:(NSMutableDictionary *)mDicFormContentTableData;

@end

//
//  UITableView+Dynamic.m
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "UITableView+Dynamic.h"
#import "FormPortionTableViewCellData.h"

@implementation UITableView (Dynamic)

/*
 * Get the indexPath of the Form TableView Cell when its correspondent key is given
 */
- (NSIndexPath *) getIndexPathForKey: (NSString *) key withContentArray:(NSMutableArray *)mArrFormContentIdentifiersOrder {
    NSInteger row = [mArrFormContentIdentifiersOrder indexOfObject:key];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    return indexPath;
}

/*
 * Clear out the dataSource already filled in data.
 * if "forKey" parameter sent nil, then it will clear out the whole UI.
 */
- (BOOL) resetDataSource:(NSString *) forKey withContentArray:(NSMutableArray *)mArrFormContentIdentifiersOrder andContentDictionary:(NSMutableDictionary *)mDicFormContentTableData {
    BOOL result = NO;
    int index = 0;
    for (NSString *inKey in mArrFormContentIdentifiersOrder) {
        if (forKey != nil) {
            if ([inKey isEqualToString:forKey]) {
                //  shouldResetControl flag might be reset to False by the CellForRowAtIndexPath method IF-Else blocks after clearing out the data in the UI.
                [((FormPortionTableViewCellData *)[mDicFormContentTableData objectForKey:inKey]) setResetControlUI:YES];
                NSIndexPath *indexPath = [self getIndexPathForKey:inKey withContentArray:mArrFormContentIdentifiersOrder];
                [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                result = YES;
                break;
            }
        } else {
            //  shouldResetControl flag might be reset to False by the CellForRowAtIndexPath method IF-Else blocks after clearing out the data in the UI.
            [((FormPortionTableViewCellData *)[mDicFormContentTableData objectForKey:inKey]) setResetControlUI:YES];
            result = YES;
        }
        index++;
    }
    
    if (forKey == nil) {
        [self reloadData];
    }
    
    return result;
}

@end

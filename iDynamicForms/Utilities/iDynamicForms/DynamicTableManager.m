//
//  DynamicTableManager.m
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "DynamicTableManager.h"
#import "FormPortionTableViewCellData.h"

@implementation DynamicTableManager
@synthesize mArrFormContentIdentifiersOrder;
@synthesize mDicFormContentTableData;

- (id)initWithContentIdentifiersArray:(NSMutableArray *)contentIdentifiers andContentDictionary:(NSMutableDictionary *)contentDictionary {
    self = [super init];
    if (self) {
        mArrFormContentIdentifiersOrder = contentIdentifiers;
        mDicFormContentTableData = contentDictionary;
    }
    
    return self;
}

- (id)initWithContentIdentifiersArray:(NSMutableArray *)contentIdentifiers andContentDictionary:(NSMutableDictionary *)contentDictionary initialFormContentAs:(FormPortionTableViewCellData *)object forKey:(NSString *)forKey {
    self = [super init];
    if (self) {
        mArrFormContentIdentifiersOrder = contentIdentifiers;
        mDicFormContentTableData = contentDictionary;
    }
    
    [self initiateFormContentWithObject:object forKey:forKey];
    
    return self;
}

/*
 * Initiate the datasource of the Form TableView with first data object of the dictionary for the given Key (which is ContentIdentifier of that cell).
 * We are maintaing an NSMutableArray to hold the order of the data object keys and NSMutableDictionary to hold the data objects for their
 * corresponding ContentIdentifier keys.
 */
- (BOOL) initiateFormContentWithObject:(FormPortionTableViewCellData *)object forKey:(NSString *) forKey {
    BOOL result = NO;
    if ([mArrFormContentIdentifiersOrder count] == 0) {
        mArrFormContentIdentifiersOrder = [[NSMutableArray alloc] initWithObjects:forKey, nil];
        mDicFormContentTableData = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObject:object] forKeys:[NSArray arrayWithObject:forKey]];
        result = YES;
    }
    
    return result;
}

/*
 * This method is used to add specific data object in between the DataSource, after a given data object (which specified by the key).
 * Basically this is the method we use to populate the whole dataSource after we initiate it useing "initiateFormContentWithObject" method.
 */
- (BOOL) insertAfterKey:(NSString *) key object:(FormPortionTableViewCellData *) object forKey:(NSString *) forKey {
    BOOL result = NO;
    if ([mArrFormContentIdentifiersOrder count] > 0) {
        int index = 0;
        for (NSString *inKey in mArrFormContentIdentifiersOrder) {
            index++;
            if ([inKey isEqualToString:key]) {
                [mArrFormContentIdentifiersOrder insertObject:forKey atIndex:index];
                [mDicFormContentTableData setObject:object forKey:forKey];
                result = YES;
                break;
            }
        }
    }
    return result;
}

/*
 * Remove data object which is in datasource of the Form TableView, for the given Key (which is ContentIdentifier of that cell).
 */
- (BOOL) removeObjectForKey:(NSString *) forKey {
    BOOL result = NO;
    int index = 0;
    for (NSString *inKey in mArrFormContentIdentifiersOrder) {
        if ([inKey isEqualToString:forKey]) {
            [mArrFormContentIdentifiersOrder removeObjectAtIndex:index];
            [mDicFormContentTableData removeObjectForKey:inKey];
            result = YES;
            break;
        }
        index++;
    }
    return result;
}

@end

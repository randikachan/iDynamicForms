//
//  DynamicTableManager.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FormPortionTableViewCellData.h"

@interface DynamicTableManager : NSObject

@property (weak, nonatomic) UITableView *formContainer;
@property (nonatomic, strong) NSMutableArray* mArrFormContentIdentifiersOrder;
@property (nonatomic, strong) NSMutableDictionary* mDicFormContentTableData;

- (id) initWithContentIdentifiersArray:(NSMutableArray *)contentIdentifiers
                  andContentDictionary:(NSMutableDictionary *)contentDictionary
                          andTableView:(UITableView *)formTableView;

- (id) initWithContentIdentifiersArray:(NSMutableArray *)contentIdentifiers
                  andContentDictionary:(NSMutableDictionary *)contentDictionary
                  initialFormContentAs:(FormPortionTableViewCellData *)object
                                forKey:(NSString *)forKey;

- (BOOL) initiateFormContentWithObject:(FormPortionTableViewCellData *)object forKey:(NSString *) forKey;

- (BOOL) insertAfterKey:(NSString *) key object:(FormPortionTableViewCellData *) object forKey:(NSString *) forKey;

- (BOOL) removeObjectForKey:(NSString *) forKey;

- (BOOL) resetDataSourceForKey:(NSString *) forKey;

- (NSIndexPath *) getIndexPathForKey: (NSString *) key;

- (FormPortionTableViewCellData *) getFormPortionCellDataForKey: (NSString *) forKey;

- (UITableViewCell *) getFormCellForKey:(NSString *)forKey forKindOfClass:(Class)aClass;

- (NSString *) getDataStringFromTextFieldForCellKey:(NSString *)forKey;

- (NSString *) getDataStringFromTextViewForCellKey:(NSString *)forKey;

- (BOOL) getBooleanFromSwitchForCellKey:(NSString *)forKey;
@end

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

@interface DynamicTableManager : NSObject <UITextFieldDelegate>

@property (weak, nonatomic) UITableView *formContainer;
// The toolbar to be rendered on top of keyboard
@property (strong, nonatomic) UIToolbar *toolbarForKeyboard;
@property (nonatomic, strong) NSMutableArray* mArrFormContentIdentifiersOrder;
@property (nonatomic, strong) NSMutableDictionary* mDicFormContentTableData;
@property (nonatomic, assign, getter=isSetTableViewCellsClearColor) BOOL setTableViewCellsClearColor;

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

- (FormPortionTableViewCellData *) getFormPortionCellDataAtIndex:(NSUInteger)itemIndex;

- (UITableViewCell *) generateFormCellForRowAtIndexPath:(NSIndexPath *) indexPath forFormContainer:(UITableView *)tableView;

- (void) setActionForUIControl:(UIControl *)control withData:(FormPortionTableViewCellData *)data forAction:(NSString *)action;

- (void) setActionsForTableViewCell:(UITableViewCell *)cell withMainUIControlDelegate:(id)mainUIControlDelegate forPrimaryActionsArr:(NSArray *)arrActions;

- (void) setActionForUIControl:(UIControl *)control withData:(FormPortionTableViewCellData *)data;

- (void) setActionForUIControl:(UIControl *)control forControlEvents:(UIControlEvents)controlEvents withData:(FormPortionTableViewCellData *)data;

- (UITableViewCell *) getFormCellForKey:(NSString *)forKey forKindOfClass:(Class)aClass;

- (void) keepInUserDefaults:(FormPortionTableViewCellData *)cellData forKey:(NSString *) forKey;

- (FormPortionTableViewCellData *) getCellDataFromUserDefaultsForKey:(NSString *)forKey;

- (NSString *) getDataStringFromTextFieldForCellKey:(NSString *)forKey;

- (NSString *) getDataStringFromTextViewForCellKey:(NSString *)forKey;

- (BOOL) getBooleanFromSwitchForCellKey:(NSString *)forKey;
@end

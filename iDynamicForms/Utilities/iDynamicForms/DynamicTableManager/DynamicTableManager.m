//
//  DynamicTableManager.m
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "DynamicTableManager.h"
#import "FormPortionTableViewCellData.h"
#import "HeadTitleTableViewCell.h"
#import "LinkTableViewCell.h"
#import "HintTableViewCell.h"
#import "TextViewTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "SwitchesTableViewCell.h"
#import "ButtonTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "SegmentedControlTableViewCell.h"
#import "IDynamicFormsConfig.h"

@implementation DynamicTableManager {
    NSString *currentCellID;
}

@synthesize mArrFormContentIdentifiersOrder;
@synthesize mDicFormContentTableData;
@synthesize formContainer;
@synthesize toolbarForKeyboard;
@synthesize setTableViewCellsClearColor;

- (id)initWithContentIdentifiersArray:(NSMutableArray *)contentIdentifiers
                 andContentDictionary:(NSMutableDictionary *)contentDictionary
                         andTableView:(UITableView *)formTableView {
    self = [super init];
    if (self) {
        mArrFormContentIdentifiersOrder = contentIdentifiers;
        mDicFormContentTableData = contentDictionary;
        self.formContainer = formTableView;
        self.setTableViewCellsClearColor = false;
    }
    
    return self;
}

- (id)initWithContentIdentifiersArray:(NSMutableArray *)contentIdentifiers
                 andContentDictionary:(NSMutableDictionary *)contentDictionary
                 initialFormContentAs:(FormPortionTableViewCellData *)object
                               forKey:(NSString *)forKey {
    self = [super init];
    if (self) {
        mArrFormContentIdentifiersOrder = contentIdentifiers;
        mDicFormContentTableData = contentDictionary;
    }
    
    [self initiateFormContentWithObject:object forKey:forKey];
    
    return self;
}

#pragma mark UITableViewCell cellForRowAtIndexPath
- (UITableViewCell *) generateFormCellForRowAtIndexPath:(NSIndexPath *) indexPath forFormContainer:(UITableView *)tableView {
    
    if (self.formContainer == tableView) {
        NSString *contentIdentifier = [[self mArrFormContentIdentifiersOrder] objectAtIndex:indexPath.row];
        FormPortionTableViewCellData *data = [[self mDicFormContentTableData] objectForKey:contentIdentifier];
        
        HeadTitleTableViewCell *cellHeadTitle               = nil;
        LinkTableViewCell *cellLink                         = nil;
        TextViewTableViewCell *cellTextView                 = nil;
        TextFieldTableViewCell *cellTextField               = nil;
        SwitchesTableViewCell *cellSwitch                   = nil;
        ButtonTableViewCell *cellBtn                        = nil;
        HintTableViewCell *cellHint                         = nil;
        EmptyTableViewCell *cellEmpty                       = nil;
        SegmentedControlTableViewCell *cellSegmentedControl = nil;
        
        static NSString *headTitleCellId            = @"HeadTitleTableViewCell";
        static NSString *linkCellId                 = @"LinkTableViewCell";
        static NSString *textViewCellId             = @"TextViewTableViewCell";
        static NSString *textFieldCellId            = @"TextFieldTableViewCell";
        static NSString *hintCellId                 = @"HintTableViewCell";
        static NSString *switchCellID               = @"SwitchesTableViewCell";
        static NSString *buttonCellID               = @"ButtonTableViewCell";
        static NSString *emptyCellID                = @"EmptyTableViewCell";
        static NSString *segmentedControlCellID     = @"SegmentedControlTableViewCell";
        
        if (data.type == TYPE_EMPTY) {
            cellEmpty = (EmptyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:emptyCellID];
            if (cellEmpty == nil || data.resetControlUI) {
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:emptyCellID owner:nil options:nil];
                cellEmpty = [nibs objectAtIndex:0];
                [cellEmpty setTag:data.tag];
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellEmpty setBackgroundColor:[UIColor clearColor]] : nil;
            
            [cellEmpty setTag:indexPath.row];
            return cellEmpty;
        } else if (data.type == TYPE_SEGMENTED) {
            cellSegmentedControl = (SegmentedControlTableViewCell *)[tableView dequeueReusableCellWithIdentifier:segmentedControlCellID];
            if (cellSegmentedControl == nil || data.resetControlUI) {
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:segmentedControlCellID owner:nil options:nil];
                cellSegmentedControl = [nibs objectAtIndex:0];
                [cellSegmentedControl setTag:data.tag];
                
                if ([data mArrSegmentedControlTitles] != nil && [[data mArrSegmentedControlTitles] count] > 1) {
                    [cellSegmentedControl.segmentedControl removeAllSegments];
                    for (int i = 0; i < [[data mArrSegmentedControlTitles] count]; i++) {
                        [cellSegmentedControl.segmentedControl
                         insertSegmentWithTitle:[[data mArrSegmentedControlTitles] objectAtIndex:i] atIndex:i animated:NO];
                    }
                    
                    [cellSegmentedControl.segmentedControl
                     setSelectedSegmentIndex:[[self getCellDataFromUserDefaultsForKey:data.contentIdentifier] intDataHolder]];
                }
                
                if (data.mainUIControlSelector) {
                    SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
                    if ([data.mainUIControlDelegate respondsToSelector:customSelector]) {
                        [cellSegmentedControl.segmentedControl addTarget:data.mainUIControlDelegate
                                                                  action:customSelector
                                                        forControlEvents:UIControlEventValueChanged];
                    }
                }
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellSegmentedControl setBackgroundColor:[UIColor clearColor]] : nil;
            
            [cellSegmentedControl setTag:indexPath.row];
            [cellSegmentedControl setNeedsDisplay];
            return cellSegmentedControl;
        } else if (data.type == TYPE_BUTTON) {
            cellBtn = (ButtonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
            if (cellBtn == nil || data.resetControlUI) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:buttonCellID owner:nil options:nil];
                cellBtn = [nib objectAtIndex:0];
                
                UIButton *button = (UIButton *) cellBtn.tblVwCellButton;
                if (data.mainUIControlSelector) {
                    SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
                    [button addTarget:data.mainUIControlDelegate action:customSelector forControlEvents:UIControlEventTouchUpInside];
                }
                
                [button setTag:data.tag];
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            [cellBtn.tblVwCellButton setTitle:data.title forState:UIControlStateNormal];
            [cellBtn bringSubviewToFront:cellBtn.tblVwCellButton];
            
            (self.isSetTableViewCellsClearColor) ? [cellBtn setBackgroundColor:[UIColor clearColor]] : nil;
            [cellBtn setTag:indexPath.row];
            [cellBtn setNeedsDisplay];
            return cellBtn;
        } else if (data.type == TYPE_HEAD_TITLE) {
            cellHeadTitle = (HeadTitleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:headTitleCellId];
            if (cellHeadTitle == nil || data.resetControlUI) {
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:headTitleCellId owner:nil options:nil];
                cellHeadTitle = [nibs objectAtIndex:0];
                
                if (data.title != nil && [data.title length] > 0) {
                    [cellHeadTitle.lblHeadTItle setText:data.title];
                }
                [cellHeadTitle.lblHeadTItle setTextColor:[UIColor redColor]];
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellHeadTitle setBackgroundColor:[UIColor clearColor]] : nil;
            [cellHeadTitle setTag:indexPath.row];
            [cellHeadTitle setNeedsDisplay];
            return cellHeadTitle;
        } else if (data.type == TYPE_HINT) {
            cellHint = (HintTableViewCell *)[tableView dequeueReusableCellWithIdentifier:hintCellId];
            if (cellHint == nil || data.resetControlUI) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:hintCellId owner:nil options:nil];
                cellHint = [nib objectAtIndex:0];
                
                if (data.title != nil && [data.title length] > 0) {
                    [cellHint.txtVwDescription setText:data.title];
                }
                
                [cellHint.txtVwDescription setEditable:data.isEnabled];
                [cellHint.txtVwDescription setSelectable:data.isEnabled];
                // [cellHint.txtVwDescription setScrollEnabled:data.isEnabled];
                
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellHint setBackgroundColor:[UIColor clearColor]] : nil;
            [cellHint setTag:indexPath.row];
            [cellHint setNeedsDisplay];
            
            return cellHint;
        } else if (data.type == TYPE_LINK) {
            cellLink = (LinkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:linkCellId];
            if (cellLink == nil || data.resetControlUI) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:linkCellId owner:nil options:nil];
                cellLink = [nib objectAtIndex:0];
                
                if (data.title != nil && [data.title length] > 0) {
                    [cellLink.btnLink setTitle:data.title forState:UIControlStateNormal];
                }
                [cellLink.btnLink setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                
                if (data.mainUIControlSelector) {
                    SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
                    if ([data.mainUIControlDelegate respondsToSelector:customSelector]) {
                        [cellLink.btnLink addTarget:data.mainUIControlDelegate
                                             action:customSelector
                                   forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellLink setBackgroundColor:[UIColor clearColor]] : nil;
            [cellLink setTag:indexPath.row];
            [cellLink setNeedsDisplay];
            return cellLink;
        } else if (data.type == TYPE_SWITCH) {
            cellSwitch = (SwitchesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:switchCellID];
            if (cellSwitch == nil || data.resetControlUI) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:switchCellID owner:nil options:nil];
                cellSwitch = [nib objectAtIndex:0];
                
                if (data.mainUIControlSelector) {
                    SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
                    if ([data.mainUIControlDelegate respondsToSelector:customSelector]) {
                        [cellSwitch.switchChoice addTarget:data.mainUIControlDelegate
                                                    action:customSelector
                                          forControlEvents:UIControlEventValueChanged];
                    }
                }
                
                [cellSwitch.switchChoice setTag:data.tag];
                
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            [cellSwitch.switchChoice setOn:[[self getCellDataFromUserDefaultsForKey:data.contentIdentifier] boolDataHolder]];
            [cellSwitch.switchChoice setEnabled:data.isEnabled];
            
            if (!data.isEnabled) {
                cellSwitch.switchChoice.tintColor = [UIColor lightGrayColor];
                cellSwitch.switchChoice.thumbTintColor = [UIColor lightGrayColor];
            }
            
            [cellSwitch.lblSwitchTitle setText:data.title];
            [cellSwitch.lblSwitchTitle setTextColor:[UIColor blackColor]];
            
            (self.isSetTableViewCellsClearColor) ? [cellSwitch setBackgroundColor:[UIColor clearColor]] : nil;
            [cellSwitch setTag:indexPath.row];
            [cellSwitch setNeedsDisplay];
            return cellSwitch;
        } else if (data.type == TYPE_TEXTAREA) {
            cellTextView = (TextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:textViewCellId];
            if (cellTextView == nil || data.resetControlUI) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:textViewCellId owner:nil options:nil];
                cellTextView = [nib objectAtIndex:0];
                
                [cellTextView.txtVwDescription setTag:data.tag];
                [cellTextView.txtVwDescription setEditable:data.isEnabled];
                // to use toolbarForKeyboard with a done button it must have been assigned at the time DynamicTableManager datasource is setup.
                if (data.mainUIControlDelegate) {
                    cellTextView.txtVwDescription.inputAccessoryView = self.toolbarForKeyboard;
                    cellTextView.txtVwDescription.delegate = data.mainUIControlDelegate;
                }

                [cellTextView.txtVwDescription setText:[[self getCellDataFromUserDefaultsForKey:data.contentIdentifier] stringDataHolder]];
                
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            [cellTextView.lblTitle setText:data.title];
            
            (self.isSetTableViewCellsClearColor) ? [cellTextView setBackgroundColor:[UIColor clearColor]] : nil;
            [cellTextView setTag:indexPath.row];
            [cellTextView setNeedsDisplay];
            return cellTextView;
        } else if (data.type == TYPE_TEXTFIELD) {
            cellTextField = (TextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:textFieldCellId];
            if (cellTextField == nil || data.resetControlUI) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:textFieldCellId owner:nil options:nil];
                cellTextField = [nib objectAtIndex:0];
                
                [cellTextField.txtFldDetail setTag:data.tag];
                cellTextField.txtFldDetail.delegate = data.mainUIControlDelegate;
                if (data.mainUIControlSelector) {
                    SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
                    if ([data.mainUIControlDelegate respondsToSelector:customSelector]) {
                        [cellTextField.txtFldDetail addTarget:data.mainUIControlDelegate
                                                       action:customSelector
                                             forControlEvents:UIControlEventEditingChanged];
                    }
                }
                
                [cellTextField.txtFldDetail setText:[[self getCellDataFromUserDefaultsForKey:data.contentIdentifier] stringDataHolder]];
                
                if (data.title != nil && [data.title length] > 0) {
                    [cellTextField.lblTitle setText:data.title];
                }
                [cellTextField.txtFldDetail setSecureTextEntry:[data isSecuredTextField]];
                
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellTextField setBackgroundColor:[UIColor clearColor]] : nil;
            [cellTextField setTag:indexPath.row];
            [cellTextField setNeedsDisplay];
            return cellTextField;
        }
    }
    return nil;
}

- (void) setActionForUIControl:(UIControl *)control withData:(FormPortionTableViewCellData *)data forAction:(NSString *)action {
    if (data.mainUIControlDelegate) {
        SEL customSelector = NSSelectorFromString(action);
        if ([data.mainUIControlDelegate respondsToSelector:customSelector]) {
            [control addTarget:data.mainUIControlDelegate action:customSelector forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void) setActionsForTableViewCell:(UITableViewCell *)cell
          withMainUIControlDelegate:(id)mainUIControlDelegate
               forPrimaryActionsArr:(NSArray *)arrActions {
    
    if (mainUIControlDelegate) {
        for (NSUInteger i = 0; i < [arrActions count]; i++) {
            SEL customSelector = NSSelectorFromString([arrActions objectAtIndex:i]);
            if ([mainUIControlDelegate respondsToSelector:customSelector]) {
                UIControl *control = [cell viewWithTag:i];
                if (control) {
                    [control addTarget:mainUIControlDelegate action:customSelector forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
    }
}

- (void) setActionForUIControl:(UIControl *)control withData:(FormPortionTableViewCellData *)data {
    if (data.mainUIControlSelector && data.mainUIControlDelegate) {
        SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
        if ([data.mainUIControlDelegate respondsToSelector:customSelector]) {
            [control addTarget:data.mainUIControlDelegate action:customSelector forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void) setActionForUIControl:(UIControl *)control
              forControlEvents:(UIControlEvents)controlEvents
                      withData:(FormPortionTableViewCellData *)data {
    
    if (data.mainUIControlSelector && data.mainUIControlDelegate) {
        SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
        if ([data.mainUIControlDelegate respondsToSelector:customSelector]) {
            [control addTarget:data.mainUIControlDelegate action:customSelector forControlEvents:controlEvents];
        }
    }
}

#pragma mark UITextField Delegate methods
- (void) textFieldDidBeginEditing:(UITextField *)textField {
    FormPortionTableViewCellData *cellData = [self getCellDataForGivenTag:(int)[textField tag]];
    currentCellID = [cellData contentIdentifier];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    FormPortionTableViewCellData *nextCellData = [self getNextTextFieldCellForGivenCurrentTextFieldCellKey:currentCellID];
    if (!nextCellData) { // which means there is no any textFields in the form so should hide the keyboard
        [formContainer scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                             atScrollPosition:UITableViewScrollPositionBottom
                                     animated:YES];
        [textField resignFirstResponder];
        return YES;
    } else {
        // Note: within the "generateFormCellForRowAtIndexPath" method, all the custom UITableViewCells have assigned
        // indexPath.row as the tag of the cell.
        NSUInteger tag = [mArrFormContentIdentifiersOrder indexOfObject:[nextCellData contentIdentifier]];
        [formContainer scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:tag inSection:0]
                             atScrollPosition:UITableViewScrollPositionTop
                                     animated:YES];
        TextFieldTableViewCell *nextTextField = (TextFieldTableViewCell *)[formContainer viewWithTag:tag];
        [nextTextField.txtFldDetail becomeFirstResponder];
        return NO;
    }
}

#pragma mark Form DataSource methods
/*
 * Initiate the datasource of the Form TableView with first data object of the dictionary for the given Key (which is ContentIdentifier of that cell).
 * We are maintaing an NSMutableArray to hold the order of the data object keys and NSMutableDictionary to hold the data objects for their
 * corresponding ContentIdentifier keys.
 */
- (BOOL)initiateFormContentWithObject:(FormPortionTableViewCellData *)object forKey:(NSString *)forKey {
    BOOL result = NO;
    if ([mArrFormContentIdentifiersOrder count] == 0) {
        mArrFormContentIdentifiersOrder = [[NSMutableArray alloc] initWithObjects:forKey, nil];
        mDicFormContentTableData = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObject:object]
                                                                        forKeys:[NSArray arrayWithObject:forKey]];
        result = YES;
    }
    
    return result;
}

/*
 * This method is used to add specific data object in between the DataSource, after a given data object (which specified by the key).
 * Basically this is the method we use to populate the whole dataSource after we initiate it useing "initiateFormContentWithObject" method.
 */
- (BOOL)insertAfterKey:(NSString *)key object:(FormPortionTableViewCellData *)object forKey:(NSString *)forKey {
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
- (BOOL)removeObjectForKey:(NSString *)forKey {
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

/*
 * Clear out the dataSource already filled in data.
 * if "forKey" parameter sent nil, then it will clear out the whole UI.
 */
- (BOOL)resetDataSourceForKey:(NSString *)forKey {
    BOOL result = NO;
    int index = 0;
    for (NSString *inKey in mArrFormContentIdentifiersOrder) {
        if (forKey != nil) {
            if ([inKey isEqualToString:forKey]) {
                //  shouldResetControl flag might be reset to False by the CellForRowAtIndexPath method IF-Else blocks after clearing out the data in the UI.
                [((FormPortionTableViewCellData *)[mDicFormContentTableData objectForKey:inKey]) setResetControlUI:YES];
                NSIndexPath *indexPath = [self getIndexPathForKey:inKey];
                [formContainer scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [formContainer reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
        [formContainer reloadData];
    }
    
    return result;
}

/*
 * Get the indexPath of the Form TableView Cell when its correspondent key is given
 */
- (NSIndexPath *)getIndexPathForKey:(NSString *)key {
    NSInteger row = [mArrFormContentIdentifiersOrder indexOfObject:key];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    return indexPath;
}

- (FormPortionTableViewCellData *)getFormPortionCellDataForKey:(NSString *)forKey {
    return [mDicFormContentTableData objectForKey:forKey];
}

- (FormPortionTableViewCellData *)getFormPortionCellDataAtIndex:(NSUInteger)itemIndex {
    if (itemIndex < [mArrFormContentIdentifiersOrder count]) {
        NSString *contentIdentifier = [mArrFormContentIdentifiersOrder objectAtIndex:itemIndex];
        if ([[mDicFormContentTableData allKeys] containsObject:contentIdentifier]) {
            // NSLog(@"contentId: %@", contentIdentifier);
            return [mDicFormContentTableData objectForKey:contentIdentifier];
        }
    }
    return nil;
}

- (FormPortionTableViewCellData *)getCellDataForGivenTag:(int)tag {
    FormPortionTableViewCellData *result;
    if ([mArrFormContentIdentifiersOrder count] > 0) {
        for (int i = 0; i < [mArrFormContentIdentifiersOrder count]; i++) {
            NSString *nextKey = mArrFormContentIdentifiersOrder[i];
            if ([((FormPortionTableViewCellData *)[mDicFormContentTableData objectForKey:nextKey]) tag] == tag) {
                result = [mDicFormContentTableData objectForKey:nextKey];
                break;
            }
        }
    }
    return result;
}

- (FormPortionTableViewCellData *)getNextTextFieldCellForGivenCurrentTextFieldCellKey:(NSString *)currentKey {
    FormPortionTableViewCellData *result;
    if ([mArrFormContentIdentifiersOrder count] > 0) {
        NSUInteger index = [mArrFormContentIdentifiersOrder indexOfObject:currentKey];
        // Array initiated from the index of the current TextFieldCell Key/ContentIdentifier
        for (int i = (int)index; i < [mArrFormContentIdentifiersOrder count]; i++) {
            NSString *nextKey = mArrFormContentIdentifiersOrder[i];
            // whichever cell that comes next just after the current Key, check its type if it's a TextField and then
            // return it.
            if (![nextKey isEqualToString:currentKey]) {
                FormPortionTableViewCellData *cellData = [mDicFormContentTableData objectForKey:nextKey];
                if (cellData.type == TYPE_TEXTFIELD) {
                    result = cellData;
                    break;
                }
            }
        }
    }
    return result;
}

- (UITableViewCell *)getFormCellForKey:(NSString *)forKey forKindOfClass:(Class)aClass {
    NSIndexPath *indexPath = [self getIndexPathForKey:forKey];
    if ([[formContainer cellForRowAtIndexPath:indexPath] isKindOfClass:aClass]) {
        return [formContainer cellForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}

#pragma mark Form Data Temporary Percistance methods
/*
 * Methods to maintain user entered data while UITableView reload
 * Note: Some properties have been defined within "FormPortionTableViewCellData" class to hold the UIControl of the Cell
 * related data. And also those are implemented to be compliant with the NSCoding protocol, so whenever we want we can
 * write "FormPortionTableViewCellData" objects to a file or transmitted to another process, perhaps over a network
 * For now I have added only 4 types of essential data holders, NSString, int, float, BOOL
 * Related StackOverflow answer: http://stackoverflow.com/questions/2315948/how-to-store-custom-objects-in-nsuserdefaults
 */
- (void)keepInUserDefaults:(FormPortionTableViewCellData *)cellData forKey:(NSString *)forKey {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cellData];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:forKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (FormPortionTableViewCellData *)getCellDataFromUserDefaultsForKey:(NSString *)forKey {
    if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:forKey]) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:forKey];
        if (data != NULL) {
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

#pragma mark - Data Accessor methods to Form UI (for the UITableViewCells, which are visible at the moment)
- (NSString *)getDataStringFromTextFieldForCellKey:(NSString *)forKey {
    TextFieldTableViewCell *cell = (TextFieldTableViewCell *)[self getFormCellForKey:forKey forKindOfClass:TextFieldTableViewCell.class];
    return (cell) ? [cell.txtFldDetail text] : nil ;
}

- (NSString *)getDataStringFromTextViewForCellKey:(NSString *)forKey {
    TextViewTableViewCell *cell = (TextViewTableViewCell *)[self getFormCellForKey:forKey forKindOfClass:TextViewTableViewCell.class];
    return (cell) ? [cell.txtVwDescription text] : nil ;
}

- (BOOL)getBooleanFromSwitchForCellKey:(NSString *)forKey {
    SwitchesTableViewCell *cell = (SwitchesTableViewCell *)[self getFormCellForKey:forKey forKindOfClass:SwitchesTableViewCell.class];
    return (cell) ? [cell.switchChoice isOn] : false ;
}

@end

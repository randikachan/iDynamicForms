//
//  ViewControllerFormDataSource.m
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "ViewControllerFormDataSource.h"
#import "ViewControllerFormConfig.h"
#import "DynamicTableManager.h"
#import "HeadTitleTableViewCell.h"
#import "LinkTableViewCell.h"
#import "HintTableViewCell.h"
#import "TextViewTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "SwitchesTableViewCell.h"
#import "ButtonTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "Config.h"

@interface ViewControllerFormDataSource () {
    DynamicTableManager *dynamicManager;
    NSMutableDictionary *dataDic;
    NSUserDefaults *userDefaults;
}

@end

@implementation ViewControllerFormDataSource
@synthesize setTableViewCellsClearColor;

- (id) initWithTableViewFormContainer:(UITableView *) container inViewController:(UIViewController *) viewController {
    self = [super init];
    if (self) {
        self.formContainer = container;
        self.viewController = viewController;
        self.setupDataSourceDone = false;
        self.setTableViewCellsClearColor = false;
        dataDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void) setupDataSourceForViewControllerWithConfiguration:(ViewControllerFormConfig *) config
                                   withDynamicTableManager:(DynamicTableManager *) manager {

    [[manager mArrFormContentIdentifiersOrder] removeAllObjects];
    [[manager mDicFormContentTableData] removeAllObjects];
    dynamicManager = manager;
    
    // Form title
    FormPortionTableViewCellData *dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_HEAD_TITLE;
    dataObj.type = TYPE_HEAD_TITLE;
    dataObj.contentIdentifier = CELL_HEAD_TITLE;
    dataObj.title = @"DynamicForm Heading";
    dataObj.cellHeight = CELL_HEAD_TITLE_HEIGHT;
    dataObj.uiState = YES;
    
    manager = [manager initWithContentIdentifiersArray:[manager mArrFormContentIdentifiersOrder]
                                  andContentDictionary:[manager mDicFormContentTableData]
                                  initialFormContentAs:dataObj forKey:CELL_HEAD_TITLE];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_FIRST_NAME;
    dataObj.type = TYPE_TEXTFIELD;
    dataObj.contentIdentifier = CELL_FIRST_NAME;
    dataObj.title = @"First Name:";
    dataObj.cellHeight = CELL_TEXT_FIELD_HEIGHT;
    dataObj.uiState = YES;
    dataObj.mainUIControlSelector = @"firstNameValueChanged:";
    dataObj.mainUIControlDelegate = self;
    
    [manager insertAfterKey:CELL_HEAD_TITLE object:dataObj forKey:CELL_FIRST_NAME];

    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_SECOND_NAME;
    dataObj.type = TYPE_TEXTFIELD;
    dataObj.contentIdentifier = CELL_SECOND_NAME;
    dataObj.title = @"Second Name:";
    dataObj.cellHeight = CELL_TEXT_FIELD_HEIGHT;
    dataObj.uiState = YES;
    dataObj.mainUIControlSelector = @"secondNameValueChanged:";
    dataObj.mainUIControlDelegate = self;
    
    [manager insertAfterKey:CELL_FIRST_NAME object:dataObj forKey:CELL_SECOND_NAME];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_EMAIL;
    dataObj.type = TYPE_TEXTFIELD;
    dataObj.contentIdentifier = CELL_EMAIL;
    dataObj.title = @"Email:";
    dataObj.cellHeight = CELL_TEXT_FIELD_HEIGHT;
    dataObj.uiState = YES;
    dataObj.mainUIControlSelector = @"emailValueChanged:";
    dataObj.mainUIControlDelegate = self;
    
    [manager insertAfterKey:CELL_SECOND_NAME object:dataObj forKey:CELL_EMAIL];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_PASSWORD;
    dataObj.type = TYPE_TEXTFIELD;
    dataObj.contentIdentifier = CELL_PASSWORD;
    dataObj.title = @"Password";
    dataObj.cellHeight = CELL_TEXT_FIELD_HEIGHT;
    dataObj.uiState = YES;
    dataObj.securedTextField = YES;
    dataObj.mainUIControlSelector = @"passwordValueChanged:";
    dataObj.mainUIControlDelegate = self;
    
    [manager insertAfterKey:CELL_EMAIL object:dataObj forKey:CELL_PASSWORD];
    
    dataObj = [self createSubscribeHint];
    
    [manager insertAfterKey:CELL_PASSWORD object:dataObj forKey:CELL_SUBSCRIBE_HINT];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_SUBSCRIBE;
    dataObj.type = TYPE_SWITCH;
    dataObj.contentIdentifier = CELL_SUBSCRIBE;
    dataObj.title = @"Subscribe to emails:";
    dataObj.cellHeight = CELL_SWITCH_HEIGHT;
    dataObj.uiState = YES;
    
    [manager insertAfterKey:CELL_SUBSCRIBE_HINT object:dataObj forKey:CELL_SUBSCRIBE];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_SIGN_UP_BUTTON;
    dataObj.type = TYPE_BUTTON;
    dataObj.contentIdentifier = CELL_SIGN_UP_BUTTON;
    dataObj.title = @"Sign Up";
    dataObj.cellHeight = CELL_BUTTON_HEIGHT;
    dataObj.uiState = YES;
    dataObj.mainUIControlSelector = @"formButtonAction:";
    dataObj.mainUIControlDelegate = self;
    
    [manager insertAfterKey:CELL_SUBSCRIBE object:dataObj forKey:CELL_SIGN_UP_BUTTON];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_EMPTY_CELL1;
    dataObj.type = TYPE_EMPTY;
    dataObj.contentIdentifier = CELL_EMPTY_CELL1;
    dataObj.cellHeight = CELL_EMPTY_HEIGHT;
    dataObj.uiState = YES;
    
    [manager insertAfterKey:CELL_SIGN_UP_BUTTON object:dataObj forKey:CELL_EMPTY_CELL1];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_EMPTY_CELL2;
    dataObj.type = TYPE_EMPTY;
    dataObj.contentIdentifier = CELL_EMPTY_CELL2;
    dataObj.cellHeight = CELL_EMPTY_HEIGHT;
    dataObj.uiState = YES;
    
    [manager insertAfterKey:CELL_EMPTY_CELL1 object:dataObj forKey:CELL_EMPTY_CELL2];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_TERMS_LINK;
    dataObj.type = TYPE_LINK;
    dataObj.contentIdentifier = CELL_TERMS_LINK;
    dataObj.title = @"Terms & Privacy Policy";
    dataObj.cellHeight = CELL_LINK_HEIGHT;
    dataObj.uiState = YES;
    dataObj.mainUIControlSelector = @"linkBtnActions:";
    dataObj.mainUIControlDelegate = self.viewController;
    
    [manager insertAfterKey:CELL_EMPTY_CELL2 object:dataObj forKey:CELL_TERMS_LINK];
    
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_EMPTY_CELL3;
    dataObj.type = TYPE_EMPTY;
    dataObj.contentIdentifier = CELL_EMPTY_CELL3;
    dataObj.cellHeight = 120.0;
    dataObj.uiState = YES;
    
    [manager insertAfterKey:CELL_TERMS_LINK object:dataObj forKey:CELL_EMPTY_CELL3];
    
    // In our form one of the dynamic behavior is, if user turns ON the subscribe switch then the message should be hidden
    if ([[self getCellDataFromUserDefaultsForKey:CELL_SUBSCRIBE] boolDataHolder]) {
        [dynamicManager removeObjectForKey:CELL_SUBSCRIBE_HINT];
    }
    
    self.setupDataSourceDone = true;
}

- (FormPortionTableViewCellData *) createSubscribeHint {
    FormPortionTableViewCellData *dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_SUBSCRIBE_HINT;
    dataObj.type = TYPE_HINT;
    dataObj.contentIdentifier = CELL_SUBSCRIBE_HINT;
    dataObj.title = @"Please subscribe to our monthly news letter and daily digest emails, it will be very useful to you, we can assure that!";
    dataObj.cellHeight = CELL_TEXT_VIEW_HEIGHT;
    dataObj.uiState = NO;
    
    return dataObj;
}

- (UITableViewCell *) tableView:(UITableView *)tableView formTableCellForRowAtIndexPath:(NSIndexPath *)indexPath withDynamicTableManager:(DynamicTableManager *)manager {

    if (self.formContainer == tableView && [self isSetupDataSourceDone]) {
        NSString *contentIdentifier = [[manager mArrFormContentIdentifiersOrder] objectAtIndex:indexPath.row];
        FormPortionTableViewCellData *data = [[manager mDicFormContentTableData] objectForKey:contentIdentifier];
        
        HeadTitleTableViewCell *cellHeadTitle     = nil;
        LinkTableViewCell *cellLink               = nil;
        TextViewTableViewCell *cellTextView       = nil;
        TextFieldTableViewCell *cellTextField     = nil;
        SwitchesTableViewCell *cellSwitch         = nil;
        ButtonTableViewCell *cellBtn              = nil;
        HintTableViewCell *cellHint               = nil;
        EmptyTableViewCell *cellEmpty             = nil;
        
        static NSString *headTitleCellId            = @"HeadTitleTableViewCell";
        static NSString *linkCellId                 = @"LinkTableViewCell";
        static NSString *textViewCellId             = @"TextViewTableViewCell";
        static NSString *textFieldCellId            = @"TextFieldTableViewCell";
        static NSString *hintCellId                 = @"HintTableViewCell";
        static NSString *switchCellID               = @"SwitchesTableViewCell";
        static NSString *buttonCellID               = @"ButtonTableViewCell";
        static NSString *emptyCellID                = @"EmptyTableViewCell";
        
        if (data.type == TYPE_EMPTY) {
            cellEmpty = (EmptyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:emptyCellID];
            if (cellEmpty == nil || data.resetControlUI) {
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:emptyCellID owner:nil options:nil];
                cellEmpty = [nibs objectAtIndex:0];
                [cellEmpty setTag:data.tag];
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellBtn setBackgroundColor:[UIColor clearColor]] : nil;
            
            return cellEmpty;
        } else if (data.type == TYPE_BUTTON) {
            cellBtn = (ButtonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:buttonCellID];
            if (cellBtn == nil || data.resetControlUI) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:buttonCellID owner:nil options:nil];
                cellBtn = [nib objectAtIndex:0];
                
                UIButton *button = (UIButton *) cellBtn.tblVwCellButton;
                if (data.mainUIControlSelector) {
                    SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
                    [button addTarget:data.mainUIControlDelegate action:customSelector forControlEvents:UIControlEventTouchUpInside];
                } else if ([self respondsToSelector:@selector(formButtonAction:)]) {
                    [button addTarget:self action:@selector(formButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
            
            (self.isSetTableViewCellsClearColor) ? [cellBtn setBackgroundColor:[UIColor clearColor]] : nil;
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
            
            (self.isSetTableViewCellsClearColor) ? [cellBtn setBackgroundColor:[UIColor clearColor]] : nil;
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
                        [cellLink.btnLink addTarget:data.mainUIControlDelegate action:customSelector forControlEvents:UIControlEventTouchUpInside];
                    }
                } else if ([self respondsToSelector:@selector(linkBtnActions:)]) {
                    [cellLink.btnLink addTarget:self action:@selector(linkBtnActions:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellBtn setBackgroundColor:[UIColor clearColor]] : nil;
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
                            [cellSwitch.switchChoice addTarget:data.mainUIControlDelegate action:@selector(customSelector) forControlEvents:UIControlEventValueChanged];
                    }
                } else if ([self respondsToSelector:@selector(changeSwitchState:)]) {
                    [cellSwitch.switchChoice addTarget:self action:@selector(changeSwitchState:) forControlEvents:UIControlEventValueChanged];
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
            
            (self.isSetTableViewCellsClearColor) ? [cellBtn setBackgroundColor:[UIColor clearColor]] : nil;
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
//                cellProblem.txtVwDescription.inputAccessoryView = self.toolbarForKeyboard;
//                cellProblem.txtVwDescription.delegate = self;
                
                [cellTextView.txtVwDescription setText:[[self getCellDataFromUserDefaultsForKey:data.contentIdentifier] stringDataHolder]];
                
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            [cellTextView.lblTitle setText:data.title];
            
            (self.isSetTableViewCellsClearColor) ? [cellBtn setBackgroundColor:[UIColor clearColor]] : nil;
            [cellTextView setTag:indexPath.row];
            [cellTextView setNeedsDisplay];
            return cellTextView;
        } else if (data.type == TYPE_TEXTFIELD) {
            cellTextField = (TextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:textFieldCellId];
            if (cellTextField == nil || data.resetControlUI) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:textFieldCellId owner:nil options:nil];
                cellTextField = [nib objectAtIndex:0];
                
                cellTextField.txtFldDetail.delegate = data.mainUIControlDelegate;
                if (data.mainUIControlSelector) {
                    SEL customSelector = NSSelectorFromString(data.mainUIControlSelector);
                    if ([data.mainUIControlDelegate respondsToSelector:customSelector]) {
                        [cellTextField.txtFldDetail addTarget:data.mainUIControlDelegate action:customSelector forControlEvents:UIControlEventEditingChanged];
                    }
                }
                
                [cellTextField.txtFldDetail setText:[[self getCellDataFromUserDefaultsForKey:data.contentIdentifier] stringDataHolder]];
                
                if (data.title != nil && [data.title length] > 0) {
                    [cellTextField.lblTitle setText:data.title];
                }
                [cellTextField.txtFldDetail setSecureTextEntry:[data isSecuredTextField]];
                
                [data setResetControlUI:NO];    //  This can be used to reset the content of this whole cell. Like it's been done in TYPE_TEXTAREA cells.
            }
            
            (self.isSetTableViewCellsClearColor) ? [cellBtn setBackgroundColor:[UIColor clearColor]] : nil;
            [cellTextField setTag:indexPath.row];
            [cellTextField setNeedsDisplay];
            return cellTextField;
        }
    } else {
        return nil;
    }
    return nil;
}

#pragma mark UI Control Actions
- (void) formButtonAction:(UIButton *) button {
    NSLog(@"formButtonAction");
    if (((int) [button tag]) == TAG_SIGN_UP_BUTTON) {
        NSLog(@"submit form: %@", [self collectData]);
    }
}

- (void) changeSwitchState:(UISwitch *) switchChoice {
    if (((int) [switchChoice tag]) == TAG_SUBSCRIBE) {
        FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_SUBSCRIBE];
        if ([switchChoice isOn]) {
            NSLog(@"switch turned ON!");
            [dynamicManager removeObjectForKey:CELL_SUBSCRIBE_HINT];
            [cellData setState:YES];
            [cellData setBoolDataHolder:YES];
        } else {
            NSLog(@"switch turned OFF!");
            [dynamicManager insertAfterKey:CELL_PASSWORD object:[self createSubscribeHint] forKey:CELL_SUBSCRIBE_HINT];
            [cellData setState:NO];
            [cellData setBoolDataHolder:NO];
        }
        [self keepInUserDefaults:cellData forKey:CELL_SUBSCRIBE];
    }
    [self.formContainer reloadData];
}

#pragma mark Form User Entered Data handling
- (NSDictionary *) collectData {
    NSString *email = [dynamicManager getDataStringFromTextFieldForCellKey:CELL_EMAIL];
    [dataDic setObject:email forKey:CELL_EMAIL];
    BOOL subscribe = [dynamicManager getBooleanFromSwitchForCellKey:CELL_SUBSCRIBE];
    [dataDic setObject:[NSNumber numberWithBool:subscribe]  forKey:CELL_SUBSCRIBE];
    return dataDic;
}

- (void)linkBtnActions:(UIButton *)sender {
    NSLog(@"link clicked");
}

- (void) signUpBtnAction {
    NSLog(@"sign up button clicked");
}

- (void) firstNameValueChanged:(UITextField *) sender {
    [dataDic setObject:[sender text] forKey:CELL_FIRST_NAME];
    FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_FIRST_NAME];
    cellData.stringDataHolder = [sender text];
    [self keepInUserDefaults:cellData forKey:CELL_FIRST_NAME];
//    NSLog(@"1 data: %@", [self getCellDataFromUserDefaultsForKey:CELL_FIRST_NAME]);
}

- (void) secondNameValueChanged:(UITextField *) sender {
    [dataDic setObject:[sender text] forKey:CELL_SECOND_NAME];
    
    FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_SECOND_NAME];
    cellData.stringDataHolder = [sender text];
    [self keepInUserDefaults:cellData forKey:CELL_SECOND_NAME];
}

- (void) emailValueChanged:(UITextField *) sender {
    [dataDic setObject:[sender text] forKey:CELL_EMAIL];
    FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_EMAIL];
    cellData.stringDataHolder = [sender text];
    [self keepInUserDefaults:cellData forKey:CELL_EMAIL];
}

- (void) passwordValueChanged:(UITextField *) sender {
    [dataDic setObject:[sender text] forKey:CELL_PASSWORD];
    FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_PASSWORD];
    cellData.stringDataHolder = [sender text];
    cellData.intDataHolder = 5;
    [self keepInUserDefaults:cellData forKey:CELL_PASSWORD];
    
    /* // how to fetch and use data demo. To print only data, have to set the flag.
    cellData = [self getCellDataFromUserDefaultsForKey:CELL_PASSWORD];
    [cellData setPrintData:YES];
    NSLog(@"1 data: %@", cellData);
    */
}

#pragma mark Methods to maintain user entered data while UITableView reload
- (void) keepInUserDefaults:(FormPortionTableViewCellData *)cellData forKey:(NSString *) forKey {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cellData];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:forKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (FormPortionTableViewCellData *) getCellDataFromUserDefaultsForKey:(NSString *)forKey {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:forKey];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end
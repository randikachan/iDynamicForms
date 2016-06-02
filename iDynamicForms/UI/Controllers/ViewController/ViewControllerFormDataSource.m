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
    BOOL showSignUpForm;
}

@end

@implementation ViewControllerFormDataSource

- (id) initWithTableViewFormContainer:(UITableView *) container inViewController:(UIViewController *) viewController {
    self = [super init];
    if (self) {
        self.formContainer = container;
        self.viewController = viewController;
        self.setupDataSourceDone = false;
        dataDic = [[NSMutableDictionary alloc] init];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:CELL_ONLY_SEGMENTEDCNTRL];
        [[NSUserDefaults standardUserDefaults] synchronize];
        showSignUpForm = true;
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
    dataObj.tag = TAG_SINGUP_OR_SINGIN_SEGMENTED_CONTROL;
    dataObj.type = TYPE_SEGMENTED;
    dataObj.contentIdentifier = CELL_ONLY_SEGMENTEDCNTRL;
    dataObj.mArrSegmentedControlTitles = [NSArray arrayWithObjects:@"Sign Up", @"Sign In", nil];
    dataObj.cellHeight = CELL_SEGMENTED_HEIGHT;
    dataObj.uiState = YES;
    dataObj.mainUIControlSelector = @"toggleSignUpAndSignInForms:";
    dataObj.mainUIControlDelegate = self;
    
    [manager insertAfterKey:CELL_HEAD_TITLE object:dataObj forKey:CELL_ONLY_SEGMENTEDCNTRL];
    
    if (showSignUpForm) {
    dataObj = [[FormPortionTableViewCellData alloc] init];
    dataObj.tag = TAG_FIRST_NAME;
    dataObj.type = TYPE_TEXTFIELD;
    dataObj.contentIdentifier = CELL_FIRST_NAME;
    dataObj.title = @"First Name:";
    dataObj.cellHeight = CELL_TEXT_FIELD_HEIGHT;
    dataObj.uiState = YES;
    dataObj.mainUIControlSelector = @"firstNameValueChanged:";
    dataObj.mainUIControlDelegate = self;
    
    [manager insertAfterKey:CELL_ONLY_SEGMENTEDCNTRL object:dataObj forKey:CELL_FIRST_NAME];

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
    if ([[dynamicManager getCellDataFromUserDefaultsForKey:CELL_SUBSCRIBE] boolDataHolder]) {
        [dynamicManager removeObjectForKey:CELL_SUBSCRIBE_HINT];
    }
    } else {
        dataObj = [[FormPortionTableViewCellData alloc] init];
        dataObj.tag = TAG_EMPTY_CELL1;
        dataObj.type = TYPE_EMPTY;
        dataObj.contentIdentifier = CELL_EMPTY_CELL1;
        dataObj.cellHeight = CELL_EMPTY_HEIGHT;
        dataObj.uiState = YES;
        
        [manager insertAfterKey:CELL_ONLY_SEGMENTEDCNTRL object:dataObj forKey:CELL_EMPTY_CELL1];
        
        dataObj = [[FormPortionTableViewCellData alloc] init];
        dataObj.tag = TAG_EMAIL;
        dataObj.type = TYPE_TEXTFIELD;
        dataObj.contentIdentifier = CELL_EMAIL;
        dataObj.title = @"Email:";
        dataObj.cellHeight = CELL_TEXT_FIELD_HEIGHT;
        dataObj.uiState = YES;
        dataObj.mainUIControlSelector = @"emailValueChanged:";
        dataObj.mainUIControlDelegate = self;
        
        [manager insertAfterKey:CELL_EMPTY_CELL1 object:dataObj forKey:CELL_EMAIL];
        
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
        
        dataObj = [[FormPortionTableViewCellData alloc] init];
        dataObj.tag = TAG_EMPTY_CELL2;
        dataObj.type = TYPE_EMPTY;
        dataObj.contentIdentifier = CELL_EMPTY_CELL2;
        dataObj.cellHeight = CELL_EMPTY_HEIGHT;
        dataObj.uiState = YES;
        
        [manager insertAfterKey:CELL_PASSWORD object:dataObj forKey:CELL_EMPTY_CELL2];
        
        dataObj = [[FormPortionTableViewCellData alloc] init];
        dataObj.tag = TAG_SIGN_UP_BUTTON;
        dataObj.type = TYPE_BUTTON;
        dataObj.contentIdentifier = CELL_SIGN_UP_BUTTON;
        dataObj.title = @"Sign Up";
        dataObj.cellHeight = CELL_BUTTON_HEIGHT;
        dataObj.uiState = YES;
        dataObj.mainUIControlSelector = @"formButtonAction:";
        dataObj.mainUIControlDelegate = self;
        
        [manager insertAfterKey:CELL_EMPTY_CELL2 object:dataObj forKey:CELL_SIGN_UP_BUTTON];
        
        dataObj = [[FormPortionTableViewCellData alloc] init];
        dataObj.tag = TAG_EMPTY_CELL3;
        dataObj.type = TYPE_EMPTY;
        dataObj.contentIdentifier = CELL_EMPTY_CELL3;
        dataObj.cellHeight = 450.0;
        dataObj.uiState = YES;
        
        [manager insertAfterKey:CELL_SIGN_UP_BUTTON object:dataObj forKey:CELL_EMPTY_CELL3];
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
        // If you want to do a lot of extra modifications and alterations to UITableViewCell and its included UIControls
        // then dig into the following method "generateFormCellForRowAtIndexPath" in DynamicTableManager class.
        UITableViewCell *cell = [manager generateFormCellForRowAtIndexPath:indexPath forFormContainer:tableView];
        if ([cell isKindOfClass:TextFieldTableViewCell.class]) {
            // You can do additional minor customization to the cell or UIControls within here, check it out uncommenting the
            // following line. For Example see the bellow:
            
            // [cell setBackgroundColor:[UIColor grayColor]];
            // [[((TextFieldTableViewCell *) cell) lblTitle] setBackgroundColor:[UIColor lightGrayColor]];
        }
        
        return cell;
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
        [dynamicManager keepInUserDefaults:cellData forKey:CELL_SUBSCRIBE];
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
    [dynamicManager keepInUserDefaults:cellData forKey:CELL_FIRST_NAME];
//    NSLog(@"1 data: %@", [self getCellDataFromUserDefaultsForKey:CELL_FIRST_NAME]);
}

- (void) secondNameValueChanged:(UITextField *) sender {
    [dataDic setObject:[sender text] forKey:CELL_SECOND_NAME];
    
    FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_SECOND_NAME];
    cellData.stringDataHolder = [sender text];
    [dynamicManager keepInUserDefaults:cellData forKey:CELL_SECOND_NAME];
}

- (void) emailValueChanged:(UITextField *) sender {
    [dataDic setObject:[sender text] forKey:CELL_EMAIL];
    FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_EMAIL];
    cellData.stringDataHolder = [sender text];
    [dynamicManager keepInUserDefaults:cellData forKey:CELL_EMAIL];
}

- (void) passwordValueChanged:(UITextField *) sender {
    [dataDic setObject:[sender text] forKey:CELL_PASSWORD];
    FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_PASSWORD];
    cellData.stringDataHolder = [sender text];
    cellData.intDataHolder = 5;
    [dynamicManager keepInUserDefaults:cellData forKey:CELL_PASSWORD];
    
    /* // how to fetch and use data demo. To print only data, have to set the flag.
    cellData = [self getCellDataFromUserDefaultsForKey:CELL_PASSWORD];
    [cellData setPrintData:YES];
    NSLog(@"1 data: %@", cellData);
    */
}

- (void) toggleSignUpAndSignInForms:(UISegmentedControl *) sender {
    if (sender.selectedSegmentIndex == 0) {
        showSignUpForm = true;
    } else {
        showSignUpForm = false;
    }
    FormPortionTableViewCellData *cellData = [dynamicManager getFormPortionCellDataForKey:CELL_ONLY_SEGMENTEDCNTRL];
    cellData.intDataHolder = (int)sender.selectedSegmentIndex;
    [dynamicManager keepInUserDefaults:cellData forKey:CELL_ONLY_SEGMENTEDCNTRL];
    
    // We call the setupDataSource method because we need to reset the data source based on showSignUpForm
    [self setupDataSourceForViewControllerWithConfiguration:nil withDynamicTableManager:dynamicManager];
    // Reload the Form with the newly set data source.
    [self.formContainer reloadData];
}
@end
//
//  Config.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <Foundation/Foundation.h>

// Tags for each interactive control within the cell.
#define TAG_HEAD_TITLE          1
#define TAG_SINGUP_OR_SINGIN_SEGMENTED_CONTROL 2
#define TAG_FIRST_NAME          3
#define TAG_SECOND_NAME         4
#define TAG_EMAIL               5
#define TAG_PASSWORD            6
#define TAG_SUBSCRIBE_HINT      7
#define TAG_SUBSCRIBE           8
#define TAG_TERMS_LINK          9
#define TAG_SIGN_UP_BUTTON      10
#define TAG_EMPTY_CELL1         11
#define TAG_EMPTY_CELL2         12
#define TAG_EMPTY_CELL3         13
#define TAG_SIGN_IN_BUTTON      14

// Cell content identifiers
#define CELL_HEAD_TITLE          @"HeadTitleTableViewCell"
#define CELL_ONLY_SEGMENTEDCNTRL @"SignUpORSignInTextFieldTableViewCell"
#define CELL_FIRST_NAME          @"FirstNameTextFieldTableViewCell"
#define CELL_SECOND_NAME         @"SecondNameTextFieldTableViewCell"
#define CELL_EMAIL               @"EmailTextFieldTableViewCell"
#define CELL_PASSWORD            @"PasswordTextFieldTableViewCell"
#define CELL_SUBSCRIBE_HINT      @"SubscribeHintTableViewCell"
#define CELL_SUBSCRIBE           @"SubscrubeSwitchTableViewCell"
#define CELL_TERMS_LINK          @"TermsLinkTableViewCell"
#define CELL_SIGN_UP_BUTTON      @"SignUpButtonTableViewCell"
#define CELL_EMPTY_CELL1         @"EmptyCell1TableViewCell"
#define CELL_EMPTY_CELL2         @"EmptyCell2TableViewCell"
#define CELL_EMPTY_CELL3         @"EmptyCell3TableViewCell"
#define CELL_SIGN_IN_BUTTON      @"SignInButtonTableViewCell"

// Height for each type of content cells
#define CELL_EMPTY_HEIGHT       30.0
#define CELL_BUTTON_HEIGHT      65.0
#define CELL_HEAD_TITLE_HEIGHT  44.0
#define CELL_HINT_HEIGHT        75.0
#define CELL_LINK_HEIGHT        30.0
#define CELL_SWITCH_HEIGHT      44.0
#define CELL_TEXT_VIEW_HEIGHT   80.0
#define CELL_TEXT_FIELD_HEIGHT  70.0
#define CELL_SEGMENTED_HEIGHT   44.0

#define CONTENT_ID              @"CONTENT_ID"
#define STR_PREFIX              @"strValue"
#define INT_PREFIX              @"intValue"
#define FLOAT_PREFIX            @"floatValue"
#define BOOL_PREFIX             @"boolValues"
@interface Config : NSObject

@end

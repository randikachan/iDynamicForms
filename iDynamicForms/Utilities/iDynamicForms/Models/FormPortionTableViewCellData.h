//
//  AppDelegate.h
//  iDynamicForms
//
//  Created by Kasun Randika on 5/10/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

// Basic types - you can define your own types depending on the section of the content you intend to put in within that Cell.
#define TYPE_HEAD_TITLE 1
#define TYPE_LINK       2
#define TYPE_HINT       3
#define TYPE_TEXTFIELD  4
#define TYPE_TEXTAREA   5
#define TYPE_SWITCH     6
#define TYPE_BUTTON     7
#define TYPE_EMPTY      8
#define TYPE_SEGMENTED  9

@interface FormPortionTableViewCellData : NSObject <NSCoding>

#pragma mark Cell Meta Data
@property (nonatomic, assign) int tag;
// Specific String ID will be assigned at the iniialization and it can be used to traverse the array of data objects
@property (nonatomic, strong) NSString *contentIdentifier;
@property (nonatomic, assign) int type; //  1 for title with switch, 2 for description, 3 for button

#pragma mark Cell-UIControl Configuration
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *subTitle2;
@property (nonatomic, strong) NSArray *mArrSegmentedControlTitles;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign, getter=isSecuredTextField) BOOL securedTextField;   // Whether a textField's text is secured text or not
@property (nonatomic, assign, getter=isEnabled) BOOL uiState;   // Switch enabled or disabled
@property (nonatomic, assign, getter=isTurnedOn) BOOL state;    // Switch ON/OFF
@property (nonatomic, assign, getter=isInvalid) BOOL validationError;   // True/False upon data validation
@property (nonatomic, assign, getter=shouldResetControl) BOOL resetControlUI;   // True/False upon data validation

#pragma mark Cell-UIControl actions and delegates
// can pass a custom selector(method) which will be assigned as the target of the UI Control within the cell
@property (nonatomic, strong) NSString *mainUIControlSelector;
@property (nonatomic,strong) id mainUIControlDelegate;
@property (nonatomic,strong) id UIKitUIControlDelegate; // to provide iOS API Delegate methods references.

#pragma mark Cell-UIControl user interactive data
@property (nonatomic, assign, getter=shouldPrintData) BOOL printData;
@property (nonatomic, strong) NSString* stringDataHolder;
@property (nonatomic, assign) int intDataHolder;
@property (nonatomic, assign) BOOL boolDataHolder;
@property (nonatomic, assign) float floatDataHolder;

@end

//
//  AppDelegate.h
//  iDynamicForms
//
//  Created by Kasun Randika on 5/10/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "FormPortionTableViewCellData.h"
#import "Config.h"

@implementation FormPortionTableViewCellData

#pragma mark Cell Meta Data
@synthesize tag;
@synthesize contentIdentifier;
@synthesize type;

#pragma mark Cell-UIControl Configuration
@synthesize title;
@synthesize subTitle;
@synthesize subTitle2;
@synthesize cellHeight;
@synthesize securedTextField;
@synthesize uiState;
@synthesize state;
@synthesize validationError;
@synthesize resetControlUI;

#pragma mark Cell-UIControl actions and delegates
@synthesize mainUIControlSelector;
@synthesize mainUIControlDelegate;

#pragma mark Cell-UIControl user interactive data
@synthesize printData;
@synthesize stringDataHolder;
@synthesize intDataHolder;
@synthesize floatDataHolder;
@synthesize boolDataHolder;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        // Decode properties, other class vars
        self.contentIdentifier = [aDecoder decodeObjectForKey:CONTENT_ID];
        self.stringDataHolder = [aDecoder decodeObjectForKey:STR_PREFIX];
        self.intDataHolder = [aDecoder decodeIntForKey:INT_PREFIX];
        self.floatDataHolder = [aDecoder decodeFloatForKey:FLOAT_PREFIX];
        self.boolDataHolder = [aDecoder decodeBoolForKey:BOOL_PREFIX];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    // Encode properties
    [encoder encodeObject:self.contentIdentifier forKey:CONTENT_ID];
    [encoder encodeObject:self.stringDataHolder forKey:STR_PREFIX];
    [encoder encodeInt:self.intDataHolder forKey:INT_PREFIX];
    [encoder encodeFloat:self.floatDataHolder forKey:FLOAT_PREFIX];
    [encoder encodeBool:self.boolDataHolder forKey:BOOL_PREFIX];
}

- (NSString *)description {
    NSMutableString *string;
    if (self.contentIdentifier && self.printData) {
        string = [NSMutableString stringWithFormat:@"\ncellID:%@ data: {\n\t\tintDataHolder: %d,\n\t\tstringDataHolder: %@,\n\t\tboolDataHolder: %d,\n\t\tfloatDataHolder: %f\n\t}\n}", self.contentIdentifier, intDataHolder, stringDataHolder, boolDataHolder, floatDataHolder];
    } else {
        string = [NSMutableString stringWithFormat:@"\nBASwitchData {\n\ttag: %ld,\n\tcontentIdentifier: %@,\n\ttype: %d,\n\ttitle: %@,\n\tsubTitle: %@,\n\tcellHeight: %f,\n\tuiState: %d,\n\tstate: %d,\n\tresetControlUI: %d,\n", (long)tag, contentIdentifier, type, title, subTitle, cellHeight, uiState, state, resetControlUI];
        [string appendString:[NSMutableString stringWithFormat:@"\tuiControlActions: {\n\t\tsetSelector: %@ atTarget: %@\n\t},", (mainUIControlSelector) ? mainUIControlSelector : @"nil", (mainUIControlDelegate) ? mainUIControlDelegate : @"nil"]];
        [string appendString:[NSMutableString stringWithFormat:@"\n\tcellUIControlDataState: {\n\t\tintDataHolder: %d,\n\t\tstringDataHolder: %@,\n\t\tboolDataHolder: %d,\n\t\tfloatDataHolder: %f\n\t}\n}", intDataHolder, stringDataHolder, boolDataHolder, floatDataHolder]];
    }
    
    return string;
}

@end
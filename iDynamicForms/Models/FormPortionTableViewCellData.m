//
//  AppDelegate.h
//  iDynamicForms
//
//  Created by Kasun Randika on 5/10/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "FormPortionTableViewCellData.h"

@implementation FormPortionTableViewCellData
@synthesize tag, contentIdentifier, type, title, subTitle, subTitle2, intDataHolder, cellHeight, mainUIControlSelector, mainUIControlDelegate, securedTextField, uiState, state, validationError, gpsEnabled, resetControlUI;

- (NSString *)description
{
    return [NSString stringWithFormat:
            @"BASwitchData {\ntag: %ld,\ncontentIdentifier: %@,\ntype: %d,\ntitle: %@,\nsubTitle: %@,\ncellHeight: %f, uiState: %d,\nstate: %d,\nresetControlUI: %d}\n", (long)tag, contentIdentifier, type, title, subTitle, cellHeight, uiState, state, resetControlUI];
}

@end

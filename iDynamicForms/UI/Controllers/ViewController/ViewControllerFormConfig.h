//
//  ViewControllerFormConfig.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerFormConfig : NSObject

@property (nonatomic, assign, getter=isThereFirstNameField) BOOL firstName;
@property (nonatomic, assign, getter=isThereSecondNameField) BOOL secondName;
@property (nonatomic, assign, getter=isThereSubscriptionField) BOOL subscription;
@property (nonatomic, assign, getter=isThereInfoMessageForSubscriptionField) BOOL infoMessageForSubscription;
@property (nonatomic, assign, getter=isThereSaveButtonField) BOOL saveButton;

@end

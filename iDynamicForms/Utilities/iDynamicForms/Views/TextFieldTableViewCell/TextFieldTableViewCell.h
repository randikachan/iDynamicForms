//
//  TextFieldTableViewCell.h
//  iDynamicForms
//
//  Created by Kasun Randika on 5/11/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDetail;

@end

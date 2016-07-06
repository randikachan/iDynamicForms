//
//  TextFieldTableViewCell.m
//  iDynamicForms
//
//  Created by Kasun Randika on 5/11/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell
@synthesize lblTitle, txtFldDetail;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

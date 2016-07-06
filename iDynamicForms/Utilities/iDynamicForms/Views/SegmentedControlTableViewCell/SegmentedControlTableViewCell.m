//
//  SegmentedControlTableViewCell.m
//  iDynamicForms
//
//  Created by Kasun Randika on 6/2/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import "SegmentedControlTableViewCell.h"

@implementation SegmentedControlTableViewCell
@synthesize segmentedControl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

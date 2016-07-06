//
//  BASwitchesTableViewCell.h
//  DynamicTableView
//
//  Created by Kasun Randika on 5/9/16.
//  Copyright © 2016 Kasun Randika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblSwitchTitle;
@property (weak, nonatomic) IBOutlet UISwitch *switchChoice;

@end

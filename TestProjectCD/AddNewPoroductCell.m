//
//  AddNewPoroductCell.m
//  TestProjectCD
//
//  Created by Roma on 14.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "AddNewPoroductCell.h"

@implementation AddNewPoroductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addNewPurchase:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addPurchase"object:nil];
}
@end

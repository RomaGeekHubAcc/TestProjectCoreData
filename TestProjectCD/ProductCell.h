//
//  ProductCell.h
//  TestProjectCD
//
//  Created by Roma on 14.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@end

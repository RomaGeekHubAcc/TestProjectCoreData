//
//  StartVC.h
//  TestProjectCD
//
//  Created by Roma on 13.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartVC : UIViewController <UITableViewDelegate>
{
    NSArray *purchases;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)addPurchase:(id)sender;

@end

//
//  CurrentPurchaseViewController.h
//  TestProjectCD
//
//  Created by Roma on 14.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//


#import "AddPurchaseVC.h"
@class CDPurchase;


@interface CurrentPurchaseViewController : UITableViewController <UIAlertViewDelegate, AddPurchaseVCDelegate>

@property (nonatomic) BOOL isAddingOrder;
@property (nonatomic) NSMutableArray *purchases;

@end

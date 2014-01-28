//
//  AddPurchaseVC.h
//  TestProjectCD
//
//  Created by Roma on 13.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "ProductsViewController.h"

@class AddPurchaseVC;
@class CDProduct;
@class CDPurchase;

@protocol AddPurchaseVCDelegate <NSObject>

-(void) addPurchaseViewController:(AddPurchaseVC*)addPurchaseVC didCreateCDPurchase:(CDPurchase*)purchase;

@end


@interface AddPurchaseVC : UIViewController <UITextFieldDelegate, UITextViewDelegate, ProductsViewControllerDelegate>
{
    __weak IBOutlet UITextView *purchaseDescriptionTV;
    __weak IBOutlet UITextField *countPurchaseTF;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIButton *productNameOutlet;
}

@property (nonatomic) CDProduct *choosenProduct;
@property id <AddPurchaseVCDelegate> delegate;

- (IBAction)productName:(id)sender;


@end

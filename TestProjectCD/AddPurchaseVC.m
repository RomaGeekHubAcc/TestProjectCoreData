//
//  AddPurchaseVC.m
//  TestProjectCD
//
//  Created by Roma on 13.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "AddPurchaseVC.h"

#import "DataManager.h"
#import "ProductsViewController.h"
#import "CurrentPurchaseViewController.h"
#import "CDProduct.h"


#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size


@interface AddPurchaseVC ()

@end


@implementation AddPurchaseVC

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    purchaseDescriptionTV.delegate = self;
    countPurchaseTF.delegate = self;
    
    [scrollView layoutIfNeeded];
    scrollView.contentSize = contentView.bounds.size;
    
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPurchase:)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
}


#pragma mark - Action methods

- (IBAction)productName:(id)sender {
    ProductsViewController *productVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsViewController"];
    productVC.delegate = self;
    
    [self.navigationController pushViewController:productVC
                                         animated:YES];
}

-(void) addPurchase:(UIBarButtonItem*)sender {
    if (_choosenProduct && countPurchaseTF.text.length > 0) {
        
        if ([self.delegate respondsToSelector:@selector(addPurchaseViewController:didCreateCDPurchase:)]) {
            double count = [countPurchaseTF.text doubleValue];
            CDPurchase *purchase = [[DataManager sharedDataManager] createCDPurchaseWithProduct:_choosenProduct
                                                                                          count:count
                                                                                       totalSum:[self getTotalSumFromCount:count
                                                                            andPrice:_choosenProduct.productPrice]];
            [self.delegate addPurchaseViewController:self
                                 didCreateCDPurchase:purchase];
        }
        
        [self popToPreviousViewController];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Не всі потрібні поля вибрані!"
                                                       message:@"Виберіть назву продукту й вкажіть кількість"
                                                      delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}


#pragma mark - Delegated Methods

#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (SCREEN_SIZE.height == 480) {
        [scrollView setContentOffset:CGPointMake(0, 0)
                            animated:YES];
    }
    return YES;
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    if (SCREEN_SIZE.height == 480) {
        [scrollView setContentOffset:CGPointMake(0, 80)
                            animated:YES];
    }
    
    return YES;
}


#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (SCREEN_SIZE.height == 480) {
        [scrollView setContentOffset:CGPointMake(0, 120)
                            animated:YES];
    }
    else if (SCREEN_SIZE.height > 480) {
        [scrollView setContentOffset:CGPointMake(0, 50)
                            animated:YES];
    }
    
    textView.backgroundColor = [UIColor whiteColor];
    textView.text = @"";
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        if (SCREEN_SIZE.height == 480) {
            [scrollView setContentOffset:CGPointMake(0, 0)
                                animated:YES];
        }
    }
    return YES;
}


#pragma mark - Protocol methods

-(void) productViewController:(ProductsViewController *)sender didSelectProduct:(CDProduct *)product {
    _choosenProduct = product;
    [productNameOutlet setTitle:_choosenProduct.productName
                       forState:UIControlStateNormal];
    
}


#pragma mark - Private methods

-(void) popToPreviousViewController {
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[CurrentPurchaseViewController class]]) {
            [[self navigationController] popToViewController:obj
                                                    animated:YES];
            return;
        }
    }
}
                                                                            
-(NSDecimalNumber*) getTotalSumFromCount:(double)count andPrice:(NSDecimalNumber*)prise {
    return [[[NSDecimalNumber alloc]initWithDouble:count] decimalNumberByMultiplyingBy:prise];
}
                                                                              
@end

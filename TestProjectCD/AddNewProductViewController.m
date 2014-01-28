//
//  AddNewProductViewController.m
//  TestProjectCD
//
//  Created by Roma on 16.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "AddNewProductViewController.h"
#import "DataManager.h"

@interface AddNewProductViewController ()

@property (weak, nonatomic) IBOutlet UITextField *productNameTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@implementation AddNewProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.productNameTF.delegate = self;
    self.priceTF.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action methods

- (IBAction)save:(id)sender {
    
    NSDecimalNumber *price = [[NSDecimalNumber alloc]initWithDouble:[_priceTF.text doubleValue]];
    NSString *prodName = _productNameTF.text;
    if (prodName.length < 2 || [_priceTF.text doubleValue] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Не всі потрібні поля вибрані!"
                                                       message:@"Виберіть назву продукту й вкажіть кількість"
                                                      delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    CDProduct *product = [[DataManager sharedDataManager] createCDProductWithProductName:prodName price:price note:@"Lorem ipsum"];
    [[DataManager sharedDataManager] insertNewCDProduct:product];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

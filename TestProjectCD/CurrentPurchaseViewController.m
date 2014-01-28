//
//  CurrentPurchaseViewController.m
//  TestProjectCD
//
//  Created by Roma on 14.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "CurrentPurchaseViewController.h"
#import "ProductCell.h"
#import "TotalSumCell.h"
#import "AddNewPoroductCell.h"
#import "CDPurchase.h"
#import "CDProduct.h"
#import "CDOrder.h"
#import "AddPurchaseVC.h"
#import "DataManager.h"


@interface CurrentPurchaseViewController ()
{
    CDPurchase *cdPurchase;
    NSDecimalNumber *totalSum;
    NSString *shopName;
    UIBarButtonItem *save;
}

@end



@implementation CurrentPurchaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    totalSum = [[NSDecimalNumber alloc]initWithDouble:0.00];
    
    if (_isAddingOrder) {
        _purchases = [NSMutableArray array];
        
        [_purchases addObject:totalSum];
        
        save = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
        self.navigationItem.rightBarButtonItem = save;
    }
    else {
        [self totalSumForPurchases];
        [_purchases addObject:totalSum];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushAddPurchaseVC) name:@"addPurchase" object:nil];
    
    if (_isAddingOrder) {
        if ([totalSum doubleValue] == 0) {
            save.enabled = NO;
        }
        else {
            save.enabled = YES;
        }
        if (!shopName) {
            [self showAlertInputShopName];
        }
    }
    
    NSIndexPath* ip = [NSIndexPath indexPathForRow:_purchases.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"addPurchase" object:nil];
}


#pragma mark - Action methods

-(void) save:(UIBarButtonItem*)sender {
    [[DataManager sharedDataManager] insertNewOrderWithArrayOfCDPurchases:_purchases shopName:shopName totalPrice:totalSum];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private methods

- (void)showAlertInputShopName {
    UIAlertView *inputShopNameAlert = [[UIAlertView alloc]initWithTitle:nil
                                                    message:@"Input shop name"
                                                    delegate:self cancelButtonTitle:nil
                                                      otherButtonTitles:@"Done", nil];
    inputShopNameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [inputShopNameAlert show];
}

-(void) pushAddPurchaseVC {
    AddPurchaseVC *addPurchaseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPurchaseVC"];
    addPurchaseVC.delegate = self;
    [self.navigationController pushViewController:addPurchaseVC animated:YES];
}

-(void) totalSumForPurchases {
    NSDecimalNumber *sum = [[NSDecimalNumber alloc]initWithDouble:0.00];
    for (int i = 0; i <_purchases.count - 1; i++) {
        if ([[_purchases objectAtIndex:i] isKindOfClass:[CDPurchase class]]) {
            CDPurchase *currentPurchse = [_purchases objectAtIndex:i];
            sum = [sum decimalNumberByAdding:currentPurchse.totalSum];
        }
    }
    totalSum = sum;
}

#pragma mark - Delegated Methods

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.isAddingOrder) {
        return _purchases.count;
    }
    return _purchases.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    UITableViewCell *cell;
    
    if (indexPath.row == _purchases.count - 1) {
        CellIdentifier = @"TotalSumCell";
        
        TotalSumCell *totalCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        totalCell.totalSumLabel.text = [NSString stringWithFormat:@"Total: %0.2f", [totalSum doubleValue]];
        cell = totalCell;
    }
    else if (indexPath.row == _purchases.count && self.isAddingOrder) {
        CellIdentifier = @"AddNewPoroductCell";
        
        AddNewPoroductCell *addNewProdCell = [tableView dequeueReusableCellWithIdentifier:@"AddNewPoroductCell"];
        cell = addNewProdCell;
    }
    else {
        ProductCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
        CDPurchase * purchase = [_purchases objectAtIndex:indexPath.row];
        productCell.productNameLabel.text = purchase.products.productName;
        productCell.countLabel.text = [NSString stringWithFormat:@"Count: %0.1f", [purchase.count doubleValue]];
        productCell.sumLabel.text = [NSString stringWithFormat:@"Sum: %0.2f", [purchase.totalSum doubleValue]];
        
        cell = productCell;
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _purchases.count && self.isAddingOrder) {
        AddPurchaseVC *addPurchaseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPurchaseVC"];
        [self.navigationController pushViewController:addPurchaseVC animated:YES];
    }
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        shopName = [[alertView textFieldAtIndex:0] text];
        self.title = shopName;
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {

    if ([[[alertView textFieldAtIndex:0] text] length] > 1) {
        return YES;
    }
    return NO;
}


#pragma mark - Protocol methods

-(void)addPurchaseViewController:(AddPurchaseVC *)addPurchaseVC didCreateCDPurchase:(CDPurchase *)purchase {
    if (_purchases.count > 1) {
        [_purchases insertObject:purchase atIndex:_purchases.count - 2];
    }
    else {
        [_purchases insertObject:purchase atIndex:0];
    }
    [self totalSumForPurchases];
    
    [self.tableView reloadData];
}

@end

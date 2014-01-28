//
//  ProductsViewController.m
//  TestProjectCD
//
//  Created by Roma on 14.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "ProductsViewController.h"

#import "ChooseProductCell.h"
#import "AddPurchaseVC.h"
#import "DataManager.h"
#import "CDProduct.h"
#import "AddNewProductViewController.h"


@interface ProductsViewController ()
{
    NSArray *products;
}
@end


@implementation ProductsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addNewProduct = [[UIBarButtonItem alloc]initWithTitle:@"Add New Product" style:UIBarButtonItemStyleBordered target:self action:@selector(addNewProduct:)];
    self.navigationItem.rightBarButtonItem = addNewProduct;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    products = [[DataManager sharedDataManager] getAllCDProducts];
    [self.tableView reloadData];
}


#pragma mark - Action methods

-(void) addNewProduct:(UIBarButtonItem*)sender {
    AddNewProductViewController *addNewProdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewProductViewController"];
    [self.navigationController presentViewController:addNewProdVC animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChooseProductCell";
    ChooseProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CDProduct *product = [products objectAtIndex:indexPath.row];
    cell.label.text = product.productName;
    cell.priceLabel.text = [NSString stringWithFormat:@"price: %0.2f grn.", [product.productPrice doubleValue]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(productViewController:didSelectProduct:)]) {
        [self.delegate productViewController:self didSelectProduct:products [indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end

//
//  StartVC.m
//  TestProjectCD
//
//  Created by Roma on 13.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "StartVC.h"
#import "AddPurchaseVC.h"
#import "DataSource.h"
#import "CurrentPurchaseViewController.h"
#import "CDOrder.h"

@interface StartVC ()
{
    DataSource *dataSource;
}

@end

@implementation StartVC


- (void) viewDidLoad
{
    [super viewDidLoad];
	
    _tableView.delegate = self;
    dataSource = [[DataSource alloc]init];
    _tableView.dataSource = dataSource;
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [dataSource reloadData];
    [_tableView reloadData];
}


#pragma mark - Action Methods

- (IBAction) addPurchase:(id)sender {
    CurrentPurchaseViewController *currentPurchaseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentPurchaseViewController"];
    currentPurchaseVC.isAddingOrder = YES;
    [self.navigationController pushViewController:currentPurchaseVC animated:YES];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CurrentPurchaseViewController *currentPurchaseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrentPurchaseViewController"];
    
    
    NSArray *orders = [dataSource getArrayWithOrders];
    CDOrder *neededOrder = [orders objectAtIndex:indexPath.row];
    NSMutableArray *purchasesMutable = [[NSMutableArray alloc]initWithArray:[neededOrder.purchases allObjects]];
    
    currentPurchaseVC.purchases =  purchasesMutable;
    currentPurchaseVC.isAddingOrder = NO;
    
    [self.navigationController pushViewController:currentPurchaseVC animated:YES];
}

@end

//
//  DataSource.m
//  TestProjectCD
//
//  Created by Roma on 14.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "DataSource.h"

#import "CDPurchase.h"
#import "HistoryCell.h"
#import "DataManager.h"
#import "CDOrder.h"


@interface DataSource ()
{
    NSArray *orders;
    NSDateFormatter *dateFormatter;
}
@end


@implementation DataSource

- (id) init {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    [self reloadData];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd  HH:mm:ss ZZZ"];
    
    return self;
}

#pragma mark - Interface methods

-(void) reloadData {
    orders = [[DataManager sharedDataManager] getAllOrders];
}

#pragma mark - Delegated Methods

#pragma mark - tableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return orders.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CDOrder *order = [orders objectAtIndex:indexPath.row];
    
    cell.shopNameLabel.text = [NSString stringWithFormat:@"Магазин \"%@\"", order.shopName];
    cell.totalSumLabel.text = [NSString stringWithFormat:@"Sum: %0.2f",[order.totalPrice doubleValue]];
    cell.purchaseDateLabel.text = [dateFormatter stringFromDate:order.orderDate];
    
    return cell;
}

#pragma mark Public methods 

-(NSArray*) getArrayWithOrders {
    return orders;
}

@end

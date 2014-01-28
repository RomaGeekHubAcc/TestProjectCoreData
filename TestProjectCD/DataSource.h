//
//  DataSource.h
//  TestProjectCD
//
//  Created by Roma on 14.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject <UITableViewDataSource>

-(void) reloadData;

-(NSArray*) getArrayWithOrders;

@end

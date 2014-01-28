//
//  CDPurchase.h
//  TestProjectCD
//
//  Created by Roma on 15.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDOrder, CDProduct;

@interface CDPurchase : NSManagedObject

@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSDecimalNumber * totalSum;
@property (nonatomic, retain) CDOrder *order;
@property (nonatomic, retain) CDProduct *products;

@end

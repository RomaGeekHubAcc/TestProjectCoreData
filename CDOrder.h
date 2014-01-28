//
//  CDOrder.h
//  TestProjectCD
//
//  Created by Roma on 15.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDPurchase;

@interface CDOrder : NSManagedObject

@property (nonatomic, retain) NSDate * orderDate;
@property (nonatomic, retain) NSString * shopName;
@property (nonatomic, retain) NSDecimalNumber * totalPrice;
@property (nonatomic, retain) NSSet *purchases;
@end

@interface CDOrder (CoreDataGeneratedAccessors)

- (void)addPurchasesObject:(CDPurchase *)value;
- (void)removePurchasesObject:(CDPurchase *)value;
- (void)addPurchases:(NSSet *)values;
- (void)removePurchases:(NSSet *)values;

@end

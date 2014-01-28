//
//  CDProduct.h
//  TestProjectCD
//
//  Created by Roma on 15.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDPurchase;

@interface CDProduct : NSManagedObject

@property (nonatomic, retain) NSString * productDescription;
@property (nonatomic, retain) NSDecimalNumber * productPrice;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSSet *sell;
@end

@interface CDProduct (CoreDataGeneratedAccessors)

- (void)addSellObject:(CDPurchase *)value;
- (void)removeSellObject:(CDPurchase *)value;
- (void)addSell:(NSSet *)values;
- (void)removeSell:(NSSet *)values;

@end

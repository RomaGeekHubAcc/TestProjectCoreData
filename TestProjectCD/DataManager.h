//
//  DataManager.h
//  TestProjectCD
//
//  Created by Roma on 13.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CDPurchase;
@class CDProduct;



@interface DataManager : NSObject

+(DataManager*) sharedDataManager;

-(NSArray*) getAllOrders;
-(NSArray*) getAllCDProducts;

-(CDPurchase*) createCDPurchaseWithProduct:(CDProduct*)product count:(double)count totalSum:(NSDecimalNumber*)sum;
-(CDProduct*) createCDProductWithProductName:(NSString*)name price:(NSDecimalNumber*)price note:(NSString*)note;
-(void) insertNewOrderWithArrayOfCDPurchases:(NSArray*)purchases shopName:(NSString*)shopName totalPrice:(NSDecimalNumber*)price;
-(void) insertNewCDProduct:(CDProduct*)product;

@end

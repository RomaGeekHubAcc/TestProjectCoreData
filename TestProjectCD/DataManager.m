//
//  DataManager.m
//  TestProjectCD
//
//  Created by Roma on 13.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "DataManager.h"

#import "CDPurchase.h"
#import "CDOrder.h"
#import "CDProduct.h"
#import "Utilities.h"


@interface DataManager ()
{
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}
@end


@implementation DataManager

+ (DataManager*)sharedDataManager {
    static DataManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[DataManager alloc]init];
    });
    
    return __sharedInstance;
}

- (NSArray *)getAllOrders {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[[CDOrder class] description] inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSError *error = nil;
    NSArray *orders = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return orders;
}

-(NSArray*) getAllCDProducts {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[[CDProduct class] description] inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSError *error = nil;
    NSArray *products = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (products.count == 0) {
        [self insertSomeCDProductsOnStart];
        products = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }
    
    return products;
}

-(void) insertNewOrderWithArrayOfCDPurchases:(NSArray*)purchases shopName:(NSString*)shopName totalPrice:(NSDecimalNumber*)price {
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[[CDOrder class] description] inManagedObjectContext:self.managedObjectContext];
    
    CDOrder *order = [[CDOrder alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    
    order.orderDate = [NSDate date];
    order.shopName  = shopName;
    order.totalPrice = price;
    
    for (int i = 0; i < purchases.count; i++) {
        if ([[purchases objectAtIndex:i] isKindOfClass:[CDPurchase class]]) {
            CDPurchase *currentPurchase = [purchases objectAtIndex:i];
            currentPurchase.order = order;
        }
    }
    
    NSError *error = nil;

    if (![self.managedObjectContext save:&error]) {
        NSLog(@" --- insert new Order error —> %@", error);
    }
}

-(CDPurchase*) createCDPurchaseWithProduct:(CDProduct*)product count:(double)count totalSum:(NSDecimalNumber*)sum {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[[CDPurchase class] description] inManagedObjectContext:self.managedObjectContext];
    CDPurchase *purchase = [[CDPurchase alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    
    purchase.totalSum = sum;
    purchase.count = [NSNumber numberWithDouble:count];
    purchase.products = product;
    
    return purchase;
}

- (CDProduct*) createCDProductWithProductName:(NSString*)name price:(NSDecimalNumber*)price note:(NSString*)note {
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[[CDProduct class] description] inManagedObjectContext:self.managedObjectContext];
    CDProduct *newProduct = [[CDProduct alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    
    newProduct.productDescription = note;
    newProduct.productPrice = price;
    newProduct.productName = name;
    
    return newProduct;
}

-(void) insertNewCDProduct:(CDProduct*)product {
    NSError *error;
    if (![_managedObjectContext save:&error]) {
        NSLog(@" --- insert new Product error —> %@", error);
    }
}


#pragma mark - Private methods

-(void) insertSomeCDProductsOnStart {
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:[[CDProduct class] description] inManagedObjectContext:self.managedObjectContext];
    
    CDProduct *p1 = [[CDProduct alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    p1.productDescription = @"Lorem ipsum";
    p1.productName = @"Хліб";
    p1.productPrice = [Utilities getDecimalNumberFromDoubleValue:3.50];
    
    CDProduct *p2 = [[CDProduct alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    p2.productDescription = @"Lorem ipsum";
    p2.productName = @"Масло";
    p2.productPrice = [Utilities getDecimalNumberFromDoubleValue:7.50];
    
    CDProduct *p3 = [[CDProduct alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    p3.productDescription = @"Lorem ipsum";
    p3.productName = @"Рис";
    p3.productPrice = [Utilities getDecimalNumberFromDoubleValue:12.00];
    
    CDProduct *p4 = [[CDProduct alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    p4.productDescription = @"Lorem ipsum";
    p4.productName = @"М'ясо";
    p4.productPrice = [Utilities getDecimalNumberFromDoubleValue:57.00];
    
    CDProduct *p5 = [[CDProduct alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    p5.productDescription = @"Lorem ipsum";
    p5.productName = @"Помідири";
    p5.productPrice = [Utilities getDecimalNumberFromDoubleValue:11.30];
    
    CDProduct *p6 = [[CDProduct alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    p6.productDescription = @"Lorem ipsum";
    p6.productName = @"Огірки";
    p6.productPrice = [Utilities getDecimalNumberFromDoubleValue:9.80];
    
    CDProduct *p7 = [[CDProduct alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    p7.productDescription = @"Lorem ipsum";
    p7.productName = @"Морква";
    p7.productPrice = [Utilities getDecimalNumberFromDoubleValue:5.50];
    
    NSError *error = nil;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@" --- insert new Purchase error —> %@", error);
    }
}


#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestProjectCD" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TestProjectCD.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end

//
//  ProductsViewController.h
//  TestProjectCD
//
//  Created by Roma on 14.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

@class ProductsViewController;
@class CDProduct;


@protocol ProductsViewControllerDelegate <NSObject>

-(void) productViewController:(ProductsViewController *)sender didSelectProduct:(CDProduct*)product;

@end



@interface ProductsViewController : UITableViewController 

@property (weak) id <ProductsViewControllerDelegate> delegate;

@end

//
//  Utilities.m
//  TestProjectCD
//
//  Created by Roma on 15.01.14.
//  Copyright (c) 2014 Roma. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(NSDecimalNumber*) getDecimalNumberFromDoubleValue:(double)price {
    return [[NSDecimalNumber alloc] initWithDouble:price];
}



@end

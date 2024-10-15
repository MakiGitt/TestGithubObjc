//
//  MathCalculation.m
//  ObjectiveC_Project
//
//  Created by Anzhelika Makar on 28.05.2024.
//

#import <Foundation/Foundation.h>
#import "MathCalculation.h"

@implementation MathCalculation


- (int)maxNumbers:(int)num1 number2:(int)num2 {
    if (num1 > num2) {
        return  num1;
    } else {
        return  num2;
    }
}

- (NSArray <NSString *>*) converterInt: (NSArray *) array {
    NSMutableArray *convertIntToString = [NSMutableArray array];
    for (int i = 0; i <= array.count - 1; i++) {
        NSString *distanceString = [array[i] stringValue];
        [convertIntToString addObject: distanceString];
    }
         NSLog(@"Element: %@", convertIntToString);
    for (id object in convertIntToString) {
                NSLog(@"Object: %@, Class: %@", object, NSStringFromClass([object class]));
            }
    return NULL;
}

@end


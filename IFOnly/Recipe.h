//
//  Recipe.h
//  IFOnly
//
//  Created by Vanaja Matthen on 15/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property NSString *name;
@property NSNumber *servings;
@property NSNumber *dishType;
@property NSNumber *calories;
@property NSNumber *fat;
@property NSNumber *protein;
@property NSNumber *netCarbs;
@property NSNumber *fiber;
@property NSData *image;

@end

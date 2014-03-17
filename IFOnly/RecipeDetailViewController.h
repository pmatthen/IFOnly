//
//  RecipeDetailViewController.h
//  IFOnly
//
//  Created by Vanaja Matthen on 17/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Recipe.h"

@interface RecipeDetailViewController : UIViewController

@property PFObject *recipe;

@end

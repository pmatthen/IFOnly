//
//  RecipeDetailViewController.m
//  IFOnly
//
//  Created by Vanaja Matthen on 17/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "RecipeDetailViewController.h"

@interface RecipeDetailViewController ()
{
    IBOutlet PFImageView *recipeImage;
    
}

@end

@implementation RecipeDetailViewController
@synthesize recipe;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = [recipe objectForKey:@"Name"];
    recipeImage.file = [recipe objectForKey:@"Image"];
    [recipeImage loadInBackground];
}

@end

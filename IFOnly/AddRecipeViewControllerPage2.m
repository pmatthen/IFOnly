//
//  AddRecipeViewControllerPage2.m
//  IFOnly
//
//  Created by Vanaja Matthen on 15/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "AddRecipeViewControllerPage2.h"
#import "Recipe.h"
#import "Parse/Parse.h"

@interface AddRecipeViewControllerPage2 ()
{
    IBOutlet UITextField *servingsTextField;
    IBOutlet UITextField *caloriesTextField;
    IBOutlet UITextField *fatsTextField;
    IBOutlet UITextField *proteinTextField;
    IBOutlet UITextField *netCarbsTextField;
    IBOutlet UITextField *fiberTextField;
    PFObject *createdRecipe;
}

@end

@implementation AddRecipeViewControllerPage2
@synthesize recipe;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    createdRecipe = [PFObject objectWithClassName:@"Recipe"];
}

- (IBAction)onSaveButtonPressed:(id)sender {
    if (([servingsTextField.text  isEqualToString:@""]) || ([caloriesTextField.text isEqualToString:@""]) || ([fatsTextField.text isEqualToString:@""]) || ([proteinTextField.text isEqualToString:@""]) || ([netCarbsTextField.text isEqualToString:@""]) || ([fiberTextField.text isEqualToString:@""])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"All Fields not Filled" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        createdRecipe[@"Name"] = recipe.name;
        
        PFFile *file = [PFFile fileWithData:recipe.image];
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [createdRecipe setObject:file forKey:@"Image"];
            [createdRecipe saveInBackground];
        }];
        
    }
}


@end

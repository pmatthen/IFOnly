//
//  AddRecipeViewControllerPage1.m
//  IFOnly
//
//  Created by Vanaja Matthen on 15/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "AddRecipeViewControllerPage1.h"
#import "AddRecipeViewControllerPage2.h"
#import "TypeOfMealTableViewCell.h"
#import "Recipe.h"

@interface AddRecipeViewControllerPage1 () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    Recipe *recipe;
    NSArray *typesOfMeals;
    BOOL hasSelectedMealType;
}
@end

@implementation AddRecipeViewControllerPage1

- (void)viewDidLoad
{
    [super viewDidLoad];
    typesOfMeals = @[@"Salad", @"Entree", @"Side Dish", @"Desert"];
    hasSelectedMealType = NO;
    recipe = [Recipe new];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    recipe.name = _recipeNameTextField.text;
    
    return YES;
}

- (IBAction)onNextButtonPressed:(id)sender {
    recipe.name = _recipeNameTextField.text;
    if (([recipe.name  isEqual:@""]) || (recipe.image == nil) || (hasSelectedMealType == NO)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"All Fields not Filled" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        [self performSegueWithIdentifier:@"Page2Segue" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Page2Segue"]) {
        AddRecipeViewControllerPage2 *myAddRecipeViewControllerPage2 = segue.destinationViewController;
        myAddRecipeViewControllerPage2.recipe = recipe;
    }
}

#pragma mark TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return typesOfMeals.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"A"];
    cell.textLabel.text = typesOfMeals[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TypeOfMealTableViewCell *cell;
    
    for (int i = 0; i < typesOfMeals.count; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        cell = [tableView cellForRowAtIndexPath:tempIndexPath];
        cell.checkMarkLabel.text = @"";
    }
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.checkMarkLabel.textColor = [UIColor blueColor];
    cell.checkMarkLabel.text = @"\u2713";
    hasSelectedMealType = YES;
}

#pragma mark ImageCode

- (IBAction)onAddImagePressed:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Select From Library", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [UIImagePickerController new];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Camera not found." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    } else if (buttonIndex == 1) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    recipe.image = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage]);
    [_addImageButton setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [_addImageButton setTitle:@"" forState:UIControlStateNormal];
}

@end

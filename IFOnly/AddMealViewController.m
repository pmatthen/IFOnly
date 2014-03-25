//
//  AddMealViewController.m
//  IFOnly
//
//  Created by Vanaja Matthen on 20/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "AddMealViewController.h"
#import "TypeOfMealTableViewCell2.h"
#import <Parse/Parse.h>

@interface AddMealViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIDatePicker *myDatePicker;
    IBOutlet UITableView *myTableView;
    NSArray *typesOfMeals;
    BOOL hasSelectedMealType;
    int selectedMeal;
}

@end

@implementation AddMealViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    typesOfMeals = @[@"Breakfast", @"Lunch", @"Dinner", @"Snack"];
    hasSelectedMealType = NO;
    myDatePicker.datePickerMode = UIDatePickerModeDate;
}

- (IBAction)onSaveButtonPressed:(id)sender {
    if ([[myDatePicker date] timeIntervalSinceReferenceDate] <= [[NSDate date] timeIntervalSinceReferenceDate]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"User must choose a future date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else if (hasSelectedMealType == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"User must select a meal type" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        // save date to Parse
    }
}

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
    TypeOfMealTableViewCell2 *cell;
    
    for (int i = 0; i < typesOfMeals.count; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        cell = (TypeOfMealTableViewCell2 *) [tableView cellForRowAtIndexPath:tempIndexPath];
        cell.checkMarkLabel.text = @"";
    }
    
    cell = (TypeOfMealTableViewCell2 *) [tableView cellForRowAtIndexPath:indexPath];
    cell.checkMarkLabel.textColor = [UIColor blueColor];
    cell.checkMarkLabel.text = @"\u2713";
    hasSelectedMealType = YES;
    selectedMeal = indexPath.row;
}

@end

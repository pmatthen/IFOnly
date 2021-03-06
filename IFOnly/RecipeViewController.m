//
//  ViewController.m
//  IFOnly
//
//  Created by Apple on 13/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "RecipeViewController.h"
#import "Parse/Parse.h"
#import "RecipeDetailViewController.h"

@interface RecipeViewController ()
{
    PFObject *recipe;
    
}

@end

@implementation RecipeViewController

- (void)viewDidLoad
{
    self.parseClassName = @"Recipe";

    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self loadObjects];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"A"];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"A"];
    }
    
    cell.textLabel.text = [object objectForKey:@"Name"];
    
    int typeOfMeal = [[object objectForKey:@"Type"] intValue];
    switch (typeOfMeal) {
        case 0:
            cell.backgroundColor = [UIColor greenColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor redColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor yellowColor];
            break;
        case 3:
            cell.backgroundColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    recipe = [self.objects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        RecipeDetailViewController *myRecipeDetailViewController = segue.destinationViewController;
        myRecipeDetailViewController.recipe = recipe;
    }
}

@end

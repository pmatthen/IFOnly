//
//  DietViewController.m
//  IFOnly
//
//  Created by Vanaja Matthen on 19/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "DietViewController.h"

@interface DietViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    NSMutableArray *dietEventArray;
}

@end

@implementation DietViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (![PFUser currentUser]) {
        PFLogInViewController *login = [PFLogInViewController new];
        login.delegate = self;
        login.signUpController.delegate = self;
        [self presentViewController:login animated:animated completion:nil];
    }
        
    PFQuery *query = [PFQuery queryWithClassName:@"dietEvent"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *dietEvents, NSError *error) {
        dietEventArray = [[NSMutableArray alloc] initWithArray:dietEvents];
        
        for (int i = 0; i < dietEventArray.count; i++) {
            if (dietEventArray[i][@"mealDate"] < [NSDate date]) {
                [dietEventArray removeObjectAtIndex:i];
                NSLog(@"Removed object at %i", i);
            }
        }
        
        dietEventArray = [dietEventArray sortedArrayUsingComparator:^NSComparisonResult(PFObject *obj1, PFObject *obj2) {
            
            NSDate *date1 = obj1[@"mealDate"];
            NSDate *date2 = obj2[@"mealDate"];
            
            return [date1 compare:date2];
        }];
        
        dispatch_semaphore_t semaphor = dispatch_semaphore_create(0);
        int i = 0;
        while ( (i < 3) && (i < dietEventArray.count)) {
            PFObject *dietEvent = dietEventArray[i];
            PFRelation *relation = [dietEvent relationForKey:@"recipe"];
            PFQuery *query = [relation query];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                dispatch_semaphore_signal(semaphor);
                PFObject *recipe = [objects firstObject];
                NSLog(@"%i. On %@, %@ is being served for %@", i, dietEventArray[i][@"mealDate"], recipe[@"Name"], dietEventArray[i][@"typeOfMeal"]);
            }];
            i++;
            dispatch_semaphore_wait(semaphor, DISPATCH_TIME_FOREVER);
        }
    }];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [signUpController dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [logInController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onLogoutButtonPressed:(id)sender {
    [PFUser logOut];
    PFLogInViewController *login = [PFLogInViewController new];
    login.delegate = self;
    login.signUpController.delegate = self;
    [self presentViewController:login animated:YES completion:nil];
}

@end

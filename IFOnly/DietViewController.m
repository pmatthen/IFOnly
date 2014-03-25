//
//  DietViewController.m
//  IFOnly
//
//  Created by Vanaja Matthen on 19/03/14.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.
//

#import "DietViewController.h"

@interface DietViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation DietViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

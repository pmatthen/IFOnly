//
//  MacroCalculationViewController.m
//  IFOnly
//
//  Created by gule on 2014-03-28.
//  Copyright (c) 2014 Tablified Solutions. All rights reserved.


//RMR for men = 66 + (6.23 x weight in pounds) + (12.7 x height in inches) – (6.8 x age)
//
//RMR for women = 655 + (4.35 x weight in pounds) + (4.7 x height in inches) – (4.7 x age).

#import "MacroCalculationViewController.h"

@interface MacroCalculationViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *ageTextLabel;
@property (strong, nonatomic) IBOutlet UITextField *lbsTextLabel;
@property (strong, nonatomic) IBOutlet UITextField *heightTextLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *genderPicker;

@property (strong, nonatomic) IBOutlet UILabel *rmrTotal;
@property (strong, nonatomic) IBOutlet UILabel *totalCalLabel;

@property (nonatomic) int age;
@property (nonatomic) int weight;
@property (nonatomic) int height;
@property (nonatomic) int rmr;



@end

@implementation MacroCalculationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

}
- (IBAction)onCalculateButtonePressed:(id)sender
{

    double lbs = (4.35 * self.lbsTextLabel.text.intValue);
    double ht = (4.7 * self.heightTextLabel.text.intValue);
    double a = (4.7 * _ageTextLabel.text.intValue);
    
    self.totalCalLabel.text = @(655 + lbs + ht  - a).description;

}

-(int)addNumber:(int)number toNumber:(int)otherNumber
{
    

    NSString *ageString = self.ageTextLabel.text;
    _age = [ageString intValue];
    
    self.rmr = _age;
    
    NSLog(@"labe is: %d and text input is %@", self.rmr, self.ageTextLabel.text);
    
    return  number + otherNumber;
}
- (void)viewDidUnload {
    
    [super viewDidUnload];

}


@end

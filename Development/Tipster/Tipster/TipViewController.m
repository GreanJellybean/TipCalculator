//
//  TipViewController.m
//  Tipster
//
//  Created by Chris Stoner on 8/8/14.
//  Copyright (c) 2014 Yahoo! Inc. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController  ()

@property (nonatomic, weak) IBOutlet UITextField *billTextField;
@property (nonatomic, weak) IBOutlet UILabel *tipLabel;
@property (nonatomic, weak) IBOutlet UILabel *totalLabel;
@property (nonatomic, weak) IBOutlet UISegmentedControl *tipControl;
@property (nonatomic, strong) NSArray *tipAmounts;

- (void)updateValues;

@end

@implementation TipViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"TipCalculator";
        self.tipAmounts = @[@(0.1), @(0.15), @(0.2)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.billTextField.delegate = self;
    
    // after view loads, hook into the segmented control events and the TextFieldDelegate events
    [self.tipControl addTarget:self action:@selector(updateValues) forControlEvents:UIControlEventValueChanged];
    self.tipControl.selectedSegmentIndex =1;
    [self updateValues];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField delegate


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:(@selector(onDoneButton))];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = nil;
    return YES;
    
}

#pragma mark - Private Methods

- (void)onDoneButton {
    [self.view endEditing:YES];
    [self updateValues];
}


- (void)updateValues;
{
    float tipPercentage = [self.tipAmounts[self.tipControl.selectedSegmentIndex] floatValue];
    
    float bill = [self.billTextField.text floatValue];
    float tip = tipPercentage * bill;
    float total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", total];
    
}

@end

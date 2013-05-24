//
//  TaskHeaderViewController.m
//  DTaskMaster
//
//  Created by Doug Mason on 8/26/12.
//  Copyright (c) 2012 Doug Mason. All rights reserved.
//

#import "TaskHeaderViewController.h"

@interface TaskHeaderViewController ()

@end

@implementation TaskHeaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UITextFieldDelegate methods
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Class Specific Methods
-(IBAction)addTask:(UIButton *)sender
{
    if (!_nameTaskTextField.text || [_descriptionTaskTextView.text isEqualToString:@"Task Description"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please enter both a task name and description" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        [_nameTaskTextField resignFirstResponder];
        [_descriptionTaskTextView resignFirstResponder];
        [self.delegate addTask:_nameTaskTextField.text withDescription:_descriptionTaskTextView.text];
    }
}
@end

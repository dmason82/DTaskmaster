//
//  TaskDetailViewController.m
//  DTaskMaster
//
//  Created by Doug Mason on 5/25/13.
//  Copyright (c) 2013 Doug Mason. All rights reserved.
//

#import "TaskDetailViewController.h"

@interface TaskDetailViewController ()

@end

@implementation TaskDetailViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setActionButton:nil];
    [self setTaskTitleField:nil];
    [self setTaskDetailField:nil];
    [self setReminderDateButton:nil];
    [super viewDidUnload];
}
@end

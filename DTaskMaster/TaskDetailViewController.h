//
//  TaskDetailViewController.h
//  DTaskMaster
//
//  Created by Doug Mason on 5/25/13.
//  Copyright (c) 2013 Doug Mason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskDetailViewController : UIViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (weak, nonatomic) IBOutlet UITextField *taskTitleField;
@property (weak, nonatomic) IBOutlet UITextView *taskDetailField;
@property (weak, nonatomic) IBOutlet UIButton *reminderDateButton;

@end

//
//  TaskHeaderViewController.h
//  DTaskMaster
//
//  Created by Doug Mason on 8/26/12.
//  Copyright (c) 2012 Doug Mason. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TaskHeaderDelegate <NSObject>
@optional
        
@required
-(void)addTask:(NSString*)name withDescription:(NSString*)description;
@end
@interface TaskHeaderViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,strong)IBOutlet UITextField *nameTaskTextField;
@property(nonatomic,strong)IBOutlet UITextView *descriptionTaskTextView;
@property(nonatomic,weak)id<TaskHeaderDelegate> delegate;
-(IBAction)addTask:(UIButton *)sender;
@end

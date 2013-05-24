//
//  ViewController.h
//  DTaskMaster
//
//  Created by Doug Mason on 8/26/12.
//  Copyright (c) 2012 Doug Mason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TasksDocument.h"
#import "TaskHeaderViewController.h"
@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,TaskHeaderDelegate,NSFetchedResultsControllerDelegate>

@property(nonatomic,strong)NSURL *localURL;
@property(nonatomic,strong)NSURL *remoteURL;
@property(nonatomic,strong)TaskHeaderViewController * taskHeaderView;
@property(nonatomic,strong)TasksDocument *document;
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;

@end

//
//  DTaskMasterTests.h
//  DTaskMasterTests
//
//  Created by Doug Mason on 8/26/12.
//  Copyright (c) 2012 Doug Mason. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TasksDocument.h"
@interface DTaskMasterTests : SenTestCase<NSFetchedResultsControllerDelegate>

@property(nonatomic,retain)    NSURL* localURL;
@property(nonatomic,retain)    TasksDocument* document;
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;
@end

//
//  DTaskMasterTests.m
//  DTaskMasterTests
//
//  Created by Doug Mason on 8/26/12.
//  Copyright (c) 2012 Doug Mason. All rights reserved.
//

#import "DTaskMasterTests.h"
#import "TasksDocument.h"

@implementation DTaskMasterTests

- (void)setUp
{
    [super setUp];
    NSFileManager *manage = [NSFileManager defaultManager];
    self.localURL = [[[manage URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Tasks"];
    self.document = [[TasksDocument alloc] initWithFileURL:self.localURL];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void)testUIDocumentCreation{
    STAssertNotNil(self.document, @"Document should not be nil");
}
-(void)testDocumentCount{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Task" inManagedObjectContext:self.document.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    _fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.document.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    _fetchedResultsController.delegate = self;
    STAssertTrue([self.fetchedResultsController.fetchedObjects count] !=0 , @"Since I have stuff in, this should not be zero");
}


-(NSFetchedResultsController* )fetchedResultsController{
    if(_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Task" inManagedObjectContext:self.document.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    _fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.document.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type){
        case NSFetchedResultsChangeInsert:
            
            break;
        case NSFetchedResultsChangeMove:
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeDelete:
            //TODO: implement delete
            break;
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
    //    [self.tableView endUpdates];
}

@end

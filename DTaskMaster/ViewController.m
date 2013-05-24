//
//  ViewController.m
//  DTaskMaster
//
//  Created by Doug Mason on 8/26/12.
//  Copyright (c) 2012 Doug Mason. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "TaskHeaderViewController.h"
#import "Task.h"
@interface ViewController ()
-(void)setupTable;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSFileManager *manage = [NSFileManager defaultManager];
    self.localURL = [[[manage URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Tasks"];
    self.taskHeaderView = [[TaskHeaderViewController alloc] initWithNibName:@"TaskHeaderViewController" bundle:[NSBundle mainBundle]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.taskHeaderView.delegate = self;
    self.document = [[TasksDocument alloc] initWithFileURL:self.localURL];

    if (![self.document initWithFileURL:self.localURL])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"unable to initialize database" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    if([manage fileExistsAtPath:self.localURL.path])
        {
            [self.document openWithCompletionHandler:^(BOOL success){
                NSLog(@"Successfully loaded database");
                [_tableView reloadData];
                [self setupTable];} ];
            
            
        }
    else{
        [self.document saveToURL:self.localURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            NSLog(@"%@",success?@"Successfully saved DB":@"Didn't save DB");
            [self setupTable];
        }];
        
        NSLog(@"%@",[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:0]]);
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
    NSLog(@"%@",[[_fetchedResultsController fetchedObjects] objectAtIndex:0]);
    
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(documentChanged:) name:UIDocumentStateChangedNotification object:self.document];
    [center addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.document.managedObjectContext];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
        NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UITableView Setup
-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.taskHeaderView.view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([_fetchedResultsController fetchedObjects]){
        return [[_fetchedResultsController fetchedObjects] count];
    }
    else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 230.0f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TableCell"];
    }
    Task* theTask = [[self.fetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
    NSLog(@"%@",theTask);
    cell.textLabel.text = theTask.name;
    cell.detailTextLabel.text = theTask.details;
    return cell;
}


#pragma mark - Public class methods
-(void)addTask:(NSString *)name withDescription:(NSString *)description
{
    Task *newTask = [[Task alloc] initWithEntity:[NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.document.managedObjectContext] insertIntoManagedObjectContext:self.document.managedObjectContext];
    newTask.name = name;
    newTask.details = description;
    newTask.completed = [NSNumber numberWithBool:NO];
    [self.document updateChangeCount:UIDocumentChangeDone];
}

#pragma mark - Private class methods
-(void)setupTable{
    NSError * error;
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Error! %@",error);
    }
    NSLog(@"%i",[[self.fetchedResultsController fetchedObjects] count]);
//    NSLog(@"%@",[[_fetchedResultsController fetchedObjects] objectAtIndex:0]);
    [self.tableView setNeedsDisplay];
}

#pragma mark - NSNotificationCenter callbacks
-(void)documentChanged:(NSNotification*) notification
{
    NSLog(@"Document changed");
    [self setupTable];
}
-(void)contextChanged:(NSNotification*) notification
{
    NSLog(@"Context changed");
    [self setupTable];
}


#pragma mark - Getters/Setters
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
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
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

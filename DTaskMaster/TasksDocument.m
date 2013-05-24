//
//  TasksDocument.m
//  DTaskMaster
//
//  Created by Doug Mason on 8/26/12.
//  Copyright (c) 2012 Doug Mason. All rights reserved.
//

#import "TasksDocument.h"
#import <CoreData/CoreData.h>
@implementation TasksDocument
-(NSManagedObjectModel*)managedObjectModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TaskModel" ofType:@"momd"];
    NSURL* modelURL = [NSURL fileURLWithPath:path];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return model;
}

-(NSPersistentStoreCoordinator*)persistentStoreCoordinator
{
    if (self.persistentStoreCoordinator !=nil)
    {
        return self.persistentStoreCoordinator;
    }
        if(![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.fileURL options:nil error:nil]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Unable to create Persistent Store" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    return self.persistentStoreCoordinator;
}
@end

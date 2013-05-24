//
//  Task.h
//  DTaskMaster
//
//  Created by Doug Mason on 8/26/12.
//  Copyright (c) 2012 Doug Mason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSNumber * completed;

@end

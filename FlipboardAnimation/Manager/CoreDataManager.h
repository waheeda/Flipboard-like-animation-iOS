//
// Created by Mohsin Ahmed on 2/4/14.
//


#import <Foundation/Foundation.h>

@class NSFetchRequest;
@class NSManagedObjectContext;
@class NSEntityDescription;
@class NSManagedObject;

#define CDManager [CoreDataManager instance]

@interface CoreDataManager : NSObject{
    NSManagedObjectModel *_objectModel;
    NSManagedObjectContext *_objectModelContext;
    NSPersistentStoreCoordinator *_storeCoordinator;
}

+ (CoreDataManager *)instance;

-(void)initialize;

- (NSArray *)executeFetch:(NSFetchRequest *)fetchRequest context:(NSManagedObjectContext *)context;

- (void)save:(NSManagedObjectContext *)context;

- (void)reset:(NSManagedObjectContext *)context;

- (NSManagedObjectContext *)createBackgroundContext;

- (void)saveMerged:(NSManagedObjectContext *)context;

- (void)deleteObject :(NSManagedObject *)object context:(NSManagedObjectContext *)context;

- (NSEntityDescription *)getEntity :(NSString *)entityName context:(NSManagedObjectContext *)context;

- (NSEntityDescription *)insert :(NSString *)entityName context:(NSManagedObjectContext *)context;

- (NSUInteger) getCountForFetchRequest : (NSFetchRequest *) fetchRequest context:(NSManagedObjectContext *)context;

@end
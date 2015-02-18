//
// Created by Mohsin Ahmed on 2/4/14.
//


#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "AppDelegate.h"

#define MOC [AppDelegate objectModel]

@implementation CoreDataManager {

}

+ (CoreDataManager *)instance {
    static CoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataManager alloc] init];
    });
    return sharedInstance;
}

-(id)init{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (NSArray *)executeFetch:(NSFetchRequest *)fetchRequest  context:(NSManagedObjectContext *)context {
    NSError *err = nil;
    
    if (context == nil) {
        context = [[CoreDataManager instance] _objectModelContext]; //added by Firdous
    }
    
    NSArray *array = [context executeFetchRequest:fetchRequest error:&err];
    if (err) {
        NSLog(@"error fetching: %@", err);
        @throw [NSException exceptionWithName:@"Error fetching" reason:fetchRequest.entityName userInfo:nil];
    }
    return array;
}

- (void)save:(NSManagedObjectContext *)context {
    NSError *error = nil;
    
    if (context == nil) {
        context = [[CoreDataManager instance] _objectModelContext]; //added by Firdous
    }
    
    if (context != nil) {
        if ([context hasChanges]) {

            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort(); // can be removed if required
            }
        }
    }
}

- (void)reset:(NSManagedObjectContext *)context {
    if (context == nil) {
        context = [[CoreDataManager instance] _objectModelContext]; //added by Firdous
    }
    
    if (context != nil) {
        if ([context hasChanges]) {
            [context reset];
        }
    }
}

- (NSEntityDescription *)insert :(NSString *)entityName context:(NSManagedObjectContext *)context {
    if(context == nil)
        context = [[CoreDataManager instance] _objectModelContext];//_objectModelContext;
    
    return [NSEntityDescription
            insertNewObjectForEntityForName:entityName
            inManagedObjectContext:context];
}

- (NSEntityDescription *)getEntity :(NSString *)entityName context:(NSManagedObjectContext *)context {
    if(context == nil)
        context = [[CoreDataManager instance] _objectModelContext];//_objectModelContext;
    
    return [NSEntityDescription
            entityForName:entityName inManagedObjectContext:context];
}

- (NSUInteger) getCountForFetchRequest : (NSFetchRequest *) fetchRequest context:(NSManagedObjectContext *)context{
    if(context == nil)
        context = [[CoreDataManager instance] _objectModelContext];//_objectModelContext;
    
	@try {
		NSError *error = nil;
		return [context countForFetchRequest:fetchRequest error:&error];
	}
	@catch (NSException *exception) {
		NSLog(@"EXCEPTION ========== CoreDataManager -> getCountForFetchRequest -> %@", exception.description);
		return 0;
	}
}

- (void)deleteObject :(NSManagedObject *)object context:(NSManagedObjectContext *)context {
    if(context == nil)
        context = [[CoreDataManager instance] _objectModelContext];//_objectModelContext;
    
    @try {
        [context deleteObject:object];
        [self save:context];
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION ========== CoreDataHelper -> deleteObject -> %@", exception.description);
    }
}

- (NSManagedObjectContext *)createBackgroundContext {
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [moc setUndoManager:nil];
    [moc setPersistentStoreCoordinator:_storeCoordinator];
    [moc setRetainsRegisteredObjects:YES];
    return moc;
}

#pragma mark - Save Merged

- (void)saveMerged:(NSManagedObjectContext *)moc {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextDidSaveNotification object:nil];
    [CDManager save:moc];
    [self unsubscribeNotification];
}


#pragma mark - Notifications

- (void)unsubscribeNotification {
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
        });
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextDidSaveNotification object:nil];
    }
}

- (void)contextChanged:(NSNotification *)notification {
    if ([notification object] == _objectModelContext) return;

    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(contextChanged:) withObject:notification waitUntilDone:YES];
        return;
    }

    NSManagedObjectContext *context = _objectModelContext;
    [context mergeChangesFromContextDidSaveNotification:notification];
}




#pragma setup core model


#pragma mark -
#pragma mark Core Data stack

- (NSManagedObjectContext *)_objectModelContext {
    if (_objectModelContext != nil) {
        return _objectModelContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self _storeCoordinator];
    
    if (coordinator != nil) {
        _objectModelContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_objectModelContext setPersistentStoreCoordinator:coordinator];
    }
    return _objectModelContext;
}

- (NSManagedObjectModel *)_objectModel {
    if (_objectModel != nil) {
        return _objectModel;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CoreDataModel" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];;
    
    return _objectModel;
}

- (NSPersistentStoreCoordinator *)_storeCoordinator {
    if (_storeCoordinator != nil) {
        return _storeCoordinator;
    }
    
    NSError *error = nil;
    _storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self _objectModel]];
    
    if (![_storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:nil error:&error]) {
        NSLog(@"error adding persistent store: %@", error);
        // re create model in case of changes in core data
        [self reCreateCoreDataModel];
    }
    
    return _storeCoordinator;
}

- (void)reCreateCoreDataModel {
    NSError *error = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:[self storeURL] error:NULL];
    
    if (![_storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:nil error:&error]) {
        abort();
    }
    
   // [self logout];
}

-(NSURL*)storeURL{
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    return [NSURL fileURLWithPath:[libraryDirectory stringByAppendingPathComponent:@"CoreDataModel.sqlite"]];
}

-(void)initialize{
    [self _objectModelContext];
}

@end
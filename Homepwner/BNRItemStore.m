//
//  BNRItemStore.m
//  Homepwner
//
//  Created by John Russel Usi on 9/30/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRImageStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic)NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore{

  static BNRItemStore *sharedStore;
  
  //  Do I need to create a sharedStore
  if(!sharedStore){
    
    sharedStore = [[self alloc]initPrivate];
  }
  
  return sharedStore;
}

- (instancetype)init{
  
  [NSException raise:@"Singleton"
              format:@"Use + [BNRItemStore sharedStore]"];
  return nil;
}

//  Here is the real (secret) initializer
- (instancetype)initPrivate{

  self = [super init];
  
  if (self) {
    
    NSString *path = [self itemArchivePath];
    _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    //  If the array hadn't been saved previously, create a new empty one
    if (!_privateItems) {
      
      _privateItems = [[NSMutableArray alloc]init];
    }
  }
  
  return self;
}

- (NSArray *)allItems{

  return [self.privateItems copy];
}

- (BNRItem *)createItem{
  
  BNRItem *item = [[BNRItem alloc]init];
  
  [self.privateItems addObject:item];
  return item;
}

- (void)removeItem:(BNRItem *)item{

  NSString *key = item.itemKey;
  
  [[BNRImageStore sharedStore]deleteImageForKey:key];
  
  [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
  if (fromIndex == toIndex) {
    return; }
  // Get pointer to object being moved so you can re-insert it
  BNRItem *item = self.privateItems[fromIndex];
  // Remove item from array
  [self.privateItems removeObjectAtIndex:fromIndex];
  // Insert item in array at new location
  [self.privateItems insertObject:item atIndex:toIndex];
}

- (NSString *)itemArchivePath{

  //  Make sure that the first argument is NSDocumentDirectory
  //  and not NSDocumentationDirectory
  NSArray *documentDirectories =
      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                          NSUserDomainMask, YES);
  
  //  Get the one document directory from that list
  NSString *documentDirectory = [documentDirectories firstObject];
  
  return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges{

  NSString *path = [self itemArchivePath];
  
  //  Return YES on success
  return [NSKeyedArchiver archiveRootObject:self.privateItems
                                     toFile:path];
}
@end

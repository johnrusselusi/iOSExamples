//
//  BNRImageStore.m
//  Homepwner
//
//  Created by John Russel Usi on 10/1/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+ (instancetype)sharedStore{

  static BNRImageStore *sharedStore = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedStore = [[self alloc] initPrivate];
  });

  return sharedStore;
}

//  No one should call init
- (instancetype)init{

  [NSException raise:@"Singleton"
              format:@"Use + [BNRImageStore store]"];
  return nil;
}

- (instancetype)initPrivate{

  self = [super init];
  
  if (self) {
    _dictionary = [[NSMutableDictionary alloc]init];
  }
  
  return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key{

  self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key{

  return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key{

  if(!key){
  
    return;
  }
  [self.dictionary removeObjectForKey:key];
}

@end

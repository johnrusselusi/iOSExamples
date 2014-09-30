//
//  BNRItem.h
//  RandomItems
//
//  Created by John Russel Usi on 9/30/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject{

  NSString *_itemName;
  NSString *_serialNumber;
  int _valueInDollars;
  NSDate *_dateCreated;
}

- (void)setItemName:(NSString *)str;
- (NSString *)itemName;
- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;
- (void)setValueInDollars:(int)v;
- (int)valueInDollars;
- (NSDate *)dateCreated;

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;
- (instancetype)initWithItemName:(NSString *)name;

+ (instancetype)randomItem;

@end

//
//  BNRItem.h
//  RandomItems
//
//  Created by John Russel Usi on 9/30/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject <NSCoding>

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;
@property (nonatomic, strong) UIImage *thumbnail;

+ (instancetype)randomItem;
// Designated initializer for BNRItem
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;
- (instancetype)initWithItemName:(NSString *)name;
- (void)setItemName:(NSString *)str;
- (NSString *)itemName;
- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;
- (void)setValueInDollars:(int)v;
- (int)valueInDollars;
- (NSDate *)dateCreated;
- (void)setThumbnailFromImage:(UIImage *)image;
@end
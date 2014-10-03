//
//  BNRItemCell.h
//  Homepwner
//
//  Created by John Russel Usi on 10/2/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;

@property (copy, nonatomic) void (^actionBlock)(void);

@end

//
//  BusTableViewCell.h
//  GeEuro
//
//  Created by Ahmad Farrag on 10/9/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *providerImageView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *intervalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *sepratorView;

@end

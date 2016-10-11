//
//  BusTableViewCell.m
//  GeEuro
//
//  Created by Ahmad Farrag on 10/9/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import "BusTableViewCell.h"

@implementation BusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

@end

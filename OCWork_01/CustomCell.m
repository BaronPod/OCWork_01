//
//  CustomCell.m
//  OCWork_01
//
//  Created by 李嘉 on 16/1/12.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation CustomCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self setupView];
//    }
//    return self;
//}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (void) setEntity:(BtypeEntity *)entity {
    _entity = entity;
    self.titleLabel.text = entity.tName;
    self.contentLabel.text = entity.tDescription;
    //self.image.image = nil;
    self.usernameLabel.text = entity.tCode;
    self.timeLabel.text = entity.tCreateDate;
}

- (CGSize) sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.titleLabel sizeThatFits:size].height;
    totalHeight += [self.contentLabel sizeThatFits:size].height;
    totalHeight += [self.image sizeThatFits:size].height;
    totalHeight += [self.usernameLabel sizeThatFits:size].height;
    totalHeight += [self.timeLabel sizeThatFits:size].height;
    totalHeight += 40;
    return CGSizeMake(size.width, totalHeight);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

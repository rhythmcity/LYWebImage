
//
//  CustomTableCell.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,100, 100)];
        [self.contentView addSubview:self.headView];
    }
    return self;

}
@end

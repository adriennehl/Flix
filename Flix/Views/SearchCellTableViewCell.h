//
//  SearchCellTableViewCell.h
//  Flix
//
//  Created by Adrienne Li on 6/26/20.
//  Copyright © 2020 ahli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

NS_ASSUME_NONNULL_END

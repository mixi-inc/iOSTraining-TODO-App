//
//  TodoTableViewCell.h
//  Todo
//
//  Created by yuichi.takeda on 3/19/15.
//  Copyright (c) 2015 appdojo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *todoLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end

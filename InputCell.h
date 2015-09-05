//
//  InputCell.h
//  InputCellDemo
//
//  Created by li on 15/8/10.
//  Copyright (c) 2015年 医视时代. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EndEditBlock) (NSString *Str, NSIndexPath *idx);
@interface InputCell : UITableViewCell

@property (nonatomic,readonly) UITextField *textField;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,copy) EndEditBlock block;

- (void)setTitle:(NSString *)title placeholder:(NSString *)placeholder andInputInfo:(NSString *)info;


@end

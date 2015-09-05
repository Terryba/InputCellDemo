//
//  InputCell.m
//  InputCellDemo
//
//  Created by li on 15/8/10.
//  Copyright (c) 2015年 医视时代. All rights reserved.
//

#import "InputCell.h"

@interface InputCell () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong,nonatomic) UILabel *descLabel;

@end

@implementation InputCell

-(void)dealloc{
    _textField.delegate = nil;
    self.block = nil;
}
- (void)awakeFromNib {
    // Initialization code
    _textField.delegate = self;
    _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 43)];
    _descLabel.font = [UIFont systemFontOfSize:14];
    _descLabel.textColor = [UIColor blackColor];
    _textField.leftView = _descLabel;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.spellCheckingType = UITextSpellCheckingTypeNo;
    _textField.returnKeyType = UIReturnKeyDone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitle:(NSString *)title placeholder:(NSString *)placeholder andInputInfo:(NSString *)info{
    _descLabel.text = title;
    _textField.placeholder = placeholder;
    _textField.text = info;
}
#pragma mark - override
-(void)prepareForReuse{
    [super prepareForReuse];
    
    _descLabel.text = nil;
    _textField.placeholder = nil;
    _textField.text = nil;
    
}
#pragma mark -textFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    //block跟代理很相似，每次调用block的时候，^{}里面的代码才会执行
    if (_block) {
        if (_textField.text && _textField.text.length > 0) {
            _block(_textField.text,_indexPath);
        }
        else{
            _block(@"",_indexPath);
        }
    }
    return YES;
}

@end

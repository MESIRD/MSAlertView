//
//  MSAlertView.m
//  MSAlertView
//
//  Created by mesird on 5/10/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSAlertView.h"
#import "MSAlertInputField.h"
#import "MSAlertInputModel.h"
#import "MSAlertButtonModel.h"

typedef NS_OPTIONS(NSInteger, MSAlertViewComponent) {
    MSAlertViewComponentTitle   = 1 << 0,
    MSAlertViewComponentContent = 1 << 1,
    MSAlertViewComponentInput   = 1 << 2,
    MSAlertViewComponentButton  = 1 << 3
};

@interface MSAlertView()

// widgets
@property (nonatomic, strong) UIView  *titleView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView                              *centerView;
@property (nonatomic, strong) UITextView                          *contentTextView;
@property (nonatomic, strong) NSMutableArray<MSAlertInputField *> *inputFieldArray;

@property (nonatomic, strong) UIView         *bottomView;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) UIView         *contentView;  // view contains widgets except mask view

@property (nonatomic, strong) UIView         *maskView;

// data sources
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSMutableArray<MSAlertInputModel *>  *inputModels;
@property (nonatomic, strong) NSMutableArray<MSAlertButtonModel *> *buttonModels;

// data control
@property (nonatomic, assign) NSInteger components;
@property (nonatomic, assign) BOOL      hasCancelButton;

@end

@implementation MSAlertView

static const NSTimeInterval kAnimationTimeInterval = 0.3f;

static const CGFloat kLeftMargin   = 30.0f;
static const CGFloat kRightMargin  = kLeftMargin;

static const CGFloat kTitleHeight  = 30.0f;
static const CGFloat kInputHeight  = 24.0f;
static const CGFloat kButtonHeight = 32.0f;


#pragma mark - Class Initalization

- (instancetype)initWithDelegate:(id<MSAlertViewDelegate>)delegate title:(NSString *)title content:(NSString *)content cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    if ( self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        
        // init parameters
        [self initializeParameters];
        
        // title
        if ( title && ![title isEqualToString:@""]) {
            _title = title;
            _components |= MSAlertViewComponentTitle;
        }
        
        // content
        if ( content && ![content isEqualToString:@""]) {
            _content = content;
            _components |= MSAlertViewComponentContent;
        }
        
        // cancel button
        if ( cancelButtonTitle && ![cancelButtonTitle isEqualToString:@""]) {
            [_buttonModels addObject:[[MSAlertButtonModel alloc] initWithTitle:cancelButtonTitle callbackBlock:nil andIsCancelButton:YES]];
            _components |= MSAlertViewComponentButton;
            _hasCancelButton = YES;
        }
        
        // other buttons
        if ( otherButtonTitles) {
            // add first title
            [_buttonModels addObject:[[MSAlertButtonModel alloc] initWithTitle:otherButtonTitles callbackBlock:nil andIsCancelButton:NO]];
            va_list argp;
            va_start(argp, otherButtonTitles);
            NSString *buttonTitle;
            while ( (buttonTitle = va_arg(argp, NSString *))) {
                [_buttonModels addObject:[[MSAlertButtonModel alloc] initWithTitle:buttonTitle callbackBlock:nil andIsCancelButton:NO]];
            }
            va_end(argp);
            _components |= MSAlertViewComponentButton;
        }
        
        // delegate
        _delegate = delegate;
        
        // init UI
        [self initializeUI];
        
    }
    return self;
}

- (void)show {
    
    _contentView.layer.contentsScale = 0.0f;
    
    UIWindow *currentWindow = [[UIApplication sharedApplication] keyWindow] ? [[UIApplication sharedApplication] keyWindow] : [[[UIApplication sharedApplication] windows] firstObject];
    [currentWindow addSubview:self];
    
    [UIView animateWithDuration:kAnimationTimeInterval animations:^{
        _maskView.layer.opacity = 1.0f;
        _contentView.layer.contentsScale = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:kAnimationTimeInterval animations:^{
        _maskView.layer.opacity = 0.0f;
        _contentView.layer.contentsScale = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)initializeParameters {
    
    _components      = 0;
    _hasCancelButton = NO;
    _buttonModels    = [[NSMutableArray alloc] init];
    _inputModels     = [[NSMutableArray alloc] init];
}

- (void)initializeUI {
    
    // mask view
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    _maskView.layer.opacity = 0.0f;
    [self addSubview:_maskView];
    
    // content view
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 4.0f;
    _contentView.layer.masksToBounds = YES;
    [self addSubview:_contentView];
    
    // configure view
    [self reloadUI];
}

- (void)reloadUI {
    
    if ( _components == 0) {
        return;
    }
    
    // content width
    CGFloat contentWidth = SCREEN_WIDTH - kLeftMargin - kRightMargin;
    
    if ( _components & MSAlertViewComponentTitle) {
        if ( !_titleView) {
            _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, kTitleHeight)];
            [_contentView addSubview:_titleView];
        }
        if ( !_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), kTitleHeight)];
            _titleLabel.text = _title;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.textColor = COLOR_OF_RGBA(111.0f, 111.0f, 111.0f, 1.0f);
            _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
            [_titleView addSubview:_titleLabel];
        }
    }
    
    if ( !_centerView) {
        _centerView = [[UIView alloc] init];
        [_contentView addSubview:_centerView];
    }
    
    if ( _components & MSAlertViewComponentContent) {
        if ( !_contentTextView) {
            CGFloat contentTextHeight = [_content boundingRectWithSize:CGSizeMake(contentWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} context:nil].size.height;
            _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, contentTextHeight + 20.0f)];
            _contentTextView.text = _content;
            _contentTextView.textColor = COLOR_OF_RGBA(128.0f, 128.0f, 128.0f, 1.0f);
            _contentTextView.textAlignment = NSTextAlignmentCenter;
            _contentTextView.font = [UIFont systemFontOfSize:12.0f];
            [_centerView addSubview:_contentTextView];
        }
    }
    
    if ( _components & MSAlertViewComponentInput) {
        if ( !_inputFieldArray || _inputFieldArray.count < _inputModels.count) {
            _inputFieldArray = [[NSMutableArray alloc] init];
            [_inputModels enumerateObjectsUsingBlock:^(MSAlertInputModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MSAlertInputField *field = [[MSAlertInputField alloc] initWithFrame:CGRectMake(0, idx * (kInputHeight + 1.0f) + CGRectGetMaxY(_contentTextView.frame), contentWidth, kInputHeight) andPlaceholder:[obj placeholder]];
                field.tag = idx;
                [_inputFieldArray addObject:field];
                [_centerView addSubview:field];
            }];
        }
    }
    _centerView.frame = CGRectMake(0, CGRectGetMaxY(_titleView.frame), contentWidth, CGRectGetHeight(_contentTextView.frame) + (_inputModels.count * (kInputHeight + 1.0f)) + 10.0f);
    
    if ( _components & MSAlertViewComponentButton) {
        if ( !_bottomView) {
            _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_centerView.frame), contentWidth, kButtonHeight)];
            [_contentView addSubview:_bottomView];
        }
        if ( !_buttonArray || _buttonArray.count < _buttonModels.count) {
            CGFloat buttonWidth = contentWidth / _buttonModels.count;
            [_buttonModels enumerateObjectsUsingBlock:^(MSAlertButtonModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:[_buttonModels[idx] title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName:[UIColor whiteColor]}];
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(idx * buttonWidth, 0, buttonWidth, kButtonHeight)];
                [button setTag:idx];
                [button setAttributedTitle:attributedTitle forState:UIControlStateNormal];
                [button addTarget:self action:@selector(bottomButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                if ( _hasCancelButton && idx == 0) {
                    [button setBackgroundColor:COLOR_OF_RGBA(190.0f, 190.0f, 190.0f, 1.0f)];
                } else {
                    [button setBackgroundColor:COLOR_OF_RGBA(35.0f, 220.0f, 151.0f, 1.0f)];
                }
                [_bottomView addSubview:button];
            }];
        }
    }
    
    // reset content frame
    CGFloat contentHeight = [self getContentHeight];
    _contentView.frame = CGRectMake(kLeftMargin, (SCREEN_HEIGHT - contentHeight) / 2, contentWidth, contentHeight);
}

- (CGFloat)getContentHeight {
    
    CGFloat height = 0;
    if ( _components & MSAlertViewComponentTitle) {
        height += _titleView ? CGRectGetHeight(_titleView.frame) : kTitleHeight;
    }
    if ( _components & MSAlertViewComponentContent) {
        height += _centerView ? CGRectGetHeight(_centerView.frame) : 0;
    }
    if ( _components & MSAlertViewComponentInput) {
        height += _inputModels ? _inputModels.count * kInputHeight : 0;
    }
    if ( _components & MSAlertViewComponentButton) {
        height += _buttonModels && _buttonModels.count > 0 ? kButtonHeight : 0;
    }
    return height;
}

- (void)bottomButtonPressed:(UIButton *)sender {
    
    if ( self.delegate && [self.delegate respondsToSelector:@selector(alertView:didPressedOnButton:)]) {
        [self.delegate performSelector:@selector(alertView:didPressedOnButton:) withObject:self withObject:@{}];
    }
    
    [self hide];
}

@end

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

@property (nonatomic, strong) UIView                              *contentView;
@property (nonatomic, strong) UITextView                          *contentTextView;
@property (nonatomic, strong) NSMutableArray<MSAlertInputField *> *inputFieldArray;

@property (nonatomic, strong) UIView         *bottomView;
@property (nonatomic, strong) NSMutableArray *buttonArray;

// data sources
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray<MSAlertInputModel *>  *inputModels;
@property (nonatomic, strong) NSMutableArray<MSAlertButtonModel *> *buttonModels;

//
@property (nonatomic, assign) NSInteger       components;

@end

@implementation MSAlertView

static const CGFloat kLeftMargin = 30.0f;
static const CGFloat kRightMargin = kLeftMargin;

static const CGFloat kTitleHeight  = 30.0f;
static const CGFloat kInputHeight  = 24.0f;
static const CGFloat kButtonHeight = 32.0f;


#pragma mark - Class Initalization

- (instancetype)initWithDelegate:(id<MSAlertViewDelegate>)delegate title:(NSString *)title content:(NSString *)content cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    if ( self = [super init]) {
        
        // init parameters
        [self initializeParameters];
        
        // title
        if ( title && ![title isEqualToString:@""]) {
            _title = [title copy];
            _components |= MSAlertViewComponentTitle;
        }
        
        // content
        if ( content && ![content isEqualToString:@""]) {
            _content = [content copy];
            _components |= MSAlertViewComponentContent;
        }
        
        // cancel button
        if ( cancelButtonTitle && ![cancelButtonTitle isEqualToString:@""]) {
            [_buttonModels addObject:[[MSAlertButtonModel alloc] initWithTitle:title callbackBlock:nil andIsCancelButton:YES]];
            _components |= MSAlertViewComponentButton;
        }
        
        // other buttons
        va_list argp;
        va_start(argp, otherButtonTitles);
        NSString *buttonTitle = va_arg(argp, id);
        while ( buttonTitle) {
            [_buttonModels addObject:[[MSAlertButtonModel alloc] initWithTitle:buttonTitle callbackBlock:nil andIsCancelButton:NO]];
            _components |= MSAlertViewComponentButton;
            buttonTitle = va_arg(argp, id);
        }
        va_end(argp);
        
        // delegate
        _delegate = delegate;
        
        // init UI
        [self initializeUI];
        
    }
    return self;
}

- (void)show {
    
}


- (void)initializeParameters {
    
    _components = 0;
    _buttonModels = [[NSMutableArray alloc] init];
    _inputModels = [[NSMutableArray alloc] init];
    
}

- (void)initializeUI {
    
    if ( _components == 0) {
        return;
    }
    
    // reset view frame
    CGFloat viewHeight = [self getViewHeight];
    self.frame = CGRectMake(kLeftMargin, (SCREEN_HEIGHT - viewHeight) / 2, SCREEN_WIDTH - kLeftMargin - kRightMargin, viewHeight);
    
    if ( _components & MSAlertViewComponentTitle) {
        if ( !_titleView) {
            _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), kTitleHeight)];
            [self addSubview:_titleView];
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
    
    if ( !_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), CGRectGetWidth(self.frame), 0)];
        [self addSubview:_contentView];
    }
    
    if ( _components & MSAlertViewComponentContent) {
        if ( !_contentTextView) {
            CGFloat contentTextHeight = [_content boundingRectWithSize:CGSizeMake(CGRectGetWidth(_contentView.frame), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} context:nil].size.height;
            _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentView.frame), contentTextHeight)];
            _contentTextView.text = _content;
            _contentTextView.textColor = COLOR_OF_RGBA(128.0f, 128.0f, 128.0f, 1.0f);
            _contentTextView.textAlignment = NSTextAlignmentCenter;
            _contentTextView.font = [UIFont systemFontOfSize:12.0f];
            [_contentView addSubview:_contentTextView];
        }
    }
    
    if ( _components & MSAlertViewComponentInput) {
        if ( !_inputFieldArray) {
            _inputFieldArray = [[NSMutableArray alloc] init];
            [_inputModels enumerateObjectsUsingBlock:^(MSAlertInputModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MSAlertInputField *field = [[MSAlertInputField alloc] initWithFrame:CGRectMake(0, idx * (kInputHeight + 1.0f) + CGRectGetMaxY(_contentTextView.frame), CGRectGetWidth(_contentView.frame), kInputHeight) andPlaceholder:[obj placeholder]];
                field.tag = idx;
                [_inputFieldArray addObject:field];
                [_contentView addSubview:field];
            }];
        }
    }
    
    if ( _components & MSAlertViewComponentButton) {
        
    }
    
}

- (void)reloadUI {
    
    
}

- (CGFloat)getViewHeight {
    
    CGFloat height = 0;
    if ( _components & MSAlertViewComponentTitle) {
        height += _titleView ? CGRectGetHeight(_titleView.frame) : kTitleHeight;
    }
    if ( _components & MSAlertViewComponentContent) {
        height += _contentView ? CGRectGetHeight(_contentView.frame) : 0;
    }
    if ( _components & MSAlertViewComponentInput) {
        height += _inputModels ? _inputModels.count * kInputHeight : 0;
    }
    if ( _components & MSAlertViewComponentButton) {
        height += _buttonModels && _buttonModels.count > 0 ? kButtonHeight : 0;
    }
    return height;
}

@end

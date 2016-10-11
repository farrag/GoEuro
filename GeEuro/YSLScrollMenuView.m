//
//  YSLScrollMenuView.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/03/03.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLScrollMenuView.h"
#import "UILabel+LabelHeight.h"
#import "UILabel+LabelHeight.h"

static const CGFloat kYSLIndicatorHeight = 4;

@interface YSLScrollMenuView ()


@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation YSLScrollMenuView
{
    NSMutableArray *widthArray;
    CGFloat kYSLScrollMenuViewMargin;
    UIColor *mainColor;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // default
        kYSLScrollMenuViewMargin = 20;
        _itemfont = [UIFont systemFontOfSize:20.0];
        _itemTitleColor = [UIColor colorWithRed:0.866667 green:0.866667 blue:0.866667 alpha:1.0];
        _itemSelectedTitleColor = [UIColor colorWithRed:0.333333 green:0.333333 blue:0.333333 alpha:1.0];
        _itemIndicatorColor = [UIColor colorWithRed:0.168627 green:0.498039 blue:0.839216 alpha:1.0];
        
        mainColor = [UIColor colorWithRed:23/255.0 green:99/255.0 blue:161/255.0 alpha:1];
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return self;
}

#pragma mark -- Setter

- (void)setViewbackgroudColor:(UIColor *)viewbackgroudColor
{
    if (!viewbackgroudColor) { return; }
    _viewbackgroudColor = viewbackgroudColor;
    self.backgroundColor = viewbackgroudColor;
}

- (void)setItemfont:(UIFont *)itemfont
{
    if (!itemfont) { return; }
    _itemfont = itemfont;
    for (UILabel *label in _itemTitleArray) {
        label.font = itemfont;
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
    if (!itemTitleColor) { return; }
    _itemTitleColor = itemTitleColor;
    for (UILabel *label in _itemTitleArray) {
        label.textColor = itemTitleColor;
    }
}

- (void)setItemIndicatorColor:(UIColor *)itemIndicatorColor
{
    if (!itemIndicatorColor) { return; }
    _itemIndicatorColor = itemIndicatorColor;
    _indicatorView.backgroundColor = itemIndicatorColor;
}

- (void)setItemTitleArray:(NSArray *)itemTitleArray
{
    if (_itemTitleArray != itemTitleArray) {
        _itemTitleArray = itemTitleArray;
        NSMutableArray *views = [NSMutableArray array];
        
        if (itemTitleArray.count == 2 || itemTitleArray.count == 3)
        {
            kYSLScrollMenuViewMargin = 0;
        }
        
        UIFont *font = [UIFont systemFontOfSize:20.0f];
        NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                         NSForegroundColorAttributeName: [UIColor grayColor]};
        
        widthArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < itemTitleArray.count; i++) {
            

            
            if (itemTitleArray.count == 2 || itemTitleArray.count == 3)
            {
                [widthArray addObject:@(self.frame.size.width / itemTitleArray.count)];
            }
            else
            {
                [widthArray addObject:@([itemTitleArray[i] sizeWithAttributes:userAttributes].width)];
            }
            
            CGRect frame = CGRectMake(0, 0, [itemTitleArray[i] sizeWithAttributes:userAttributes].width, CGRectGetHeight(self.frame));
            UILabel *itemView = [[UILabel alloc] initWithFrame:frame];
            [self.scrollView addSubview:itemView];
            itemView.tag = i;
            itemView.text = itemTitleArray[i];
            itemView.userInteractionEnabled = YES;
            itemView.textAlignment = NSTextAlignmentCenter;
            itemView.font = font;
            itemView.textColor = _itemTitleColor;
            [views addObject:itemView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemViewTapAction:)];
            [itemView addGestureRecognizer:tapGesture];
        }
        
        self.itemViewArray = [NSArray arrayWithArray:views];
        
        // indicator
        _indicatorView = [[UIView alloc]init];
        NSLog(@"%f", [itemTitleArray[0] sizeWithAttributes:userAttributes].width);
        
        _indicatorView.frame = CGRectMake(kYSLScrollMenuViewMargin + (self.frame.size.width / itemTitleArray.count) / 2 - [itemTitleArray[0] sizeWithAttributes:userAttributes].width / 2, _scrollView.frame.size.height - kYSLIndicatorHeight, [itemTitleArray[0] sizeWithAttributes:userAttributes].width, kYSLIndicatorHeight);
        _indicatorView.backgroundColor = self.itemIndicatorColor;
        [_scrollView addSubview:_indicatorView];
    }
}

#pragma mark -- public

- (void)setIndicatorViewFrameWithRatio:(CGFloat)ratio isNextItem:(BOOL)isNextItem toIndex:(NSInteger)toIndex
{
    CGFloat indicatorX = 0.0;
    CGFloat temp = 0;
    for (int i = 0; i < toIndex; i++) {
        temp += [[widthArray objectAtIndex:i] floatValue];
    }
    
    UIFont *font = [UIFont systemFontOfSize:20.0f];
    NSDictionary *userAttributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: [UIColor grayColor]};
    
    float next = (self.frame.size.width / _itemTitleArray.count) / 2 - [_itemTitleArray[toIndex + 1] sizeWithAttributes:userAttributes].width / 2;
    
    if (isNextItem) {
        
        indicatorX = ((kYSLScrollMenuViewMargin + [[widthArray objectAtIndex:toIndex] floatValue] * ratio)) + temp + ((toIndex + 1 * ratio) * kYSLScrollMenuViewMargin) + next;
        
        float diff = [_itemTitleArray[toIndex] sizeWithAttributes:userAttributes].width - [_itemTitleArray[toIndex + 1] sizeWithAttributes:userAttributes].width;
        
        _indicatorView.frame = CGRectMake(indicatorX, _scrollView.frame.size.height - kYSLIndicatorHeight,[_itemTitleArray[toIndex + 1] sizeWithAttributes:userAttributes].width + diff * (1 - ratio) , kYSLIndicatorHeight);
        
    } else {
        indicatorX =  ((kYSLScrollMenuViewMargin + [[widthArray objectAtIndex:toIndex] floatValue] * (1 - ratio))) + temp + ((toIndex + 1 * (1 - ratio)) * kYSLScrollMenuViewMargin) + next;
        
        float diff = [_itemTitleArray[toIndex] sizeWithAttributes:userAttributes].width - [_itemTitleArray[toIndex + 1] sizeWithAttributes:userAttributes].width;
        
        _indicatorView.frame = CGRectMake(indicatorX, _scrollView.frame.size.height - kYSLIndicatorHeight,[_itemTitleArray[toIndex + 1] sizeWithAttributes:userAttributes].width + diff * (ratio) , kYSLIndicatorHeight);
    }
    
    if (indicatorX < kYSLScrollMenuViewMargin || indicatorX > self.scrollView.contentSize.width - (kYSLScrollMenuViewMargin + [[widthArray objectAtIndex:toIndex + 1] floatValue])) {
        return;
    }
}

- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex
{
    if (itemTextColor) { _itemTitleColor = itemTextColor; }
    if (selectedItemTextColor) { _itemSelectedTitleColor = selectedItemTextColor; }
    
    for (int i = 0; i < self.itemViewArray.count; i++) {
        UILabel *label = self.itemViewArray[i];
        if (i == currentIndex) {
            label.alpha = 1.0;
            label.textColor = _itemSelectedTitleColor;
        } else {
            label.textColor = _itemTitleColor;
        }
    }
}

#pragma mark -- private

// menu shadow
- (void)setShadowView
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, self.frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
    view.backgroundColor = mainColor;
    [self addSubview:view];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = kYSLScrollMenuViewMargin;
    for (NSUInteger i = 0; i < self.itemViewArray.count; i++) {
        CGFloat width = [[widthArray objectAtIndex:i] floatValue];
        UIView *itemView = self.itemViewArray[i];
        itemView.frame = CGRectMake(x, 0, width, self.scrollView.frame.size.height);
        x += width + kYSLScrollMenuViewMargin;
    }
    self.scrollView.contentSize = CGSizeMake(x, self.scrollView.frame.size.height);
    
    CGRect frame = self.scrollView.frame;
    if (self.frame.size.width > x) {
        frame.origin.x = (self.frame.size.width - x) / 2;
        frame.size.width = x;
    } else {
        frame.origin.x = 0;
        frame.size.width = self.frame.size.width;
    }
    self.scrollView.frame = frame;
}

#pragma mark -- Selector --------------------------------------- //
- (void)itemViewTapAction:(UITapGestureRecognizer *)Recongnizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenuViewSelectedIndex:)]) {
        [self.delegate scrollMenuViewSelectedIndex:[(UIGestureRecognizer*) Recongnizer view].tag];
    }
}

@end

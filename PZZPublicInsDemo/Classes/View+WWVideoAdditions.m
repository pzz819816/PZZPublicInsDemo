//
//  UIView+WWVideoAdditions.m
//  WWVideoonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+WWVideoAdditions.h"
#import <objc/runtime.h>

@implementation WWVideo_VIEW (WWVideoAdditions)

- (NSArray *)WWVideo_makeConstraints:(void(^)(WWVideoConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    WWVideoConstraintMaker *constraintMaker = [[WWVideoConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)WWVideo_updateConstraints:(void(^)(WWVideoConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    WWVideoConstraintMaker *constraintMaker = [[WWVideoConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)WWVideo_remakeConstraints:(void(^)(WWVideoConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    WWVideoConstraintMaker *constraintMaker = [[WWVideoConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (WWVideoViewAttribute *)WWVideo_left {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (WWVideoViewAttribute *)WWVideo_top {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (WWVideoViewAttribute *)WWVideo_right {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (WWVideoViewAttribute *)WWVideo_bottom {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (WWVideoViewAttribute *)WWVideo_leading {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (WWVideoViewAttribute *)WWVideo_trailing {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (WWVideoViewAttribute *)WWVideo_width {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (WWVideoViewAttribute *)WWVideo_height {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (WWVideoViewAttribute *)WWVideo_centerX {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (WWVideoViewAttribute *)WWVideo_centerY {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (WWVideoViewAttribute *)WWVideo_baseline {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (WWVideoViewAttribute *(^)(NSLayoutAttribute))WWVideo_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (WWVideoViewAttribute *)WWVideo_firstBaseline {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (WWVideoViewAttribute *)WWVideo_lastBaseline {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (WWVideoViewAttribute *)WWVideo_leftMargin {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (WWVideoViewAttribute *)WWVideo_rightMargin {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (WWVideoViewAttribute *)WWVideo_topMargin {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (WWVideoViewAttribute *)WWVideo_bottomMargin {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (WWVideoViewAttribute *)WWVideo_leadingMargin {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (WWVideoViewAttribute *)WWVideo_trailingMargin {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (WWVideoViewAttribute *)WWVideo_centerXWithinMargins {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (WWVideoViewAttribute *)WWVideo_centerYWithinMargins {
    return [[WWVideoViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

- (WWVideoViewAttribute *)WWVideo_safeAreaLayoutGuide {
    return [[WWVideoViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (WWVideoViewAttribute *)WWVideo_safeAreaLayoutGuideTop {
    return [[WWVideoViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (WWVideoViewAttribute *)WWVideo_safeAreaLayoutGuideBottom {
    return [[WWVideoViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (WWVideoViewAttribute *)WWVideo_safeAreaLayoutGuideLeft {
    return [[WWVideoViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
}
- (WWVideoViewAttribute *)WWVideo_safeAreaLayoutGuideRight {
    return [[WWVideoViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
}

#endif

#pragma mark - associated properties

- (id)WWVideo_key {
    return objc_getAssociatedObject(self, @selector(WWVideo_key));
}

- (void)setWWVideo_key:(id)key {
    objc_setAssociatedObject(self, @selector(WWVideo_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)WWVideo_closestCommonSuperview:(WWVideo_VIEW *)view {
    WWVideo_VIEW *closestCommonSuperview = nil;

    WWVideo_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        WWVideo_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end

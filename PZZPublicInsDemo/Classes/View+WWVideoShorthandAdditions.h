//
//  UIView+WWVideoShorthandAdditions.h
//  WWVideoonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+WWVideoAdditions.h"

#ifdef WWVideo_SHORTHAND

/**
 *	Shorthand view additions without the 'WWVideo_' prefixes,
 *  only enabled if WWVideo_SHORTHAND is defined
 */
@interface WWVideo_VIEW (WWVideoShorthandAdditions)

@property (nonatomic, strong, readonly) WWVideoViewAttribute *left;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *top;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *right;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *bottom;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *leading;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *trailing;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *width;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *height;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *centerX;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *centerY;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *baseline;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *(^attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) WWVideoViewAttribute *firstBaseline;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) WWVideoViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *topMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) WWVideoViewAttribute *safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) WWVideoViewAttribute *safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) WWVideoViewAttribute *safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) WWVideoViewAttribute *safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

- (NSArray *)makeConstraints:(void(^)(WWVideoConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(WWVideoConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(WWVideoConstraintMaker *make))block;

@end

#define WWVideo_ATTR_FORWARD(attr)  \
- (WWVideoViewAttribute *)attr {    \
    return [self WWVideo_##attr];   \
}

@implementation WWVideo_VIEW (WWVideoShorthandAdditions)

WWVideo_ATTR_FORWARD(top);
WWVideo_ATTR_FORWARD(left);
WWVideo_ATTR_FORWARD(bottom);
WWVideo_ATTR_FORWARD(right);
WWVideo_ATTR_FORWARD(leading);
WWVideo_ATTR_FORWARD(trailing);
WWVideo_ATTR_FORWARD(width);
WWVideo_ATTR_FORWARD(height);
WWVideo_ATTR_FORWARD(centerX);
WWVideo_ATTR_FORWARD(centerY);
WWVideo_ATTR_FORWARD(baseline);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

WWVideo_ATTR_FORWARD(firstBaseline);
WWVideo_ATTR_FORWARD(lastBaseline);

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

WWVideo_ATTR_FORWARD(leftMargin);
WWVideo_ATTR_FORWARD(rightMargin);
WWVideo_ATTR_FORWARD(topMargin);
WWVideo_ATTR_FORWARD(bottomMargin);
WWVideo_ATTR_FORWARD(leadingMargin);
WWVideo_ATTR_FORWARD(trailingMargin);
WWVideo_ATTR_FORWARD(centerXWithinMargins);
WWVideo_ATTR_FORWARD(centerYWithinMargins);

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

WWVideo_ATTR_FORWARD(safeAreaLayoutGuideTop);
WWVideo_ATTR_FORWARD(safeAreaLayoutGuideBottom);
WWVideo_ATTR_FORWARD(safeAreaLayoutGuideLeft);
WWVideo_ATTR_FORWARD(safeAreaLayoutGuideRight);

#endif

- (WWVideoViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self WWVideo_attribute];
}

- (NSArray *)makeConstraints:(void(NS_NOESCAPE ^)(WWVideoConstraintMaker *))block {
    return [self WWVideo_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(NS_NOESCAPE ^)(WWVideoConstraintMaker *))block {
    return [self WWVideo_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(NS_NOESCAPE ^)(WWVideoConstraintMaker *))block {
    return [self WWVideo_remakeConstraints:block];
}

@end

#endif

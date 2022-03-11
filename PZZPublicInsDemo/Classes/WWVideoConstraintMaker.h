//
//  WWVideoConstraintMaker.h
//  WWVideoonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "WWVideoConstraint.h"
#import "WWVideoUtilities.h"

typedef NS_OPTIONS(NSInteger, WWVideoAttribute) {
    WWVideoAttributeLeft = 1 << NSLayoutAttributeLeft,
    WWVideoAttributeRight = 1 << NSLayoutAttributeRight,
    WWVideoAttributeTop = 1 << NSLayoutAttributeTop,
    WWVideoAttributeBottom = 1 << NSLayoutAttributeBottom,
    WWVideoAttributeLeading = 1 << NSLayoutAttributeLeading,
    WWVideoAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    WWVideoAttributeWidth = 1 << NSLayoutAttributeWidth,
    WWVideoAttributeHeight = 1 << NSLayoutAttributeHeight,
    WWVideoAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    WWVideoAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    WWVideoAttributeBaseline = 1 << NSLayoutAttributeBaseline,
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    WWVideoAttributeFirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    WWVideoAttributeLastBaseline = 1 << NSLayoutAttributeLastBaseline,
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    WWVideoAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    WWVideoAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    WWVideoAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    WWVideoAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    WWVideoAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    WWVideoAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    WWVideoAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    WWVideoAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

/**
 *  Provides factory methods for creating WWVideoConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface WWVideoConstraintMaker : NSObject

/**
 *	The following properties return a new WWVideoViewConstraint
 *  with the first item set to the makers associated view and the appropriate WWVideoViewAttribute
 */
@property (nonatomic, strong, readonly) WWVideoConstraint *left;
@property (nonatomic, strong, readonly) WWVideoConstraint *top;
@property (nonatomic, strong, readonly) WWVideoConstraint *right;
@property (nonatomic, strong, readonly) WWVideoConstraint *bottom;
@property (nonatomic, strong, readonly) WWVideoConstraint *leading;
@property (nonatomic, strong, readonly) WWVideoConstraint *trailing;
@property (nonatomic, strong, readonly) WWVideoConstraint *width;
@property (nonatomic, strong, readonly) WWVideoConstraint *height;
@property (nonatomic, strong, readonly) WWVideoConstraint *centerX;
@property (nonatomic, strong, readonly) WWVideoConstraint *centerY;
@property (nonatomic, strong, readonly) WWVideoConstraint *baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) WWVideoConstraint *firstBaseline;
@property (nonatomic, strong, readonly) WWVideoConstraint *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) WWVideoConstraint *leftMargin;
@property (nonatomic, strong, readonly) WWVideoConstraint *rightMargin;
@property (nonatomic, strong, readonly) WWVideoConstraint *topMargin;
@property (nonatomic, strong, readonly) WWVideoConstraint *bottomMargin;
@property (nonatomic, strong, readonly) WWVideoConstraint *leadingMargin;
@property (nonatomic, strong, readonly) WWVideoConstraint *trailingMargin;
@property (nonatomic, strong, readonly) WWVideoConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) WWVideoConstraint *centerYWithinMargins;

#endif

/**
 *  Returns a block which creates a new WWVideoCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  WWVideoAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) WWVideoConstraint *(^attributes)(WWVideoAttribute attrs);

/**
 *	Creates a WWVideoCompositeConstraint with type WWVideoCompositeConstraintTypeEdges
 *  which generates the appropriate WWVideoViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) WWVideoConstraint *edges;

/**
 *	Creates a WWVideoCompositeConstraint with type WWVideoCompositeConstraintTypeSize
 *  which generates the appropriate WWVideoViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) WWVideoConstraint *size;

/**
 *	Creates a WWVideoCompositeConstraint with type WWVideoCompositeConstraintTypeCenter
 *  which generates the appropriate WWVideoViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) WWVideoConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any WWVideoConstraint are created with this view as the first item
 *
 *	@return	a new WWVideoConstraintMaker
 */
- (id)initWithView:(WWVideo_VIEW *)view;

/**
 *	Calls install method on any WWVideoConstraints which have been created by this maker
 *
 *	@return	an array of all the installed WWVideoConstraints
 */
- (NSArray *)install;

- (WWVideoConstraint * (^)(dispatch_block_t))group;

@end

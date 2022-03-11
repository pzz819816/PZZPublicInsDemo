//
//  UIView+WWVideoAdditions.h
//  WWVideoonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "WWVideoUtilities.h"
#import "WWVideoConstraintMaker.h"
#import "WWVideoViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating WWVideoViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface WWVideo_VIEW (WWVideoAdditions)

/**
 *	following properties return a new WWVideoViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_left;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_top;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_right;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_bottom;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_leading;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_trailing;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_width;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_height;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_centerX;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_centerY;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_baseline;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *(^WWVideo_attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_firstBaseline;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_leftMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_rightMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_topMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_bottomMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_leadingMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_trailingMargin;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_centerXWithinMargins;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_safeAreaLayoutGuide API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id WWVideo_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)WWVideo_closestCommonSuperview:(WWVideo_VIEW *)view;

/**
 *  Creates a WWVideoConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created WWVideoConstraints
 */
- (NSArray *)WWVideo_makeConstraints:(void(NS_NOESCAPE ^)(WWVideoConstraintMaker *make))block;

/**
 *  Creates a WWVideoConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated WWVideoConstraints
 */
- (NSArray *)WWVideo_updateConstraints:(void(NS_NOESCAPE ^)(WWVideoConstraintMaker *make))block;

/**
 *  Creates a WWVideoConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated WWVideoConstraints
 */
- (NSArray *)WWVideo_remakeConstraints:(void(NS_NOESCAPE ^)(WWVideoConstraintMaker *make))block;

@end

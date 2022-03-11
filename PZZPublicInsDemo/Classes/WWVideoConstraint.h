//
//  WWVideoConstraint.h
//  WWVideoonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "WWVideoUtilities.h"

/**
 *	Enables Constraints to be created with chainable syntax
 *  Constraint can represent single NSLayoutConstraint (WWVideoViewConstraint) 
 *  or a group of NSLayoutConstraints (WWVideoComposisteConstraint)
 */
@interface WWVideoConstraint : NSObject

// Chaining Support

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects WWVideoConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (WWVideoConstraint * (^)(WWVideoEdgeInsets insets))insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects WWVideoConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (WWVideoConstraint * (^)(CGFloat inset))inset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects WWVideoConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (WWVideoConstraint * (^)(CGSize offset))sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects WWVideoConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (WWVideoConstraint * (^)(CGPoint offset))centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (WWVideoConstraint * (^)(CGFloat offset))offset;

/**
 *  Modifies the NSLayoutConstraint constant based on a value type
 */
- (WWVideoConstraint * (^)(NSValue *value))valueOffset;

/**
 *	Sets the NSLayoutConstraint multiplier property
 */
- (WWVideoConstraint * (^)(CGFloat multiplier))multipliedBy;

/**
 *	Sets the NSLayoutConstraint multiplier to 1.0/dividedBy
 */
- (WWVideoConstraint * (^)(CGFloat divider))dividedBy;

/**
 *	Sets the NSLayoutConstraint priority to a float or WWVideoLayoutPriority
 */
- (WWVideoConstraint * (^)(WWVideoLayoutPriority priority))priority;

/**
 *	Sets the NSLayoutConstraint priority to WWVideoLayoutPriorityLow
 */
- (WWVideoConstraint * (^)(void))priorityLow;

/**
 *	Sets the NSLayoutConstraint priority to WWVideoLayoutPriorityMedium
 */
- (WWVideoConstraint * (^)(void))priorityMedium;

/**
 *	Sets the NSLayoutConstraint priority to WWVideoLayoutPriorityHigh
 */
- (WWVideoConstraint * (^)(void))priorityHigh;

/**
 *	Sets the constraint relation to NSLayoutRelationEqual
 *  returns a block which accepts one of the following:
 *    WWVideoViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (WWVideoConstraint * (^)(id attr))equalTo;

/**
 *	Sets the constraint relation to NSLayoutRelationGreaterThanOrEqual
 *  returns a block which accepts one of the following:
 *    WWVideoViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (WWVideoConstraint * (^)(id attr))greaterThanOrEqualTo;

/**
 *	Sets the constraint relation to NSLayoutRelationLessThanOrEqual
 *  returns a block which accepts one of the following:
 *    WWVideoViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (WWVideoConstraint * (^)(id attr))lessThanOrEqualTo;

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
- (WWVideoConstraint *)with;

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
- (WWVideoConstraint *)and;

/**
 *	Creates a new WWVideoCompositeConstraint with the called attribute and reciever
 */
- (WWVideoConstraint *)left;
- (WWVideoConstraint *)top;
- (WWVideoConstraint *)right;
- (WWVideoConstraint *)bottom;
- (WWVideoConstraint *)leading;
- (WWVideoConstraint *)trailing;
- (WWVideoConstraint *)width;
- (WWVideoConstraint *)height;
- (WWVideoConstraint *)centerX;
- (WWVideoConstraint *)centerY;
- (WWVideoConstraint *)baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (WWVideoConstraint *)firstBaseline;
- (WWVideoConstraint *)lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (WWVideoConstraint *)leftMargin;
- (WWVideoConstraint *)rightMargin;
- (WWVideoConstraint *)topMargin;
- (WWVideoConstraint *)bottomMargin;
- (WWVideoConstraint *)leadingMargin;
- (WWVideoConstraint *)trailingMargin;
- (WWVideoConstraint *)centerXWithinMargins;
- (WWVideoConstraint *)centerYWithinMargins;

#endif


/**
 *	Sets the constraint debug name
 */
- (WWVideoConstraint * (^)(id key))key;

// NSLayoutConstraint constant Setters
// for use outside of WWVideo_updateConstraints/WWVideo_makeConstraints blocks

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects WWVideoConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInsets:(WWVideoEdgeInsets)insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects WWVideoConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInset:(CGFloat)inset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects WWVideoConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (void)setSizeOffset:(CGSize)sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects WWVideoConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (void)setCenterOffset:(CGPoint)centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (void)setOffset:(CGFloat)offset;


// NSLayoutConstraint Installation support

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
/**
 *  Whether or not to go through the animator proxy when modifying the constraint
 */
@property (nonatomic, copy, readonly) WWVideoConstraint *animator;
#endif

/**
 *  Activates an NSLayoutConstraint if it's supported by an OS. 
 *  Invokes install otherwise.
 */
- (void)activate;

/**
 *  Deactivates previously installed/activated NSLayoutConstraint.
 */
- (void)deactivate;

/**
 *	Creates a NSLayoutConstraint and adds it to the appropriate view.
 */
- (void)install;

/**
 *	Removes previously installed NSLayoutConstraint
 */
- (void)uninstall;

@end


/**
 *  Convenience auto-boxing macros for WWVideoConstraint methods.
 *
 *  Defining WWVideo_SHORTHAND_GLOBALS will turn on auto-boxing for default syntax.
 *  A potential drawback of this is that the unprefixed macros will appear in global scope.
 */
#define WWVideo_equalTo(...)                 equalTo(WWVideoBoxValue((__VA_ARGS__)))
#define WWVideo_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(WWVideoBoxValue((__VA_ARGS__)))
#define WWVideo_lessThanOrEqualTo(...)       lessThanOrEqualTo(WWVideoBoxValue((__VA_ARGS__)))

#define WWVideo_offset(...)                  valueOffset(WWVideoBoxValue((__VA_ARGS__)))


#ifdef WWVideo_SHORTHAND_GLOBALS

#define equalTo(...)                     WWVideo_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        WWVideo_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           WWVideo_lessThanOrEqualTo(__VA_ARGS__)

#define offset(...)                      WWVideo_offset(__VA_ARGS__)

#endif


@interface WWVideoConstraint (AutoboxingSupport)

/**
 *  Aliases to corresponding relation methods (for shorthand macros)
 *  Also needed to aid autocompletion
 */
- (WWVideoConstraint * (^)(id attr))WWVideo_equalTo;
- (WWVideoConstraint * (^)(id attr))WWVideo_greaterThanOrEqualTo;
- (WWVideoConstraint * (^)(id attr))WWVideo_lessThanOrEqualTo;

/**
 *  A dummy method to aid autocompletion
 */
- (WWVideoConstraint * (^)(id offset))WWVideo_offset;

@end

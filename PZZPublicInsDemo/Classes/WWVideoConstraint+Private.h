//
//  WWVideoConstraint+Private.h
//  WWVideoonry
//
//  Created by Nick Tymchenko on 29/04/14.
//  Copyright (c) 2014 cloudling. All rights reserved.
//

#import "WWVideoConstraint.h"

@protocol WWVideoConstraintDelegate;


@interface WWVideoConstraint ()

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *	Usually WWVideoConstraintMaker but could be a parent WWVideoConstraint
 */
@property (nonatomic, weak) id<WWVideoConstraintDelegate> delegate;

/**
 *  Based on a provided value type, is equal to calling:
 *  NSNumber - setOffset:
 *  NSValue with CGPoint - setPointOffset:
 *  NSValue with CGSize - setSizeOffset:
 *  NSValue with WWVideoEdgeInsets - setInsets:
 */
- (void)setLayoutConstantWithValue:(NSValue *)value;

@end


@interface WWVideoConstraint (Abstract)

/**
 *	Sets the constraint relation to given NSLayoutRelation
 *  returns a block which accepts one of the following:
 *    WWVideoViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (WWVideoConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;

/**
 *	Override to set a custom chaining behaviour
 */
- (WWVideoConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end


@protocol WWVideoConstraintDelegate <NSObject>

/**
 *	Notifies the delegate when the constraint needs to be replaced with another constraint. For example
 *  A WWVideoViewConstraint may turn into a WWVideoCompositeConstraint when an array is passed to one of the equality blocks
 */
- (void)constraint:(WWVideoConstraint *)constraint shouldBeReplacedWithConstraint:(WWVideoConstraint *)replacementConstraint;

- (WWVideoConstraint *)constraint:(WWVideoConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end

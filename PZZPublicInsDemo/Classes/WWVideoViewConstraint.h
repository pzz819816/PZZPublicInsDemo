//
//  WWVideoViewConstraint.h
//  WWVideoonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "WWVideoViewAttribute.h"
#import "WWVideoConstraint.h"
#import "WWVideoLayoutConstraint.h"
#import "WWVideoUtilities.h"

/**
 *  A single constraint.
 *  Contains the attributes neccessary for creating a NSLayoutConstraint and adding it to the appropriate view
 */
@interface WWVideoViewConstraint : WWVideoConstraint <NSCopying>

/**
 *	First item/view and first attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) WWVideoViewAttribute *firstViewAttribute;

/**
 *	Second item/view and second attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) WWVideoViewAttribute *secondViewAttribute;

/**
 *	initialises the WWVideoViewConstraint with the first part of the equation
 *
 *	@param	firstViewAttribute	view.WWVideo_left, view.WWVideo_width etc.
 *
 *	@return	a new view constraint
 */
- (id)initWithFirstViewAttribute:(WWVideoViewAttribute *)firstViewAttribute;

/**
 *  Returns all WWVideoViewConstraints installed with this view as a first item.
 *
 *  @param  view  A view to retrieve constraints for.
 *
 *  @return An array of WWVideoViewConstraints.
 */
+ (NSArray *)installedConstraintsForView:(WWVideo_VIEW *)view;

@end

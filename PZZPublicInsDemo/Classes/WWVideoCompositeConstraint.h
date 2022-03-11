//
//  WWVideoCompositeConstraint.h
//  WWVideoonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "WWVideoConstraint.h"
#import "WWVideoUtilities.h"

/**
 *	A group of WWVideoConstraint objects
 */
@interface WWVideoCompositeConstraint : WWVideoConstraint

/**
 *	Creates a composite with a predefined array of children
 *
 *	@param	children	child WWVideoConstraints
 *
 *	@return	a composite constraint
 */
- (id)initWithChildren:(NSArray *)children;

@end

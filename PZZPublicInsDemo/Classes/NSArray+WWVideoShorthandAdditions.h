//
//  NSArray+WWVideoShorthandAdditions.h
//  WWVideoonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+WWVideoAdditions.h"

#ifdef WWVideo_SHORTHAND

/**
 *	Shorthand array additions without the 'WWVideo_' prefixes,
 *  only enabled if WWVideo_SHORTHAND is defined
 */
@interface NSArray (WWVideoShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(WWVideoConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(WWVideoConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(WWVideoConstraintMaker *make))block;

@end

@implementation NSArray (WWVideoShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(WWVideoConstraintMaker *))block {
    return [self WWVideo_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(WWVideoConstraintMaker *))block {
    return [self WWVideo_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(WWVideoConstraintMaker *))block {
    return [self WWVideo_remakeConstraints:block];
}

@end

#endif

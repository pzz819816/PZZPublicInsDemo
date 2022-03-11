//
//  WWVideoCompositeConstraint.m
//  WWVideoonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "WWVideoCompositeConstraint.h"
#import "WWVideoConstraint+Private.h"

@interface WWVideoCompositeConstraint () <WWVideoConstraintDelegate>

@property (nonatomic, strong) id WWVideo_key;
@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

@implementation WWVideoCompositeConstraint

- (id)initWithChildren:(NSArray *)children {
    self = [super init];
    if (!self) return nil;

    _childConstraints = [children mutableCopy];
    for (WWVideoConstraint *constraint in _childConstraints) {
        constraint.delegate = self;
    }

    return self;
}

#pragma mark - WWVideoConstraintDelegate

- (void)constraint:(WWVideoConstraint *)constraint shouldBeReplacedWithConstraint:(WWVideoConstraint *)replacementConstraint {
    NSUInteger index = [self.childConstraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.childConstraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (WWVideoConstraint *)constraint:(WWVideoConstraint __unused *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    id<WWVideoConstraintDelegate> strongDelegate = self.delegate;
    WWVideoConstraint *newConstraint = [strongDelegate constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    newConstraint.delegate = self;
    [self.childConstraints addObject:newConstraint];
    return newConstraint;
}

#pragma mark - NSLayoutConstraint multiplier proxies 

- (WWVideoConstraint * (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        for (WWVideoConstraint *constraint in self.childConstraints) {
            constraint.multipliedBy(multiplier);
        }
        return self;
    };
}

- (WWVideoConstraint * (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        for (WWVideoConstraint *constraint in self.childConstraints) {
            constraint.dividedBy(divider);
        }
        return self;
    };
}

#pragma mark - WWVideoLayoutPriority proxy

- (WWVideoConstraint * (^)(WWVideoLayoutPriority))priority {
    return ^id(WWVideoLayoutPriority priority) {
        for (WWVideoConstraint *constraint in self.childConstraints) {
            constraint.priority(priority);
        }
        return self;
    };
}

#pragma mark - NSLayoutRelation proxy

- (WWVideoConstraint * (^)(id, NSLayoutRelation))equalToWithRelation {
    return ^id(id attr, NSLayoutRelation relation) {
        for (WWVideoConstraint *constraint in self.childConstraints.copy) {
            constraint.equalToWithRelation(attr, relation);
        }
        return self;
    };
}

#pragma mark - attribute chaining

- (WWVideoConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    [self constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    return self;
}

#pragma mark - Animator proxy

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (WWVideoConstraint *)animator {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        [constraint animator];
    }
    return self;
}

#endif

#pragma mark - debug helpers

- (WWVideoConstraint * (^)(id))key {
    return ^id(id key) {
        self.WWVideo_key = key;
        int i = 0;
        for (WWVideoConstraint *constraint in self.childConstraints) {
            constraint.key([NSString stringWithFormat:@"%@[%d]", key, i++]);
        }
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant setters

- (void)setInsets:(WWVideoEdgeInsets)insets {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        constraint.insets = insets;
    }
}

- (void)setInset:(CGFloat)inset {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        constraint.inset = inset;
    }
}

- (void)setOffset:(CGFloat)offset {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        constraint.offset = offset;
    }
}

- (void)setSizeOffset:(CGSize)sizeOffset {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        constraint.sizeOffset = sizeOffset;
    }
}

- (void)setCenterOffset:(CGPoint)centerOffset {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        constraint.centerOffset = centerOffset;
    }
}

#pragma mark - WWVideoConstraint

- (void)activate {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        [constraint activate];
    }
}

- (void)deactivate {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        [constraint deactivate];
    }
}

- (void)install {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
}

- (void)uninstall {
    for (WWVideoConstraint *constraint in self.childConstraints) {
        [constraint uninstall];
    }
}

@end

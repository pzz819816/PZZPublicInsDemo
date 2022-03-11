//
//  WWVideoConstraintMaker.m
//  WWVideoonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "WWVideoConstraintMaker.h"
#import "WWVideoViewConstraint.h"
#import "WWVideoCompositeConstraint.h"
#import "WWVideoConstraint+Private.h"
#import "WWVideoViewAttribute.h"
#import "View+WWVideoAdditions.h"

@interface WWVideoConstraintMaker () <WWVideoConstraintDelegate>

@property (nonatomic, weak) WWVideo_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation WWVideoConstraintMaker

- (id)initWithView:(WWVideo_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [WWVideoViewConstraint installedConstraintsForView:self.view];
        for (WWVideoConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (WWVideoConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - WWVideoConstraintDelegate

- (void)constraint:(WWVideoConstraint *)constraint shouldBeReplacedWithConstraint:(WWVideoConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (WWVideoConstraint *)constraint:(WWVideoConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    WWVideoViewAttribute *viewAttribute = [[WWVideoViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    WWVideoViewConstraint *newConstraint = [[WWVideoViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:WWVideoViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        WWVideoCompositeConstraint *compositeConstraint = [[WWVideoCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (WWVideoConstraint *)addConstraintWithAttributes:(WWVideoAttribute)attrs {
    __unused WWVideoAttribute anyAttribute = (WWVideoAttributeLeft | WWVideoAttributeRight | WWVideoAttributeTop | WWVideoAttributeBottom | WWVideoAttributeLeading
                                          | WWVideoAttributeTrailing | WWVideoAttributeWidth | WWVideoAttributeHeight | WWVideoAttributeCenterX
                                          | WWVideoAttributeCenterY | WWVideoAttributeBaseline
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
                                          | WWVideoAttributeFirstBaseline | WWVideoAttributeLastBaseline
#endif
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
                                          | WWVideoAttributeLeftMargin | WWVideoAttributeRightMargin | WWVideoAttributeTopMargin | WWVideoAttributeBottomMargin
                                          | WWVideoAttributeLeadingMargin | WWVideoAttributeTrailingMargin | WWVideoAttributeCenterXWithinMargins
                                          | WWVideoAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & WWVideoAttributeLeft) [attributes addObject:self.view.WWVideo_left];
    if (attrs & WWVideoAttributeRight) [attributes addObject:self.view.WWVideo_right];
    if (attrs & WWVideoAttributeTop) [attributes addObject:self.view.WWVideo_top];
    if (attrs & WWVideoAttributeBottom) [attributes addObject:self.view.WWVideo_bottom];
    if (attrs & WWVideoAttributeLeading) [attributes addObject:self.view.WWVideo_leading];
    if (attrs & WWVideoAttributeTrailing) [attributes addObject:self.view.WWVideo_trailing];
    if (attrs & WWVideoAttributeWidth) [attributes addObject:self.view.WWVideo_width];
    if (attrs & WWVideoAttributeHeight) [attributes addObject:self.view.WWVideo_height];
    if (attrs & WWVideoAttributeCenterX) [attributes addObject:self.view.WWVideo_centerX];
    if (attrs & WWVideoAttributeCenterY) [attributes addObject:self.view.WWVideo_centerY];
    if (attrs & WWVideoAttributeBaseline) [attributes addObject:self.view.WWVideo_baseline];
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    if (attrs & WWVideoAttributeFirstBaseline) [attributes addObject:self.view.WWVideo_firstBaseline];
    if (attrs & WWVideoAttributeLastBaseline) [attributes addObject:self.view.WWVideo_lastBaseline];
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    if (attrs & WWVideoAttributeLeftMargin) [attributes addObject:self.view.WWVideo_leftMargin];
    if (attrs & WWVideoAttributeRightMargin) [attributes addObject:self.view.WWVideo_rightMargin];
    if (attrs & WWVideoAttributeTopMargin) [attributes addObject:self.view.WWVideo_topMargin];
    if (attrs & WWVideoAttributeBottomMargin) [attributes addObject:self.view.WWVideo_bottomMargin];
    if (attrs & WWVideoAttributeLeadingMargin) [attributes addObject:self.view.WWVideo_leadingMargin];
    if (attrs & WWVideoAttributeTrailingMargin) [attributes addObject:self.view.WWVideo_trailingMargin];
    if (attrs & WWVideoAttributeCenterXWithinMargins) [attributes addObject:self.view.WWVideo_centerXWithinMargins];
    if (attrs & WWVideoAttributeCenterYWithinMargins) [attributes addObject:self.view.WWVideo_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (WWVideoViewAttribute *a in attributes) {
        [children addObject:[[WWVideoViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    WWVideoCompositeConstraint *constraint = [[WWVideoCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (WWVideoConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (WWVideoConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (WWVideoConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (WWVideoConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (WWVideoConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (WWVideoConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (WWVideoConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (WWVideoConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (WWVideoConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (WWVideoConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (WWVideoConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (WWVideoConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (WWVideoConstraint *(^)(WWVideoAttribute))attributes {
    return ^(WWVideoAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (WWVideoConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (WWVideoConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif


#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (WWVideoConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (WWVideoConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (WWVideoConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (WWVideoConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (WWVideoConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (WWVideoConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (WWVideoConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (WWVideoConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (WWVideoConstraint *)edges {
    return [self addConstraintWithAttributes:WWVideoAttributeTop | WWVideoAttributeLeft | WWVideoAttributeRight | WWVideoAttributeBottom];
}

- (WWVideoConstraint *)size {
    return [self addConstraintWithAttributes:WWVideoAttributeWidth | WWVideoAttributeHeight];
}

- (WWVideoConstraint *)center {
    return [self addConstraintWithAttributes:WWVideoAttributeCenterX | WWVideoAttributeCenterY];
}

#pragma mark - grouping

- (WWVideoConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        WWVideoCompositeConstraint *constraint = [[WWVideoCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end

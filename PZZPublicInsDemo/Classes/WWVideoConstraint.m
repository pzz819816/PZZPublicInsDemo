//
//  WWVideoConstraint.m
//  WWVideoonry
//
//  Created by Nick Tymchenko on 1/20/14.
//

#import "WWVideoConstraint.h"
#import "WWVideoConstraint+Private.h"

#define WWVideoMethodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]

@implementation WWVideoConstraint

#pragma mark - Init

- (id)init {
	NSAssert(![self isMemberOfClass:[WWVideoConstraint class]], @"WWVideoConstraint is an abstract class, you should not instantiate it directly.");
	return [super init];
}

#pragma mark - NSLayoutRelation proxies

- (WWVideoConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (WWVideoConstraint * (^)(id))WWVideo_equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (WWVideoConstraint * (^)(id))greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (WWVideoConstraint * (^)(id))WWVideo_greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (WWVideoConstraint * (^)(id))lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

- (WWVideoConstraint * (^)(id))WWVideo_lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

#pragma mark - WWVideoLayoutPriority proxies

- (WWVideoConstraint * (^)(void))priorityLow {
    return ^id{
        self.priority(WWVideoLayoutPriorityDefaultLow);
        return self;
    };
}

- (WWVideoConstraint * (^)(void))priorityMedium {
    return ^id{
        self.priority(WWVideoLayoutPriorityDefaultMedium);
        return self;
    };
}

- (WWVideoConstraint * (^)(void))priorityHigh {
    return ^id{
        self.priority(WWVideoLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant proxies

- (WWVideoConstraint * (^)(WWVideoEdgeInsets))insets {
    return ^id(WWVideoEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}

- (WWVideoConstraint * (^)(CGFloat))inset {
    return ^id(CGFloat inset){
        self.inset = inset;
        return self;
    };
}

- (WWVideoConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}

- (WWVideoConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}

- (WWVideoConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}

- (WWVideoConstraint * (^)(NSValue *value))valueOffset {
    return ^id(NSValue *offset) {
        NSAssert([offset isKindOfClass:NSValue.class], @"expected an NSValue offset, got: %@", offset);
        [self setLayoutConstantWithValue:offset];
        return self;
    };
}

- (WWVideoConstraint * (^)(id offset))WWVideo_offset {
    // Will never be called due to macro
    return nil;
}

#pragma mark - NSLayoutConstraint constant setter

- (void)setLayoutConstantWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.centerOffset = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.sizeOffset = size;
    } else if (strcmp(value.objCType, @encode(WWVideoEdgeInsets)) == 0) {
        WWVideoEdgeInsets insets;
        [value getValue:&insets];
        self.insets = insets;
    } else {
        NSAssert(NO, @"attempting to set layout constant with unsupported value: %@", value);
    }
}

#pragma mark - Semantic properties

- (WWVideoConstraint *)with {
    return self;
}

- (WWVideoConstraint *)and {
    return self;
}

#pragma mark - Chaining

- (WWVideoConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute __unused)layoutAttribute {
    WWVideoMethodNotImplemented();
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

#pragma mark - Abstract

- (WWVideoConstraint * (^)(CGFloat multiplier))multipliedBy { WWVideoMethodNotImplemented(); }

- (WWVideoConstraint * (^)(CGFloat divider))dividedBy { WWVideoMethodNotImplemented(); }

- (WWVideoConstraint * (^)(WWVideoLayoutPriority priority))priority { WWVideoMethodNotImplemented(); }

- (WWVideoConstraint * (^)(id, NSLayoutRelation))equalToWithRelation { WWVideoMethodNotImplemented(); }

- (WWVideoConstraint * (^)(id key))key { WWVideoMethodNotImplemented(); }

- (void)setInsets:(WWVideoEdgeInsets __unused)insets { WWVideoMethodNotImplemented(); }

- (void)setInset:(CGFloat __unused)inset { WWVideoMethodNotImplemented(); }

- (void)setSizeOffset:(CGSize __unused)sizeOffset { WWVideoMethodNotImplemented(); }

- (void)setCenterOffset:(CGPoint __unused)centerOffset { WWVideoMethodNotImplemented(); }

- (void)setOffset:(CGFloat __unused)offset { WWVideoMethodNotImplemented(); }

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (WWVideoConstraint *)animator { WWVideoMethodNotImplemented(); }

#endif

- (void)activate { WWVideoMethodNotImplemented(); }

- (void)deactivate { WWVideoMethodNotImplemented(); }

- (void)install { WWVideoMethodNotImplemented(); }

- (void)uninstall { WWVideoMethodNotImplemented(); }

@end

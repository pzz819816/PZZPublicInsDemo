//
//  NSArray+WWVideoAdditions.m
//  
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "NSArray+WWVideoAdditions.h"
#import "View+WWVideoAdditions.h"

@implementation NSArray (WWVideoAdditions)

- (NSArray *)WWVideo_makeConstraints:(void(^)(WWVideoConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (WWVideo_VIEW *view in self) {
        NSAssert([view isKindOfClass:[WWVideo_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view WWVideo_makeConstraints:block]];
    }
    return constraints;
}

- (NSArray *)WWVideo_updateConstraints:(void(^)(WWVideoConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (WWVideo_VIEW *view in self) {
        NSAssert([view isKindOfClass:[WWVideo_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view WWVideo_updateConstraints:block]];
    }
    return constraints;
}

- (NSArray *)WWVideo_remakeConstraints:(void(^)(WWVideoConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (WWVideo_VIEW *view in self) {
        NSAssert([view isKindOfClass:[WWVideo_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view WWVideo_remakeConstraints:block]];
    }
    return constraints;
}

- (void)WWVideo_distributeViewsAlongAxis:(WWVideoAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    WWVideo_VIEW *tempSuperView = [self WWVideo_commonSuperviewOfViews];
    if (axisType == WWVideoAxisTypeHorizontal) {
        WWVideo_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            WWVideo_VIEW *v = self[i];
            [v WWVideo_makeConstraints:^(WWVideoConstraintMaker *make) {
                if (prev) {
                    make.width.equalTo(prev);
                    make.left.equalTo(prev.WWVideo_right).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
    else {
        WWVideo_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            WWVideo_VIEW *v = self[i];
            [v WWVideo_makeConstraints:^(WWVideoConstraintMaker *make) {
                if (prev) {
                    make.height.equalTo(prev);
                    make.top.equalTo(prev.WWVideo_bottom).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }                    
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
}

- (void)WWVideo_distributeViewsAlongAxis:(WWVideoAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    WWVideo_VIEW *tempSuperView = [self WWVideo_commonSuperviewOfViews];
    if (axisType == WWVideoAxisTypeHorizontal) {
        WWVideo_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            WWVideo_VIEW *v = self[i];
            [v WWVideo_makeConstraints:^(WWVideoConstraintMaker *make) {
                make.width.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        WWVideo_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            WWVideo_VIEW *v = self[i];
            [v WWVideo_makeConstraints:^(WWVideoConstraintMaker *make) {
                make.height.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (WWVideo_VIEW *)WWVideo_commonSuperviewOfViews
{
    WWVideo_VIEW *commonSuperview = nil;
    WWVideo_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[WWVideo_VIEW class]]) {
            WWVideo_VIEW *view = (WWVideo_VIEW *)object;
            if (previousView) {
                commonSuperview = [view WWVideo_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end

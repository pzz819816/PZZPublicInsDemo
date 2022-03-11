//
//  WWVideoViewAttribute.m
//  WWVideoonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "WWVideoViewAttribute.h"

@implementation WWVideoViewAttribute

- (id)initWithView:(WWVideo_VIEW *)view layoutAttribute:(NSLayoutAttribute)layoutAttribute {
    self = [self initWithView:view item:view layoutAttribute:layoutAttribute];
    return self;
}

- (id)initWithView:(WWVideo_VIEW *)view item:(id)item layoutAttribute:(NSLayoutAttribute)layoutAttribute {
    self = [super init];
    if (!self) return nil;
    
    _view = view;
    _item = item;
    _layoutAttribute = layoutAttribute;
    
    return self;
}

- (BOOL)isSizeAttribute {
    return self.layoutAttribute == NSLayoutAttributeWidth
        || self.layoutAttribute == NSLayoutAttributeHeight;
}

- (BOOL)isEqual:(WWVideoViewAttribute *)viewAttribute {
    if ([viewAttribute isKindOfClass:self.class]) {
        return self.view == viewAttribute.view
            && self.layoutAttribute == viewAttribute.layoutAttribute;
    }
    return [super isEqual:viewAttribute];
}

- (NSUInteger)hash {
    return WWVideo_NSUINTROTATE([self.view hash], WWVideo_NSUINT_BIT / 2) ^ self.layoutAttribute;
}

@end

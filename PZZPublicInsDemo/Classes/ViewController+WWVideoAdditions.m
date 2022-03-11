//
//  UIViewController+WWVideoAdditions.m
//  WWVideoonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+WWVideoAdditions.h"

#ifdef WWVideo_VIEW_CONTROLLER

@implementation WWVideo_VIEW_CONTROLLER (WWVideoAdditions)

- (WWVideoViewAttribute *)WWVideo_topLayoutGuide {
    return [[WWVideoViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (WWVideoViewAttribute *)WWVideo_topLayoutGuideTop {
    return [[WWVideoViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (WWVideoViewAttribute *)WWVideo_topLayoutGuideBottom {
    return [[WWVideoViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (WWVideoViewAttribute *)WWVideo_bottomLayoutGuide {
    return [[WWVideoViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (WWVideoViewAttribute *)WWVideo_bottomLayoutGuideTop {
    return [[WWVideoViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (WWVideoViewAttribute *)WWVideo_bottomLayoutGuideBottom {
    return [[WWVideoViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}



@end

#endif

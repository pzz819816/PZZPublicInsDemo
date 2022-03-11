//
//  UIViewController+WWVideoAdditions.h
//  WWVideoonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "WWVideoUtilities.h"
#import "WWVideoConstraintMaker.h"
#import "WWVideoViewAttribute.h"

#ifdef WWVideo_VIEW_CONTROLLER

@interface WWVideo_VIEW_CONTROLLER (WWVideoAdditions)

/**
 *	following properties return a new WWVideoViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_topLayoutGuide;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_bottomLayoutGuide;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_topLayoutGuideTop;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) WWVideoViewAttribute *WWVideo_bottomLayoutGuideBottom;


@end

#endif

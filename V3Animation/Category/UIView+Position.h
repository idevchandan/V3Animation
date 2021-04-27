//
//  UIView+Position.h
//  TestAnimation
//
//  Created by Chandan Kumar on 27/04/21.
//

#import <UIKit/UIKit.h>

typedef enum
{
    eVIEW_TOP_CENTER            = 1,
    eVIEW_TOP_RIGHT_CORNER,
    eVIEW_RIGHT_CENTER,
    eVIEW_BOTTOM_RIGHT_CORNER,
    eVIEW_BOTTOM_CENTER,
    eVIEW_BOTTOM_LEFT_CORNER,
    eVIEW_LEFT_CENTER,
    eVIEW_TOP_LEFT_CORNER,
}ViewAlignment;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Position)

+ (CGRect)frameForViewOfSize:(CGSize)childSize withAlignment:(ViewAlignment)childAlignment alignedWithParentViews:(UIView *)parentView withAlignment:(ViewAlignment)parentAlignment;
+ (CGRect)rectAnimationPercent:(float)percent betweenStartingFrame:(CGRect)staringFrame endingFrame:(CGRect)endingFrame;
+ (ViewAlignment)adjoiningWithViewAlignment:(ViewAlignment)viewAlignment;

@end

NS_ASSUME_NONNULL_END

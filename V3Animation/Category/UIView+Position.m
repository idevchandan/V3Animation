//
//  UIView+Position.m
//  TestAnimation
//
//  Created by Chandan Kumar on 27/04/21.
//

#import "UIView+Position.h"

#define kHALF_VALUE 0.5f

@implementation UIView (Position)

+ (CGRect)frameForViewOfSize:(CGSize)childSize withAlignment:(ViewAlignment)childAlignment alignedWithParentViews:(UIView *)parentView withAlignment:(ViewAlignment)parentAlignment
{
    CGPoint parentPoint  = [UIView pointOnSize:parentView.frame.size forViewAlignment:parentAlignment];
    CGPoint childOffset = [UIView pointOnSize:childSize forViewAlignment:childAlignment];
    
    CGRect rect = { [UIView point:parentPoint offsetByPoint:childOffset], childSize};
    return rect;
}

+ (CGPoint)pointOnSize:(CGSize)size forViewAlignment:(ViewAlignment)viewAlignment
{
    switch (viewAlignment) {
        case eVIEW_TOP_CENTER:
            return CGPointMake(size.width * kHALF_VALUE, 0.0f);
            break;
        case eVIEW_TOP_RIGHT_CORNER:
            return CGPointMake(size.width, 0.0f);
            break;
        case eVIEW_RIGHT_CENTER:
            return CGPointMake(size.width, size.height * kHALF_VALUE);
            break;
        case eVIEW_BOTTOM_RIGHT_CORNER:
            return CGPointMake(size.width, size.height);
            break;
        case eVIEW_BOTTOM_CENTER:
            return CGPointMake(size.height * kHALF_VALUE, size.height);
            break;
        case eVIEW_BOTTOM_LEFT_CORNER:
            return CGPointMake(0.0f, size.height);
            break;
        case eVIEW_LEFT_CENTER:
            return CGPointMake(0.0f, size.height * kHALF_VALUE);
            break;
        case eVIEW_TOP_LEFT_CORNER:
            return CGPointMake(0.0f, 0.0f);
            break;
        default:
            NSLog(@"WARNING: Could not find View Alignment: %i", viewAlignment);
            break;
    }
}

+ (CGPoint)point:(CGPoint)parentPoint offsetByPoint:(CGPoint)childOffset
{
    return CGPointMake(parentPoint.x - childOffset.x, parentPoint.y - childOffset.y);
}

+ (CGRect)rectAnimationPercent:(float)percent betweenStartingFrame:(CGRect)staringFrame endingFrame:(CGRect)endingFrame
{
    CGPoint point = [UIView pointPercent:percent betweenStartingPoint:staringFrame.origin endingPoint:endingFrame.origin];
    CGSize size = [UIView size:staringFrame.size mergedWithSize:endingFrame.size];
    
    CGRect rect = {point, size};
    return rect;
}

+ (CGPoint)pointPercent:(float)percent betweenStartingPoint:(CGPoint)staringPoint endingPoint:(CGPoint)endingPoint
{
    CGFloat midX = [UIView percent:percent betweenCoordinate:staringPoint.x coordinate:endingPoint.x];
    CGFloat midY = [UIView percent:percent betweenCoordinate:staringPoint.y coordinate:endingPoint.y];
    
    CGPoint point = CGPointMake(midX, midY);
    
    return point;
}

+ (CGSize)size:(CGSize)parentSize mergedWithSize:(CGSize)childSize
{
    return CGSizeMake((parentSize.width + childSize.width) * kHALF_VALUE, (parentSize.height + childSize.height) * kHALF_VALUE);
}

+ (CGFloat)percent:(float)percent betweenCoordinate:(CGFloat)one coordinate:(CGFloat)two
{
    float _float = ((1.0f - percent) * one + (percent * two));
    return _float;
}

+ (ViewAlignment)adjoiningWithViewAlignment:(ViewAlignment)viewAlignment
{
    ViewAlignment oppositeViewAlignment;
    
    switch (viewAlignment) {
        case eVIEW_TOP_CENTER:
            oppositeViewAlignment = eVIEW_BOTTOM_CENTER;
            break;
        case eVIEW_TOP_RIGHT_CORNER:
            oppositeViewAlignment = eVIEW_BOTTOM_LEFT_CORNER;
            break;
        case eVIEW_RIGHT_CENTER:
            oppositeViewAlignment = eVIEW_LEFT_CENTER;
            break;
        case eVIEW_BOTTOM_RIGHT_CORNER:
            oppositeViewAlignment = eVIEW_TOP_LEFT_CORNER;
            break;
        case eVIEW_BOTTOM_CENTER:
            oppositeViewAlignment = eVIEW_TOP_CENTER;
            break;
        case eVIEW_BOTTOM_LEFT_CORNER:
            oppositeViewAlignment = eVIEW_TOP_RIGHT_CORNER;
            break;
        case eVIEW_LEFT_CENTER:
            oppositeViewAlignment = eVIEW_RIGHT_CENTER;
            break;
        case eVIEW_TOP_LEFT_CORNER:
            oppositeViewAlignment = eVIEW_BOTTOM_RIGHT_CORNER;
            break;
        default:
            break;
    }
    return oppositeViewAlignment;
}

@end
